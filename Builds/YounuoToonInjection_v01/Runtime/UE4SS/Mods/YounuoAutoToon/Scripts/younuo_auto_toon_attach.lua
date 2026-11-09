-- YounuoAutoToon / younuo_auto_toon_attach.lua
--
-- State machine:
--   hook / safety poll -> deferred readiness check
--   gameplay-ready     -> launch YounuoAttach.exe without blocking
--   poll its log       -> confirm success, or bounded retry, or cooldown
--   confirmed          -> ignore every later save/menu event in this process
--
-- The controller has no sleeps and never waits for the EXE.  It only reads a
-- small append-only log on its next tick.

local M = {}

local Controller = {}
Controller.__index = Controller

local function clean_line(value, limit)
    local text = tostring(value or "unknown"):gsub("[\r\n\t]", " ")
    limit = limit or 300
    if #text > limit then
        text = text:sub(1, limit) .. "..."
    end
    return text
end

local function derive_log_path(exe)
    local log = exe:gsub("%.[eE][xX][eE]$", ".log")
    if log == exe then
        log = exe .. ".log"
    end
    return log
end

local function build_command(exe, wait_seconds)
    -- start /b returns immediately.  cmd /s /c strips the outer quote pair.
    -- <NUL keeps YounuoAttach.exe's Console.IsInputRedirected == true so its
    -- failure Pause() cannot leave a hung console process behind.
    local wait = math.floor(tonumber(wait_seconds) or 10)
    local inner = string.format('"%s" --wait %d <NUL', exe, wait)
    return string.format('start "" /b cmd.exe /d /s /c "%s"', inner)
end

function M.new(options)
    local self = setmetatable({}, Controller)
    self.cfg = options.cfg
    self.log = options.log
    self.now = options.now
    self.execute = options.execute
    self.file_exists = options.file_exists
    self.file_size = options.file_size
    self.read_from = options.read_from
    self.readiness = options.readiness
    self.resolve_exe = options.resolve_exe
    self.summary = options.summary or function()
        return "(no summary)"
    end

    self.confirmed = false
    self.dedupe_logged = false
    self.attempt_active = false
    self.pending = false
    self.check_due = 0
    self.check_deadline = 0
    self.check_count = 0
    self.check_reason = "none"
    self.check_quiet = false
    self.last_reason = "idle"
    self.last_status = "idle"
    self.attempt_index = 0
    self.cycle = 0
    self.new_cycle = false
    self.log_offset = 0
    self.log_path = nil
    self.line_buffer = ""
    self.proof_line = nil
    self.failure_line = nil
    self.pipe_name = nil
    self.cooldown_until = 0
    self.next_safety = self.now() + (tonumber(self.cfg.safety_poll_interval) or 10)

    return self
end

function Controller:info(message)
    self.log:info(message)
end

function Controller:error(message)
    self.log:error(message)
end

function Controller:request_check(reason)
    local now = self.now()
    reason = tostring(reason or "unknown")
    local quiet = reason == "safety_poll"

    if self.confirmed then
        if not self.dedupe_logged then
            self:info("dedupe: attach already confirmed in this game process; ignoring later '" .. reason .. "' events")
            self.dedupe_logged = true
        end
        return
    end

    if self.attempt_active then
        self:info("check '" .. reason .. "' ignored: an attach attempt is still in progress")
        return
    end

    if now < self.cooldown_until then
        if not quiet then
            self:info(string.format("check '%s' ignored: cooldown %.0fs remaining", reason,
                self.cooldown_until - now))
        end
        return
    end

    if self.pending then
        -- A real hook outranks a quiet safety poll and gets the full readiness
        -- window (a hook may arrive while a short safety probe is pending).
        if not quiet then
            self.check_quiet = false
            self.check_reason = reason
            local window = tonumber(self.cfg.readiness_window) or 30
            if self.check_deadline < now + window then
                self.check_deadline = now + window
            end
            local initial_delay = tonumber(self.cfg.readiness_initial_delay) or 1
            if self.check_due > now + initial_delay then
                self.check_due = now + initial_delay
            end
        end
        return
    end

    local initial_delay = tonumber(self.cfg.readiness_initial_delay) or 1
    self.pending = true
    self.check_quiet = quiet
    self.check_reason = reason
    self.check_due = now + initial_delay
    if quiet then
        -- A safety poll is one cheap probe, not a 30-second busy window.
        self.check_deadline = now + initial_delay + 0.1
    else
        self.check_deadline = now + (tonumber(self.cfg.readiness_window) or 30)
    end
    self.check_count = 0
    self.last_reason = "pending"
    self.new_cycle = true

    if not quiet then
        self:info("readiness requested by " .. reason)
    end
end

function Controller:tick()
    local now = self.now()

    if self.confirmed then
        return
    end

    if self.attempt_active then
        self:poll(now)
        return
    end

    if not self.pending then
        local interval = tonumber(self.cfg.safety_poll_interval) or 0
        if interval > 0 and now >= self.next_safety then
            self.next_safety = now + interval
            self:request_check("safety_poll")
        end
        return
    end

    if now < self.check_due then
        return
    end

    if now > self.check_deadline then
        self.pending = false
        if not self.check_quiet then
            self:info(string.format("readiness window expired after %d checks; last=%s",
                self.check_count, tostring(self.last_reason)))
        end
        return
    end

    local ok, ready, reason, facts = pcall(self.readiness)
    if not ok then
        local error_value = ready
        ready = false
        reason = "readiness error: " .. tostring(error_value)
        facts = {}
    end

    self.last_reason = reason or "unknown"
    if not ready then
        self.check_count = self.check_count + 1
        if not self.check_quiet and (self.check_count == 1 or self.check_count % 4 == 0) then
            self:info("not gameplay-ready (" .. clean_line(self.last_reason) .. ")")
        end

        if self.check_count >= (tonumber(self.cfg.readiness_max_checks) or 24) then
            self.pending = false
            if not self.check_quiet then
                self:info("readiness check budget exhausted; waiting for the next hook")
            end
        else
            self.check_due = now + (tonumber(self.cfg.readiness_retry_interval) or 1.5)
        end
        return
    end

    self.pending = false
    local summary_ok, summary = pcall(self.summary, facts)
    self:info("gameplay-ready: " .. (summary_ok and tostring(summary) or "(summary unavailable)"))

    if self.new_cycle then
        self:start_cycle(now)
    else
        -- A retry after a failed attempt must keep the bounded attempt index.
        self:start_attempt(now)
    end
end

function Controller:start_cycle(now)
    self.new_cycle = false
    self.attempt_index = 0
    self.cycle = self.cycle + 1
    self.line_buffer = ""
    self.proof_line = nil
    self.failure_line = nil
    self.pipe_name = nil
    self:info(string.format("attach cycle %d started", self.cycle))
    self:start_attempt(now)
end

function Controller:start_attempt(now)
    if self.confirmed or self.attempt_active then
        return
    end

    if now < self.cooldown_until then
        return
    end

    local max_attempts = tonumber(self.cfg.attach_attempts) or 3
    if self.attempt_index >= max_attempts then
        self.pending = false
        self.cooldown_until = now + (tonumber(self.cfg.failure_cooldown) or 60)
        self.last_status = "failed_exhausted"
        return
    end

    local exe, detail = self.resolve_exe()
    if not exe then
        self:error("YounuoAttach.exe not found. Tried: " .. clean_line(detail, 600))
        self.pending = false
        self.cooldown_until = now + (tonumber(self.cfg.missing_exe_cooldown) or 300)
        self.last_status = "missing_exe"
        return
    end

    local exists_ok, exists = pcall(self.file_exists, exe)
    if not exists_ok or not exists then
        self:error("YounuoAttach.exe is not readable: " .. clean_line(exe))
        self.pending = false
        self.cooldown_until = now + (tonumber(self.cfg.missing_exe_cooldown) or 300)
        self.last_status = "missing_exe"
        return
    end

    local log_path = self.cfg.attach_log
    if not log_path or log_path == "" then
        log_path = derive_log_path(exe)
    end

    local size_ok, offset = pcall(self.file_size, log_path)
    if not size_ok or type(offset) ~= "number" then
        offset = 0
    end

    local wait_seconds = tonumber(self.cfg.attach_wait_seconds) or 10
    local command = build_command(exe, wait_seconds)

    self:info(string.format("attach attempt %d/%d: launch (non-blocking) %s",
        self.attempt_index + 1, max_attempts, command))

    local call_ok, spawned, spawn_detail = pcall(self.execute, command)
    if not call_ok or not spawned then
        self:handle_failure(now, "spawn failed: " .. clean_line(spawn_detail or "unknown"))
        return
    end

    self.attempt_active = true
    self.log_path = log_path
    self.log_offset = offset
    self.line_buffer = ""
    self.proof_line = nil
    self.failure_line = nil
    self.pipe_name = nil
    self.attempt_started = now
    self.attempt_deadline = now + (tonumber(self.cfg.attach_result_timeout) or 60)
    self.last_status = "attaching"
end

function Controller:poll(now)
    local read_ok, data, new_offset = pcall(self.read_from, self.log_path, self.log_offset)
    if not read_ok then
        data = nil
    end
    if type(data) ~= "string" then
        data = ""
    end
    if type(new_offset) ~= "number" then
        new_offset = self.log_offset
    end

    if new_offset < self.log_offset then
        -- The log was truncated/rotated.  Never parse old bytes, because an old
        -- success line would create a false positive.
        self.log_offset = new_offset
        self.line_buffer = ""
        data = ""
        self:info("attach log shrank; ignoring old content")
    else
        self.log_offset = new_offset
    end

    local verdict = self:consume(data)
    if verdict == "success" then
        self.confirmed = true
        self.attempt_active = false
        self.pending = false
        self.last_status = "attached"
        self:info("ATTACH CONFIRMED: " .. clean_line(self.proof_line, 400))
        if self.pipe_name then
            self:info("attach pipe proof: " .. clean_line(self.pipe_name, 200))
        end
        self:info("dedupe armed: one successful attach per game process; later save/menu hooks will not launch the EXE")
        return
    end

    if verdict == "failure" then
        self.attempt_active = false
        self:handle_failure(now, self.failure_line or "attach failed")
        return
    end

    if now >= self.attempt_deadline then
        -- The EXE is launched detached and may still be alive.  Retrying here
        -- could start a second client, so this is intentionally terminal.
        self.attempt_active = false
        self.attempt_index = tonumber(self.cfg.attach_attempts) or 3
        self.pending = false
        self.cooldown_until = now + (tonumber(self.cfg.failure_cooldown) or 60)
        self.last_status = "timeout"
        self:error("attach result timeout; not retrying automatically to avoid a duplicate attach")
    end
end

function Controller:consume(data)
    if data == "" then
        return nil
    end

    self.line_buffer = (self.line_buffer or "") .. data
    if #self.line_buffer > 65536 then
        self.line_buffer = self.line_buffer:sub(-32768)
    end

    while true do
        local newline = self.line_buffer:find("\n", 1, true)
        if not newline then
            break
        end

        local line = self.line_buffer:sub(1, newline - 1):gsub("\r$", "")
        self.line_buffer = self.line_buffer:sub(newline + 1)
        if line ~= "" then
            local verdict = self:classify(line)
            if verdict then
                return verdict
            end
        end
    end

    return nil
end

function Controller:classify(line)
    if line:find("pipe:", 1, true) and line:find("renodx-devkit-mcp", 1, true) then
        self.pipe_name = line
        return nil
    end

    if line:find("attached: toon takeover is live", 1, true) then
        self.proof_line = line
        return "success"
    end

    if line:find("no renodx-devkit-mcp", 1, true)
        or line:find("attach failed:", 1, true)
        or line:find("timed out talking", 1, true)
        or line:find("attach returned without 'activated'", 1, true) then
        self.failure_line = line
        return "failure"
    end

    return nil
end

function Controller:handle_failure(now, reason)
    reason = clean_line(reason)
    self.attempt_index = self.attempt_index + 1

    local max_attempts = tonumber(self.cfg.attach_attempts) or 3
    if self.attempt_index < max_attempts then
        local delays = self.cfg.attach_retry_delays or {}
        local delay = tonumber(delays[self.attempt_index]) or 3
        self.pending = true
        self.new_cycle = false
        self.check_quiet = false
        self.check_reason = "retry_after_failure"
        self.check_count = 0
        self.check_due = now + delay
        self.check_deadline = now + delay + (tonumber(self.cfg.readiness_window) or 30)
        self.last_status = "retry_scheduled"
        self:info(string.format("attach attempt %d/%d failed (%s); retry in %.0fs",
            self.attempt_index, max_attempts, reason, delay))
        return
    end

    self.pending = false
    self.last_status = "failed_exhausted"
    self.cooldown_until = now + (tonumber(self.cfg.failure_cooldown) or 60)
    self:error(string.format("attach failed after %d bounded attempts (%s); cooldown %.0fs",
        self.attempt_index, reason, tonumber(self.cfg.failure_cooldown) or 60))
end

function Controller:status()
    return {
        confirmed = self.confirmed,
        attempt_active = self.attempt_active,
        pending = self.pending,
        attempt_index = self.attempt_index,
        cycle = self.cycle,
        last_status = self.last_status,
        last_reason = self.last_reason,
        cooldown_until = self.cooldown_until,
        log_path = self.log_path,
    }
end

M.Controller = Controller
M.derive_log_path = derive_log_path
M.build_command = build_command

return M
