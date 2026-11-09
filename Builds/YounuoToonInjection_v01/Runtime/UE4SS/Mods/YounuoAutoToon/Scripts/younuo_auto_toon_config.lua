-- YounuoAutoToon / younuo_auto_toon_config.lua
--
-- Self-contained runtime configuration.  No game files, no mods.txt edits and
-- no renderer files are touched by this module.
--
-- Path layout assumed when installed:
--   <game>/ue4ss/Mods/YounuoAutoToon/Scripts/config.lua
--   <game>/YounuoAttach.exe                 (existing user EXE)
--   <game>/YounuoAttach.log                 (written by that EXE)
--
-- If the EXE lives somewhere else, set attach_exe to an absolute path.

local M = {}

local function script_directory()
    -- debug.getinfo works in UE4SS Lua 5.4.  package.searchpath is a fallback
    -- for environments that hide the debug library.
    -- Use an anonymous Lua function: pcall(debug.getinfo, ...) would make
    -- level 1 the C pcall frame, not this file.
    local ok, info = pcall(function()
        return debug.getinfo(1, "S")
    end)
    if ok and info and info.source then
        local source = tostring(info.source):gsub("^@", "")
        local dir = source:match("^(.*)[/\\][^/\\]+$")
        if dir then
            return (dir:gsub("\\", "/"))
        end
    end

    local ok2, path = pcall(function()
        return package.searchpath("younuo_auto_toon_config", package.path)
    end)
    if ok2 and path then
        local dir = path:match("^(.*)[/\\][^/\\]+$")
        if dir then
            return (dir:gsub("\\", "/"))
        end
    end

    return nil
end

local script_dir = script_directory()
local mod_dir = script_dir and script_dir:gsub("/Scripts$", "") or nil
-- Scripts/.. -> YounuoAutoToon, ../.. -> Mods, ../../.. -> ue4ss,
-- ../../../.. -> platform/steam (the directory containing YounuoAttach.exe).
local game_root = script_dir and (script_dir .. "/../../../..") or nil

M.script_dir = script_dir
M.mod_dir = mod_dir
M.game_root = game_root

-- ---------------------------------------------------------------------------
-- Attach executable
-- ---------------------------------------------------------------------------

-- nil = auto-detect from attach_exe_candidates, in order.
M.attach_exe = nil

M.attach_exe_candidates = {}
if game_root then
    -- The user's existing EXE lives beside PBZ.exe.  Do not silently pick up a
    -- stale copy from a Tools/ folder; set attach_exe explicitly if needed.
    M.attach_exe_candidates[#M.attach_exe_candidates + 1] = game_root .. "/YounuoAttach.exe"
end

-- nil = derive from the selected EXE by replacing .exe with .log.
M.attach_log = nil

-- Module-side proof log.  UE4SS.log also receives every print() line.
M.module_log = mod_dir and (mod_dir .. "/YounuoAutoToon.log") or nil

-- ---------------------------------------------------------------------------
-- Non-blocking attach launch / bounded retries
-- ---------------------------------------------------------------------------

-- Passed to YounuoAttach.exe --wait.  The EXE itself polls the named pipe;
-- this process must never block the game thread.
M.attach_wait_seconds = 10

-- How long we wait for the EXE to append a success/failure line.
-- YounuoAttach.exe internally allows up to 45 s for the devkit call after the
-- pipe appears, so this must exceed wait + 45 s; otherwise a slow but valid
-- attach would be misclassified as a timeout.
M.attach_result_timeout = 60

-- Hard bound: one readiness cycle may launch at most this many EXE processes.
M.attach_attempts = 3

-- Delay before each retry (index 1 = after first failure).  Length should be
-- attach_attempts - 1; a missing entry falls back to 3 seconds.
M.attach_retry_delays = { 3, 6 }

-- After the bounded attempts are exhausted, ignore new hooks this long.
M.failure_cooldown = 60

-- If YounuoAttach.exe is absent, do not spin; re-check after this long.
M.missing_exe_cooldown = 300

-- ---------------------------------------------------------------------------
-- Readiness / hook timing
-- ---------------------------------------------------------------------------

M.tick_ms = 500

-- After ClientRestart / LoadMapPost, give the world a moment to settle.
M.readiness_initial_delay = 1.0
M.readiness_retry_interval = 1.5
M.readiness_window = 30
M.readiness_max_checks = 24

-- Low-frequency fallback in case both hooks fired before this module loaded
-- (or the world took longer than readiness_window to become usable).  The
-- readiness predicate itself rejects menus, so this cannot attach from a menu
-- that has no usable gameplay pawn.
M.safety_poll_interval = 10

-- ---------------------------------------------------------------------------
-- Readiness predicate tuning
-- ---------------------------------------------------------------------------

-- World names / full paths containing any of these are treated as menus,
-- frontends, lobbies or character-select screens, never gameplay.
M.menu_world_patterns = {
    "mainmenu",
    "main_menu",
    "menu",
    "lobby",
    "login",
    "title",
    "frontend",
    "startup",
    "entrylevel",
    "entry_level",
    "charselect",
    "character_select",
}

-- Pawns that are never the in-save gameplay character.
M.denied_pawn_patterns = {
    "defaultpawn",
    "spectatorpawn",
    "observerpawn",
    "camerapawn",
    "menupawn",
    "lobbypawn",
    "spectator",
    "editorpawn",
}

-- Optional stricter mode.  The default accepts any real player character with
-- a usable skeletal mesh; set this true to require a Hun/Younuo pawn class.
M.require_younuo_pawn = true
M.younuo_pawn_patterns = {
    "renewal_hun",
    "player_hero_hun",
    "hero_hun",
}

-- Optional extra menu signal.  Only states that are clearly not walking around
-- are denied; an unavailable GetStateName() is ignored.
M.denied_controller_states = {
    "inactive",
    "waiting",
    "spectating",
}

M.require_player_state = false
M.require_begun_play = true
M.require_game_state = false
M.require_persistent_level = false
M.require_same_world = true
M.require_player_num = true

return M
