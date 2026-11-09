-- YounuoAutoToon / main.lua
--
-- Entry point loaded by UE4SS when this folder has enabled.txt.
--
-- Trigger points (both confirmed in the installed UE4SS 3.0.1 mods):
--   RegisterLoadMapPostHook(function(Engine, World))
--   RegisterHook("/Script/Engine.PlayerController:ClientRestart", function(self, NewPawn))
--
-- The callbacks only request a deferred readiness check.  The real work happens
-- in a 500 ms game-thread ticker and never blocks waiting for the renderer pipe.

local CONFIG = require("younuo_auto_toon_config")
local Log = require("younuo_auto_toon_log")
local Readiness = require("younuo_auto_toon_readiness")
local Adapter = require("younuo_auto_toon_adapter")
local Attach = require("younuo_auto_toon_attach")

local logger = Log.new(CONFIG)

local ok_helpers, UEHelpers = pcall(require, "UEHelpers")
if not ok_helpers or not UEHelpers then
    logger:error("UEHelpers is unavailable; YounuoAutoToon cannot read the player/world: " .. tostring(UEHelpers))
    return
end

local function file_exists(path)
    if not path or path == "" then
        return false
    end
    local ok, file = pcall(io.open, path, "rb")
    if not ok or not file then
        return false
    end
    pcall(function()
        file:close()
    end)
    return true
end

local function file_size(path)
    if not path or path == "" then
        return 0
    end
    local ok, file = pcall(io.open, path, "rb")
    if not ok or not file then
        return 0
    end
    local size = 0
    pcall(function()
        size = file:seek("end") or 0
    end)
    pcall(function()
        file:close()
    end)
    return size
end

local function read_from(path, offset)
    offset = tonumber(offset) or 0
    if not path or path == "" then
        return "", offset
    end
    local ok, file = pcall(io.open, path, "rb")
    if not ok or not file then
        return "", offset
    end

    local size = tonumber(file:seek("end")) or 0
    if size < offset then
        offset = 0
    end

    local data = ""
    pcall(function()
        file:seek("set", offset)
        data = file:read("a") or ""
    end)
    local new_offset = offset + #data
    pcall(function()
        file:close()
    end)
    return data, new_offset
end

local function execute(command)
    if type(os.execute) == "function" then
        local ok, why, code = os.execute(command)
        local success = (ok == true) or (ok == 0) or (why == "exit" and code == 0)
        return success, string.format("os.execute ok=%s why=%s code=%s",
            tostring(ok), tostring(why), tostring(code))
    end

    -- Fallback for a build that exposes popen but not execute.  `start` exits
    -- immediately, so pclose() does not wait for the attach process.
    if type(io.popen) == "function" then
        local ok, pipe = pcall(io.popen, command, "r")
        if ok and pipe then
            pcall(function()
                pipe:close()
            end)
            return true, "io.popen"
        end
    end

    return false, "neither os.execute nor io.popen is available"
end

local function resolve_exe()
    local configured = CONFIG.attach_exe
    if configured and configured ~= "" then
        if configured:match("^%a:[/\\]") or configured:match("^[/\\]") then
            return configured
        end
        if CONFIG.game_root then
            return CONFIG.game_root .. "/" .. configured
        end
        return configured
    end

    local tried = {}
    for _, candidate in ipairs(CONFIG.attach_exe_candidates or {}) do
        tried[#tried + 1] = candidate
        if file_exists(candidate) then
            return candidate
        end
    end

    return nil, table.concat(tried, ", ")
end

local function readiness()
    local ok, facts = pcall(Adapter.describe, UEHelpers, CONFIG)
    if not ok then
        return false, "adapter error: " .. tostring(facts), {}
    end
    return Readiness.evaluate(facts, CONFIG)
end

local controller = Attach.new({
    cfg = CONFIG,
    log = logger,
    now = function()
        return os.time()
    end,
    execute = execute,
    file_exists = file_exists,
    file_size = file_size,
    read_from = read_from,
    readiness = readiness,
    resolve_exe = resolve_exe,
    summary = Readiness.summary,
})

local function request(reason)
    local ok, err = pcall(controller.request_check, controller, reason)
    if not ok then
        logger:error("request_check('" .. tostring(reason) .. "') failed: " .. tostring(err))
    end
end

logger:info("v0.1 loaded")
logger:info(string.format("policy: deferred hooks + readiness filter; attach attempts=%d wait=%ss timeout=%ss",
    CONFIG.attach_attempts, tostring(CONFIG.attach_wait_seconds), tostring(CONFIG.attach_result_timeout)))
logger:info("dedupe assumption: devkit live shader takeover is device-scoped and survives level travel; " ..
    "one confirmed attach is allowed per game process.  YounuoAttach.exe is run without --watch.")
logger:info("EXE candidates: " .. table.concat(CONFIG.attach_exe_candidates or {}, ", "))

local hooks = {}

local function install_hook(label, install)
    local ok, err = pcall(install)
    if ok then
        hooks[#hooks + 1] = label
        logger:info("hook active: " .. label)
    else
        logger:error("hook unavailable: " .. label .. ": " .. tostring(err))
    end
end

install_hook("LoadMapPost", function()
    RegisterLoadMapPostHook(function(Engine, World)
        request("loadmap_post")
    end)
end)

install_hook("PlayerController:ClientRestart", function()
    RegisterHook("/Script/Engine.PlayerController:ClientRestart", function(self, NewPawn)
        request("client_restart")
    end)
end)

local ticker_ok, ticker_error = pcall(function()
    return LoopInGameThreadWithDelay(CONFIG.tick_ms, function()
        local ok, err = pcall(controller.tick, controller)
        if not ok then
            logger:error("tick failed: " .. tostring(err))
        end
    end)
end)

if not ticker_ok then
    logger:error("LoopInGameThreadWithDelay failed: " .. tostring(ticker_error))
else
    logger:info("game-thread ticker active every " .. tostring(CONFIG.tick_ms) .. " ms")
end

if type(ExecuteInGameThread) == "function" then
    ExecuteInGameThread(function()
        request("module_start")
    end)
else
    request("module_start")
end
