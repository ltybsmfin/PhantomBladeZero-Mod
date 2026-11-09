-- YounuoAutoToon / younuo_auto_toon_readiness.lua
--
-- Pure predicate over a facts table produced by younuo_auto_toon_adapter.lua.  Keeping it
-- pure makes the menu / pawn / world rules testable without launching the game.

local M = {}

local function lower(value)
    if value == nil then
        return ""
    end
    return tostring(value):lower()
end

local function contains_any(text, patterns)
    if not text or not patterns then
        return nil
    end
    local haystack = lower(text)
    for _, pattern in ipairs(patterns) do
        local needle = lower(pattern)
        if needle ~= "" and haystack:find(needle, 1, true) then
            return pattern
        end
    end
    return nil
end

local function number_or_nil(value)
    if value == nil then
        return nil
    end
    local number = tonumber(value)
    if number == nil then
        return nil
    end
    if number ~= number or number == math.huge or number == -math.huge then
        return nil
    end
    return number
end

--- Evaluate readiness.
-- @param facts table from ue4ss_adapter.describe()
-- @param cfg config table
-- @return boolean ready, string reason, table facts
function M.evaluate(facts, cfg)
    facts = facts or {}
    cfg = cfg or {}

    if facts.controller_valid ~= true then
        return false, "no player controller", facts
    end

    if facts.controller_is_player == false then
        return false, "controller is not a player controller", facts
    end

    local denied_state = contains_any(lower(facts.controller_state), cfg.denied_controller_states)
    if denied_state then
        return false, "controller is not in gameplay state (" .. tostring(denied_state) .. "): " ..
            tostring(facts.controller_state), facts
    end

    local pawn_class = lower(facts.pawn_class)
    local denied_pawn = contains_any(pawn_class, cfg.denied_pawn_patterns)
    if denied_pawn then
        return false, "non-gameplay pawn class (" .. tostring(denied_pawn) .. "): " .. tostring(facts.pawn_class), facts
    end

    if facts.controller_pawn_matches == false then
        return false, "controller pawn is not the pawn under test", facts
    end

    if facts.pawn_valid ~= true then
        return false, "no valid gameplay pawn", facts
    end

    if facts.pawn_has_mesh ~= true or facts.mesh_valid ~= true then
        return false, "pawn has no valid skeletal mesh component", facts
    end

    if facts.mesh_asset_valid ~= true then
        return false, "skeletal mesh asset is not valid", facts
    end

    local bones = number_or_nil(facts.bone_count)
    if bones == nil or bones <= 0 then
        return false, "skeletal mesh has no bones (" .. tostring(facts.bone_count) .. ")", facts
    end

    if cfg.require_player_state and facts.player_state_valid ~= true then
        return false, "player state is not valid yet", facts
    end

    if facts.world_valid ~= true then
        return false, "no valid world", facts
    end

    local world_text = tostring(facts.world_name or "") .. " " .. tostring(facts.world_full_name or "")
    local menu_pattern = contains_any(world_text, cfg.menu_world_patterns)
    if menu_pattern then
        return false, "menu/frontend world (" .. tostring(menu_pattern) .. "): " .. tostring(facts.world_name), facts
    end

    if facts.world_tearing_down == true then
        return false, "world is tearing down", facts
    end

    if facts.world_being_cleaned_up == true then
        return false, "world is being cleaned up", facts
    end

    if facts.world_is_default_level == true then
        return false, "default/transition level is active", facts
    end

    if cfg.require_begun_play and facts.world_begun_play == false then
        return false, "world has not begun play (bBegunPlay=" .. tostring(facts.world_begun_play) .. ")", facts
    end

    if facts.world_initialized == false then
        return false, "world is not initialized", facts
    end

    if cfg.require_persistent_level and facts.persistent_level_valid ~= true then
        return false, "world has no valid persistent level", facts
    end

    if cfg.require_game_state and facts.game_state_valid ~= true then
        return false, "world game state is not valid yet", facts
    end

    local players = number_or_nil(facts.player_num)
    if cfg.require_player_num and players ~= nil and players <= 0 then
        return false, "world reports no players (" .. tostring(players) .. ")", facts
    end

    if cfg.require_same_world and facts.same_world == false then
        return false, "pawn and controller/world do not agree", facts
    end

    if facts.pawn_location_valid == false then
        return false, "pawn location is not finite", facts
    end

    if cfg.require_younuo_pawn then
        local allowed = contains_any(pawn_class, cfg.younuo_pawn_patterns)
        if not allowed then
            return false, "not a configured Younuo pawn: " .. tostring(facts.pawn_class), facts
        end
    end

    return true, "gameplay-ready", facts
end

function M.summary(facts)
    facts = facts or {}
    return string.format(
        "pawn=%s world=%s(%s) bones=%s begun=%s player_state=%s players=%s menu_world=%s",
        tostring(facts.pawn_class or "?"),
        tostring(facts.world_name or "?"),
        tostring(facts.world_full_name or "?"),
        tostring(facts.bone_count or "?"),
        tostring(facts.world_begun_play),
        tostring(facts.player_state_valid),
        tostring(facts.player_num),
        tostring(facts.menu_world or "no")
    )
end

return M
