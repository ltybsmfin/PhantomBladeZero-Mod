-- YounuoAutoToon / younuo_auto_toon_log.lua
--
-- Two proofs for every important decision:
--   1. print()  -> UE4SS console + UE4SS.log
--   2. append    -> <mod>/YounuoAutoToon.log (survives a long UE4SS.log)

local M = {}

local function append_file(path, line)
    if not path then
        return
    end
    local ok, file = pcall(io.open, path, "a")
    if not ok or not file then
        return
    end
    pcall(function()
        file:write(os.date("%Y-%m-%d %H:%M:%S "), line, "\n")
        file:flush()
    end)
    pcall(function()
        file:close()
    end)
end

function M.new(config)
    local self = {
        config = config or {},
        prefix = "[YounuoAutoToon] ",
    }

    function self:info(message)
        local line = self.prefix .. tostring(message)
        print(line .. "\n")
        append_file(self.config.module_log, line)
    end

    function self:warn(message)
        self:info("WARN: " .. tostring(message))
    end

    function self:error(message)
        self:info("ERROR: " .. tostring(message))
    end

    return self
end

return M
