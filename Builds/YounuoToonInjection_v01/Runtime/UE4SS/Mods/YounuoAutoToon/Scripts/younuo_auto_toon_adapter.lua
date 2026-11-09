-- YounuoAutoToon / younuo_auto_toon_adapter.lua
--
-- Reads only public UE4SS / UE reflection data.  Every access is pcall-guarded
-- so a temporary null during level travel produces a readable reason instead
-- of a Lua error in the game thread.

local M = {}

local function safe_call(object, method, ...)
    if object == nil then
        return nil
    end
    local ok, result = pcall(function(...)
        return object[method](object, ...)
    end, ...)
    if ok then
        return result
    end
    return nil
end

local function safe_prop(object, field)
    if object == nil then
        return nil
    end
    local ok, result = pcall(function()
        return object[field]
    end)
    if ok then
        return result
    end
    return nil
end

local function is_valid(object)
    if object == nil then
        return false
    end
    local ok, result = pcall(function()
        return object:IsValid()
    end)
    return ok and result == true
end

local function as_text(value)
    if value == nil then
        return nil
    end
    local ok, result = pcall(function()
        return value:ToString()
    end)
    if ok and result ~= nil then
        return tostring(result)
    end
    return tostring(value)
end

local function object_name(object)
    return as_text(safe_call(object, "GetName"))
end

local function object_full_name(object)
    return as_text(safe_call(object, "GetFullName"))
end

local function class_name(object)
    -- The game's UE4SS build exposes the actor's full name even when GetClass cannot be called.
    local full_name = object_full_name(object)
    local prefix = full_name and full_name:match("^(%S+)%s+")
    if prefix then return prefix end
    local class = safe_call(object, "GetClass")
    return as_text(safe_call(class, "GetName"))
end

local function address_of(object)
    if object == nil then
        return nil
    end
    local ok, result = pcall(function()
        return object:GetAddress()
    end)
    if ok then
        return result
    end
    return nil
end

local function same_object(a, b)
    if a == nil or b == nil then
        return nil
    end
    if a == b then
        return true
    end
    local a_address = address_of(a)
    local b_address = address_of(b)
    if a_address ~= nil and b_address ~= nil then
        return a_address == b_address
    end
    return nil
end

local function as_bool(value)
    if value == true or value == false then
        return value
    end
    if value == nil then
        return nil
    end
    if value == 1 then
        return true
    end
    if value == 0 then
        return false
    end
    local text = tostring(value):lower()
    if text == "true" or text == "1" then
        return true
    end
    if text == "false" or text == "0" then
        return false
    end
    return nil
end

local function finite_vector(location)
    if location == nil then
        return nil
    end
    local x = tonumber(location.X)
    local y = tonumber(location.Y)
    local z = tonumber(location.Z)
    if x == nil or y == nil or z == nil then
        return nil
    end
    for _, value in ipairs({ x, y, z }) do
        if value ~= value or value == math.huge or value == -math.huge then
            return false
        end
    end
    return true
end

--- Build a facts table for readiness.evaluate().
-- @param UEHelpers shared UEHelpers module
-- @param cfg config table (currently only used for future policy switches)
-- @return table
function M.describe(UEHelpers, cfg)
    local facts = {}

    local controller = nil
    if UEHelpers and type(UEHelpers.GetPlayerController) == "function" then
        local ok, result = pcall(UEHelpers.GetPlayerController)
        if ok then
            controller = result
        end
    end

    facts.controller_valid = is_valid(controller)
    if not facts.controller_valid then
        return facts
    end

    local is_player = safe_call(controller, "IsPlayerController")
    if is_player == nil then
        is_player = safe_call(controller, "IsLocalPlayerController")
    end
    facts.controller_is_player = as_bool(is_player)
    facts.controller_state = as_text(safe_call(controller, "GetStateName"))

    local controller_pawn = safe_prop(controller, "Pawn")
    if not is_valid(controller_pawn) then
        local candidate = safe_call(controller, "GetPawn")
        if is_valid(candidate) then
            controller_pawn = candidate
        end
    end

    local pawn = controller_pawn
    facts.pawn_valid = is_valid(pawn)
    if not facts.pawn_valid then
        return facts
    end

    facts.pawn_class = class_name(pawn)

    -- Consistency check only when the engine actually exposes GetPawn().
    -- controller.Pawn is authoritative, so an unavailable getter must not
    -- become a false negative.
    local get_pawn = safe_call(controller, "GetPawn")
    if is_valid(get_pawn) then
        facts.controller_pawn_matches = same_object(controller_pawn, get_pawn)
    end

    local mesh = safe_prop(pawn, "Mesh")
    if not is_valid(mesh) then
        local candidate = safe_call(pawn, "GetMesh")
        if is_valid(candidate) then
            mesh = candidate
        end
    end

    facts.pawn_has_mesh = is_valid(mesh)
    facts.mesh_valid = facts.pawn_has_mesh

    local mesh_asset = nil
    if facts.mesh_valid then
        mesh_asset = safe_call(mesh, "GetSkeletalMeshAsset")
        if not is_valid(mesh_asset) then
            local candidate = safe_prop(mesh, "SkeletalMesh")
            if is_valid(candidate) then
                mesh_asset = candidate
            end
        end
        facts.mesh_asset_valid = is_valid(mesh_asset)
        facts.bone_count = tonumber(safe_call(mesh, "GetNumBones"))
    end

    local player_state = safe_prop(controller, "PlayerState")
    facts.player_state_valid = is_valid(player_state)

    local world = safe_call(controller, "GetWorld")
    if not is_valid(world) and UEHelpers and type(UEHelpers.GetWorld) == "function" then
        local ok, result = pcall(UEHelpers.GetWorld)
        if ok then
            world = result
        end
    end

    facts.world_valid = is_valid(world)
    if not facts.world_valid then
        return facts
    end

    facts.world_name = object_name(world)
    facts.world_full_name = object_full_name(world)
    facts.world_begun_play = as_bool(safe_prop(world, "bBegunPlay"))
    facts.world_tearing_down = as_bool(safe_prop(world, "bIsTearingDown"))
    facts.world_being_cleaned_up = as_bool(safe_prop(world, "bIsBeingCleanedUp"))
    facts.world_is_default_level = as_bool(safe_prop(world, "bIsDefaultLevel"))
    facts.world_initialized = as_bool(safe_prop(world, "bIsWorldInitialized"))
    facts.persistent_level_valid = is_valid(safe_prop(world, "PersistentLevel"))
    facts.game_state_valid = is_valid(safe_prop(world, "GameState"))
    facts.player_num = tonumber(safe_prop(world, "PlayerNum"))

    local pawn_world = safe_call(pawn, "GetWorld")
    facts.same_world = same_object(world, pawn_world)

    facts.pawn_location_valid = finite_vector(safe_call(pawn, "GetActorLocation"))

    return facts
end

return M
