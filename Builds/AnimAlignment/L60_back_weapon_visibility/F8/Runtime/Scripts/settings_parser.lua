-- Pure settings parser for the Younuo F8 panel.
--
-- Protocol v2 is a UTF-8 key=value file. Known keys are validated strictly and
-- any invalid known value rejects the whole file. Unknown keys are ignored.
-- A duplicate known key also rejects the whole file. The legacy format is a
-- three-integer line mapping to hair, chest and skirt.
local M = {}

local DEFAULT_BAREFOOT = 0.944533035

local function copyDefaults()
    return {
        version = 2,
        hair = 50,
        chest = 50,
        skirt = 50,
        skirt_physics = 1,
        skirt_self_collision = 1,
        skirt_collision_scope = "adjacent",
        skirt_precision = "normal",
        shoes_visible = 1,
        barefoot_pose = 1,
        barefoot_height_cm = DEFAULT_BAREFOOT,
        back_weapons_visible = 1,
    }
end

M.DEFAULTS = copyDefaults()

M.KNOWN_KEYS = {
    version = true, hair = true, chest = true, skirt = true,
    skirt_physics = true, skirt_self_collision = true,
    skirt_collision_scope = true, skirt_precision = true,
    shoes_visible = true, barefoot_pose = true, barefoot_height_cm = true,
    back_weapons_visible = true,
}

local function trim(text)
    return (text:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function finite(number)
    return type(number) == "number" and number == number
        and number ~= math.huge and number ~= -math.huge
end

local function isInteger(text)
    return text:match("^%d+$") ~= nil
end

local function fail(errors, line, message)
    errors[#errors + 1] = "line " .. tostring(line) .. ": " .. message
end

local enumValues = {
    skirt_collision_scope = { adjacent = true, all = true },
    skirt_precision = { low = true, normal = true, high = true },
}

-- Returns settings, or nil plus an error list. The error list is ordered by
-- line so the status file can show a truthful reason for the rejection.
function M.parse(text)
    if type(text) ~= "string" then return nil, { "settings file is not readable text" } end
    text = text:gsub("^\239\187\191", "")      -- UTF-8 BOM
    text = text:gsub("\r\n", "\n"):gsub("\r", "\n")

    if text:find("=", 1, true) == nil then
        local a, b, c = text:match("^%s*(%d+)%s+(%d+)%s+(%d+)%s*$")
        if not a then
            return nil, { "legacy settings must be exactly three integers" }
        end
        local values = { tonumber(a), tonumber(b), tonumber(c) }
        for index, value in ipairs(values) do
            if value > 100 then
                return nil, { "legacy value " .. tostring(index) .. " is outside 0..100" }
            end
        end
        local settings = copyDefaults()
        settings.hair, settings.chest, settings.skirt = values[1], values[2], values[3]
        settings.source = "legacy3"
        return settings
    end

    local settings = copyDefaults()
    local seen = {}
    local errors = {}
    local lineNumber = 0
    local lineCount = 0

    for raw in (text .. "\n"):gmatch("(.-)\n") do
        lineNumber = lineNumber + 1
        local line = trim(raw)
        if line ~= "" and line:sub(1, 1) ~= "#" and line:sub(1, 1) ~= ";" then
            lineCount = lineCount + 1
            local key, value = line:match("^([^=]+)=(.*)$")
            if not key then
                fail(errors, lineNumber, "expected key=value")
            else
                key = trim(key):lower()
                value = trim(value)
                if not key:match("^[a-z_][a-z0-9_]*$") then
                    fail(errors, lineNumber, "invalid key name")
                elseif M.KNOWN_KEYS[key] and seen[key] then
                    fail(errors, lineNumber, "duplicate key '" .. key .. "'")
                elseif M.KNOWN_KEYS[key] then
                    seen[key] = true
                    if key == "version" then
                        if value ~= "2" then
                            fail(errors, lineNumber, "version must be 2")
                        end
                    elseif key == "hair" or key == "chest" or key == "skirt" then
                        if not isInteger(value) then
                            fail(errors, lineNumber, key .. " must be an integer")
                        else
                            local number = tonumber(value)
                            if number < 0 or number > 100 then
                                fail(errors, lineNumber, key .. " must be in 0..100")
                            else
                                settings[key] = number
                            end
                        end
                    elseif key == "skirt_physics"
                        or key == "skirt_self_collision"
                        or key == "shoes_visible"
                        or key == "barefoot_pose"
                        or key == "back_weapons_visible" then
                        if value ~= "0" and value ~= "1" then
                            fail(errors, lineNumber, key .. " must be 0 or 1")
                        else
                            settings[key] = tonumber(value)
                        end
                    elseif key == "skirt_collision_scope"
                        or key == "skirt_precision" then
                        local lowered = value:lower()
                        if not enumValues[key][lowered] then
                            fail(errors, lineNumber, key .. " has an invalid value")
                        else
                            settings[key] = lowered
                        end
                    elseif key == "barefoot_height_cm" then
                        local number = tonumber(value)
                        if not finite(number) or number < 0 or number > 20 then
                            fail(errors, lineNumber, "barefoot_height_cm must be finite in 0..20")
                        else
                            settings[key] = number
                        end
                    end
                end
                -- Unknown keys are intentionally ignored.
            end
        end
    end

    if #errors > 0 then return nil, errors end
    if lineCount == 0 then return nil, { "settings file contains no keys" } end
    settings.source = "v2"
    return settings
end

return M
