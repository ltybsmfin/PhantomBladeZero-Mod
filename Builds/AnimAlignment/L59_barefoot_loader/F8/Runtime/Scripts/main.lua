-- Younuo F8 runtime controls. F8 still launches the existing panel; this file
-- only consumes the panel's settings file and applies reflected properties,
-- one material section, native relative location, and the exact primary mesh.
-- The mesh setter may rebuild the component's existing animation instances.
if _G.YOUNUO_F8_DISABLE_RUNTIME == true then return end

local okHelpers, UEHelpers = pcall(require, "UEHelpers")
if not okHelpers then
    print("[YounuoPhysicsPanel] UEHelpers unavailable: " .. tostring(UEHelpers) .. "\n")
    return
end

local Config = require("control_config")
local Parser = require("settings_parser")

local source = debug.getinfo(1, "S").source:sub(2):gsub("/", "\\")
local root = assert(source:match("^(.*)\\[^\\]+\\[^\\]+$"), "cannot resolve YounuoPhysicsPanel directory")
local panel = root .. "\\YounuoPhysicsPanel.exe"
local settingsPath = root .. "\\settings.txt"
local statusPath = root .. "\\status.txt"

local controls = {
    { "YounuoHairAnimationWeight",  0.09, 0.033, 0.013 },
    { "YounuoChestAnimationWeight", 0.66, 0.37, 0.18 },
    { "YounuoSkirtAnimationWeight", 0.45, 0.18, 0.03 },
}

local physicsAssets = {}
local physicsClass = nil
local lastPhysicsAssignment = {}
local lastStatusText = nil
local lastError = nil
local runtime = _G.YOUNUO_F8_L58_STATE
if type(runtime) ~= "table" or runtime.version ~= 1 then
    runtime = { version = 1, generation = 0, tickCount = 0, retryAt = 0, shoeState = {}, backRecords = {} }
    _G.YOUNUO_F8_L58_STATE = runtime
end
if runtime.loop ~= nil and type(CancelDelayedAction) == "function" then
    pcall(CancelDelayedAction, runtime.loop)
end
runtime.generation = runtime.generation + 1
local generation = runtime.generation
local backRecords = runtime.backRecords
local shoeState = runtime.shoeState
local barefootWeightName = "YounuoBarefootPoseWeight"

local function valid(object)
    if object == nil then return false end
    local ok, result = pcall(function() return object:IsValid() end)
    return ok and result == true
end

local function fullName(object)
    if not valid(object) then return "" end
    local ok, value = pcall(function() return object:GetFullName() end)
    return ok and type(value) == "string" and value or ""
end

local function sameObject(left, right)
    if left == right and left ~= nil then return true end
    if not valid(left) or not valid(right) then return false end
    return fullName(left) == fullName(right)
end

local function objectKey(object)
    if not valid(object) then return "" end
    local ok, address = pcall(function() return object:GetAddress() end)
    if ok and address ~= nil then return tostring(address) end
    return fullName(object)
end

local function property(object, name)
    if not valid(object) then return nil end
    local ok, value = pcall(function() return object[name] end)
    if ok and value ~= nil then return value end
    local ok2, value2 = pcall(function() return object:GetPropertyValue(name) end)
    if ok2 then return value2 end
    return nil
end

local function numberProperty(object, name)
    local value = property(object, name)
    return type(value) == "number" and value or nil
end

local function readText(path)
    local file = io.open(path, "r")
    if not file then return nil end
    local text = file:read("*a")
    file:close()
    return text
end

local function sanitize(text)
    return tostring(text):gsub("[\r\n\t]", " ")
end

local function writeStatus(text)
    if text == lastStatusText then return end
    local file = io.open(statusPath, "w")
    if not file then return end
    file:write(text)
    file:close()
    lastStatusText = text
end

local function errorStatus(errors)
    local lines = { "format=YounuoF8Status/1", "status=error", "source=invalid" }
    lines[#lines + 1] = "errors=" .. sanitize(table.concat(errors, "; "))
    lines[#lines + 1] = "pending="
    return table.concat(lines, "\n") .. "\n"
end

local function statusText(settings, state)
    local status = "applied"
    if #state.errors > 0 then
        status = "error"
    elseif #state.pending > 0 then
        status = "pending"
    end
    local lines = {
        "format=YounuoF8Status/1",
        "status=" .. status,
        "source=" .. tostring(settings.source or "v2"),
        "applied=" .. table.concat((function()
            local names = {}
            if state.weights then names[#names + 1] = "weights" end
            if state.physics then names[#names + 1] = "physics" end
            if state.shoes then names[#names + 1] = "shoes" end
            if state.barefoot_pose_state == "active" then names[#names + 1] = "barefoot_pose" end
            if state.height then names[#names + 1] = "height" end
            if state.back then names[#names + 1] = "back_weapons" end
            return names
        end)(), ","),
        "hair=" .. tostring(settings.hair),
        "chest=" .. tostring(settings.chest),
        "skirt=" .. tostring(settings.skirt),
        "skirt_physics=" .. tostring(settings.skirt_physics),
        "skirt_self_collision=" .. tostring(settings.skirt_self_collision),
        "skirt_collision_scope=" .. tostring(settings.skirt_collision_scope),
        "skirt_precision=" .. tostring(settings.skirt_precision),
        "shoes_visible=" .. tostring(settings.shoes_visible),
        "barefoot_pose=" .. tostring(settings.barefoot_pose),
        "barefoot_pose_state=" .. tostring(state.barefoot_pose_state or "not_applied"),
        "barefoot_mesh_path=" .. tostring(state.barefoot_mesh_path or ""),
        "barefoot_pose_drop_cm=" .. string.format("%.9f", state.barefoot_pose_drop_cm or 0),
        "back_weapons_visible=" .. tostring(settings.back_weapons_visible),
        "barefoot_height_cm=" .. string.format("%.9f", settings.barefoot_height_cm),
        "physics_asset=PHYS_F8_" .. Config.selectPhysicsSuffix(settings),
        "physics_state=" .. tostring(state.physics or "not_applied"),
        "shoes_state=" .. tostring(state.shoes or "not_applied"),
        "height_state=" .. tostring(state.height or "not_applied"),
        "back_state=" .. tostring(state.back or "not_applied"),
        "errors=" .. sanitize(table.concat(state.errors, "; ")),
        "pending=" .. sanitize(table.concat(state.pending, "; ")),
    }
    return table.concat(lines, "\n") .. "\n"
end

local function getSkeletalMeshAsset(mesh)
    if not valid(mesh) then return nil end
    local ok, value = pcall(function() return mesh:GetSkeletalMeshAsset() end)
    if ok and valid(value) then return value end
    return nil
end

local function isClassObject(object)
    if not valid(object) then return false end
    local ok, class = pcall(function() return object:GetClass() end)
    if not ok or not valid(class) then return false end
    local okName, name = pcall(function() return class:GetName() end)
    return okName and name == "Class"
end

local function getPhysicsClass()
    if valid(physicsClass) then return physicsClass end
    local ok, value = pcall(StaticFindObject, "/Script/Engine.PhysicsAsset")
    if ok and valid(value) then physicsClass = value end
    return physicsClass
end

local function isPhysicsAsset(object)
    if not valid(object) or isClassObject(object) then return false end
    local class = getPhysicsClass()
    if valid(class) then
        local ok, result = pcall(function() return object:IsA(class) end)
        if ok then return result == true end
    end
    -- Never accept a class object; the fallback is only a name sanity check.
    local path = fullName(object)
    return path:find("PHYS_F8_", 1, true) ~= nil and isClassObject(object) == false
end

local function preloadPhysicsAssets()
    for _, suffix in ipairs(Config.PHYSICS_ASSET_SUFFIXES) do
        if not valid(physicsAssets[suffix]) then
            local ok, object = pcall(StaticFindObject, Config.physicsAssetObjectPath(suffix))
            physicsAssets[suffix] = ok and object or nil
        end
    end
end

local function collectSkeletalMeshes(player, primary)
    local result, seen = {}, {}
    local function add(mesh)
        if not valid(mesh) then return end
        local key = fullName(mesh)
        if key == "" or seen[key] or #result >= 64 then return end
        seen[key] = true
        result[#result + 1] = mesh
    end
    add(primary)
    local okClass, class = pcall(StaticFindObject, "/Script/Engine.SkeletalMeshComponent")
    if okClass and valid(class) then
        local ok, list = pcall(function() return player:K2_GetComponentsByClass(class) end)
        if ok and list then
            if type(list) == "table" then
                for _, mesh in ipairs(list) do add(mesh) end
                if #result == 0 then
                    for key, mesh in pairs(list) do
                        if type(key) == "number" then add(mesh) end
                    end
                end
            else
                pcall(function()
                    list:ForEach(function(_, value) add(value:get()) end)
                end)
            end
        end
    end
    return result
end

local function shoeTargets(player, primary)
    local targetAsset = getSkeletalMeshAsset(primary)
    local targets = { primary }
    for _, mesh in ipairs(collectSkeletalMeshes(player, primary)) do
        local otherAsset = getSkeletalMeshAsset(mesh)
        local sourceName, otherName = fullName(targetAsset), fullName(otherAsset)
        local baseName = "SkeletalMesh " .. Config.BAREFOOT_ORIGINAL_ASSET
        local flatName = "SkeletalMesh " .. Config.BAREFOOT_RUNTIME_ASSET
        local bothFootwearMeshes = (sourceName == baseName or sourceName == flatName)
            and (otherName == baseName or otherName == flatName)
        if objectKey(mesh) ~= objectKey(primary) and targetAsset
            and (sameObject(otherAsset, targetAsset) or bothFootwearMeshes) then
            targets[#targets + 1] = mesh
        end
    end
    return targets
end

local function getHidden(component)
    local value = property(component, "bHiddenInGame")
    if type(value) == "boolean" then return value end
    return nil
end

local function setHidden(component, hidden)
    local ok = pcall(function() component:SetHiddenInGame(hidden, false) end)
    if not ok then return false end
    return getHidden(component) == hidden
end

local function restoreBackRecords(state, onlyStale, active)
    for key, record in pairs(backRecords) do
        if not onlyStale or not active[key] then
            if not valid(record.component) then
                backRecords[key] = nil
            else
                if setHidden(record.component, record.original) then
                    backRecords[key] = nil
                else
                    state.errors[#state.errors + 1] = "back restore failed: " .. key
                end
            end
        end
    end
end

local function collectBackRoots(start, roots, seen, budget)
    local visited = {}
    local function visit(component, depth)
        if budget.count >= Config.BACK_TRAVERSAL_LIMIT or depth > Config.BACK_TRAVERSAL_DEPTH then return end
        if not valid(component) then return end
        local key = fullName(component)
        if key == "" or visited[key] then return end
        visited[key] = true
        budget.count = budget.count + 1
        local okSocket, socket = pcall(function() return component:GetAttachSocketName() end)
        local socketName = okSocket and socket and socket:ToString() or nil
        if Config.isBackSocket(socketName) then
            if not seen[key] then
                seen[key] = true
                roots[#roots + 1] = component
            end
            return
        end
        local okCount, count = pcall(function() return component:GetNumChildrenComponents() end)
        if not okCount or type(count) ~= "number" then return end
        for index = 0, math.min(count, 32) - 1 do
            local okChild, child = pcall(function() return component:GetChildComponent(index) end)
            if okChild then visit(child, depth + 1) end
        end
    end
    visit(start, 0)
end

local function hideSubtree(component, depth, active, budget, state)
    if budget.count >= Config.BACK_TRAVERSAL_LIMIT or depth > Config.BACK_TRAVERSAL_DEPTH then return end
    if not valid(component) then return end
    local key = fullName(component)
    if key == "" or active[key] then return end
    active[key] = true
    budget.count = budget.count + 1

    local record = backRecords[key]
    if not record then
        local original = getHidden(component)
        if original == nil then
            state.errors[#state.errors + 1] = "back original visibility unavailable: " .. key
        else
            record = { component = component, original = original }
            backRecords[key] = record
        end
    end
    if record then
        record.component = component
        local current = getHidden(component)
        if current == nil then
            state.errors[#state.errors + 1] = "back visibility unavailable: " .. key
        elseif current ~= true and not setHidden(component, true) then
            state.errors[#state.errors + 1] = "back hide failed: " .. key
        end
    end

    local okCount, count = pcall(function() return component:GetNumChildrenComponents() end)
    if not okCount or type(count) ~= "number" then return end
    for index = 0, math.min(count, 32) - 1 do
        local okChild, child = pcall(function() return component:GetChildComponent(index) end)
        if okChild then hideSubtree(child, depth + 1, active, budget, state) end
    end
end

local function applyBackWeapons(player, primary, visible, state)
    if visible then
        local errorsBefore = #state.errors
        restoreBackRecords(state, false, {})
        if #state.errors == errorsBefore then state.back = "restored" end
        return
    end

    local roots, seen, budget = {}, {}, { count = 0 }
    collectBackRoots(primary, roots, seen, budget)
    local rootComponent = property(player, "RootComponent")
    if valid(rootComponent) then
        collectBackRoots(rootComponent, roots, seen, budget)
    end

    local active = {}
    local hideBudget = { count = 0 }
    local errorsBefore = #state.errors
    for _, root in ipairs(roots) do
        hideSubtree(root, 0, active, hideBudget, state)
    end
    restoreBackRecords(state, true, active)
    if #state.errors == errorsBefore then
        state.back = #roots > 0 and "hidden" or "no_back_weapons"
    end
end

local function applyShoes(player, primary, settings, state)
    local visible = settings.shoes_visible == 1
    local targets = shoeTargets(player, primary)
    local applied = 0
    for _, mesh in ipairs(targets) do
        local okShown, shown = pcall(function() return mesh:IsMaterialSectionShown(Config.SHOE_MATERIAL_ID, Config.SHOE_LOD) end)
        if not okShown or type(shown) ~= "boolean" then
            state.pending[#state.pending + 1] = "shoe material query unavailable"
        else
            local okAfter, after = true, shown
            if shown ~= visible then
                local okShow = pcall(function()
                    mesh:ShowMaterialSection(Config.SHOE_MATERIAL_ID, Config.SHOE_MATERIAL_ID, visible, Config.SHOE_LOD)
                end)
                okAfter, after = pcall(function()
                    return mesh:IsMaterialSectionShown(Config.SHOE_MATERIAL_ID, Config.SHOE_LOD)
                end)
                if not okShow then okAfter = false end
            end
            if okAfter and after == visible then
                applied = applied + 1
            else
                state.pending[#state.pending + 1] = "shoe material apply unavailable"
            end
        end
    end
    if applied > 0 and applied == #targets then
        state.shoes = visible and "visible" or "hidden"
    end
    return visible
end

local function applyHeight(player, primary, visible, settings, extraDrop, state)
    local okTransform, transform = pcall(function() return primary:GetRelativeTransform() end)
    if not okTransform or not transform or not transform.Translation or not transform.Scale3D then
        state.pending[#state.pending + 1] = "mesh relative transform unavailable"
        return
    end

    local meshKey = objectKey(primary)
    if shoeState.meshKey ~= meshKey then
        if valid(shoeState.mesh) and (shoeState.lastOffset or 0) ~= 0 then
            local old = shoeState.mesh:GetRelativeTransform().Translation
            shoeState.mesh:K2_SetRelativeLocation({X=old.X,Y=old.Y,Z=old.Z+shoeState.lastOffset}, false, {}, true)
        end
        shoeState = { meshKey = meshKey, mesh = primary }
        runtime.shoeState = shoeState
    end
    local current = transform.Translation
    local currentZ = current.Z
    local scaleZ = math.abs(transform.Scale3D.Z)
    local okNative, native = pcall(function() return player:GetBaseTranslationOffset() end)
    local nativeZ = okNative and native and native.Z or nil
    if shoeState.baseZ == nil then
        shoeState.baseZ = currentZ
        shoeState.lastAppliedZ = currentZ
        shoeState.nativeDelta = nativeZ and (currentZ-nativeZ) or nil
    elseif visible and (shoeState.lastOffset or 0) == 0 then
        -- With shoes on, observe native movement without writing any transform.
        shoeState.baseZ = currentZ
        shoeState.nativeDelta = nativeZ and (currentZ-nativeZ) or nil
    elseif nativeZ and shoeState.nativeDelta then
        -- Character exposes the canonical mesh offset, including crouch changes.
        -- A native reset to that location must not absorb our barefoot offset.
        shoeState.baseZ = nativeZ + shoeState.nativeDelta
    elseif shoeState.lastAppliedZ ~= nil and math.abs(currentZ - shoeState.lastAppliedZ) > 0.001 then
        -- An external/native location change is absorbed once, so offsets never
        -- accumulate across frames.
        shoeState.baseZ = shoeState.baseZ + (currentZ - shoeState.lastAppliedZ)
        shoeState.lastAppliedZ = currentZ
    end

    local offset = visible and 0 or ((settings.barefoot_height_cm + extraDrop) * scaleZ)
    local targetZ = shoeState.baseZ - offset
    if math.abs(currentZ - targetZ) > 0.0001 then
        local okSet = pcall(function()
            primary:K2_SetRelativeLocation(
                { X = current.X, Y = current.Y, Z = targetZ },
                false, {}, true)
        end)
        if not okSet then
            state.errors[#state.errors + 1] = "relative location write failed"
            return
        end
        local okAfter, after = pcall(function() return primary:GetRelativeTransform() end)
        if not okAfter or not after or not after.Translation
            or math.abs(after.Translation.Z - targetZ) > 0.01 then
            state.errors[#state.errors + 1] = "relative location verification failed"
            return
        end
        currentZ = after.Translation.Z
    end
    shoeState.lastAppliedZ = currentZ
    shoeState.lastOffset = offset
    shoeState.lastExtraDrop = extraDrop
    state.height = visible and "baseline" or string.format("%.6f", offset)
    return true
end

local function setBarefootWeight(anim, current, target)
    if current == nil then return false end
    if current ~= target then
        local ok = pcall(function() anim[barefootWeightName] = target end)
        if not ok then return false end
    end
    return numberProperty(anim, barefootWeightName) == target
end

local function restoreBarefootPose(nextAnim, state)
    if not valid(runtime.barefootAnim) then
        runtime.barefootAnim = nil
        return true
    end
    if valid(nextAnim) and objectKey(nextAnim) == objectKey(runtime.barefootAnim) then return true end
    if setBarefootWeight(runtime.barefootAnim, numberProperty(runtime.barefootAnim, barefootWeightName), 0) then
        runtime.barefootAnim = nil
        return true
    end
    state.pending[#state.pending + 1] = "previous barefoot pose reset pending"
    return false
end

-- Shared with the staged F8 main.lua by l58_f8_build.py.
local originalBody = Config.BAREFOOT_ORIGINAL_ASSET
local barefootBody = Config.BAREFOOT_RUNTIME_ASSET

local function assetPath(asset)
    return fullName(asset):match("^SkeletalMesh%s+([^%s]+)$")
end

local function exactAsset(asset, path)
    if assetPath(asset) ~= path then return false end
    local okClass, class = pcall(StaticFindObject, "/Script/Engine.SkeletalMesh")
    if not okClass or not valid(class) then return false end
    local okType, matches = pcall(function() return asset:IsA(class) end)
    return okType and matches == true
end

local function findAsset(path, anim)
    local ok, asset = pcall(StaticFindObject, path)
    if ok and exactAsset(asset, path) then return asset end
    -- The new mesh is mounted as a package but may be absent from the
    -- shipped Asset Registry. The post-process loader resolves its soft path.
    if path == barefootBody and valid(anim) then
        ok, asset = pcall(function() return anim:L59LoadBarefootMesh() end)
        if ok and exactAsset(asset, path) then return asset end
    end
    -- Keep the ordinary Asset Registry route as a fallback.
    -- Some builds return only a success value; always try the object lookup again.
    local loader = type(LoadAsset) == "function" and LoadAsset or StaticLoadObject
    if type(loader) == "function" then
        ok, asset = pcall(loader, path)
        if ok and exactAsset(asset, path) then return asset end
        ok, asset = pcall(StaticFindObject, path)
        if ok and exactAsset(asset, path) then return asset end
    end
    return nil
end

local function currentPrimary(player, primary)
    local actual = property(player, "Mesh")
    if not valid(actual) or not valid(primary) or objectKey(actual) ~= objectKey(primary) then return false end
    local okClass, class = pcall(StaticFindObject, "/Script/Engine.SkeletalMeshComponent")
    if not okClass or not valid(class) then return false end
    local okType, matches = pcall(function() return primary:IsA(class) end)
    return okType and matches == true
end

local function currentPP(primary)
    local ok, anim = pcall(function() return primary:GetPostProcessInstance() end)
    if not ok or not valid(anim) then return nil, "post-process instance not ready" end
    if not fullName(anim):match("^ABP_Younuo_TwistAfterIK_C%s") then
        return nil, "active post-process is not ABP_Younuo_TwistAfterIK_C"
    end
    return anim
end

local function switchMesh(player, primary, asset, path)
    if not currentPrimary(player, primary) or not exactAsset(asset, path) then return false end
    local ok = pcall(function() primary:SetSkeletalMeshAsset(asset) end)
    return ok and currentPrimary(player, primary) and exactAsset(getSkeletalMeshAsset(primary), path)
end

local function clearPose(anim, state)
    local cleared = restoreBarefootPose(nil, state)
    local value = numberProperty(anim, barefootWeightName)
    if value ~= nil and not setBarefootWeight(anim, value, 0) then
        state.pending[#state.pending + 1] = "current barefoot pose reset pending"
        cleared = false
    end
    return cleared
end

local function restoreMesh(player, primary, state)
    local key = objectKey(primary)
    local current = getSkeletalMeshAsset(primary)
    local path = assetPath(current)
    local anim = currentPP(primary)
    if not clearPose(anim, state) then return anim, false end
    if path == originalBody then
        runtime.swapKey = nil
        return anim, true
    end
    -- An absent readback immediately after our own call may be a partial swap.
    -- A different valid asset belongs to the game and must not be overwritten.
    if path ~= barefootBody and not (not valid(current) and runtime.swapKey == key) then
        return anim, runtime.swapKey ~= key
    end
    local original = runtime.originalAsset
    if not exactAsset(original, originalBody) then original = findAsset(originalBody) end
    if not original or not switchMesh(player, primary, original, originalBody) then
        state.pending[#state.pending + 1] = "original barefoot mesh restore pending"
        return currentPP(primary), false
    end
    runtime.swapKey = nil
    anim = currentPP(primary)
    return anim, clearPose(anim, state)
end

local function legacyFootwear(player, primary, settings, state, anim)
    if not currentPrimary(player, primary) then return end
    local visible = settings.shoes_visible == 1
    if valid(anim) or shoeState.meshKey == objectKey(primary) then
        state.shoes = nil
        applyShoes(player, primary, settings, state)
        local priorExtra = shoeState.meshKey == objectKey(primary) and (shoeState.lastExtraDrop or 0) > 0
        if state.shoes or priorExtra then applyHeight(player, primary, visible, settings, 0, state) end
    end
end

local function applyFootwear(player, primary, settings, state)
    local requested = settings.shoes_visible == 0 and settings.barefoot_pose == 1
    local key = objectKey(primary)
    local asset = getSkeletalMeshAsset(primary)
    local path = assetPath(asset)
    local anim = currentPP(primary)
    local drop = Config.BAREFOOT_POSE_DROP_CM
    local calibrated = type(drop) == "number" and drop == drop and drop > 0 and drop < math.huge
    if runtime.requestKey ~= key or runtime.requested ~= requested then
        runtime.requestKey, runtime.requested = key, requested
        runtime.blockedKey, runtime.retryAt = nil, 0
    end
    runtime.tickCount = runtime.tickCount + 1

    local function fallback(reason, block)
        if reason then state.pending[#state.pending + 1] = reason end
        if block then runtime.blockedKey = key end
        local restored, ok = restoreMesh(player, primary, state)
        legacyFootwear(player, primary, settings, state, restored)
        state.barefoot_pose_state = (requested or not ok) and "pending" or "off"
        state.barefoot_mesh_path = assetPath(getSkeletalMeshAsset(primary)) or ""
        return restored
    end

    if not requested then return fallback() end
    if not calibrated then return fallback("barefoot pose height calibration pending") end
    if runtime.blockedKey == key then
        return fallback("barefoot mesh activation suspended until next F8 toggle")
    end
    if path == originalBody and exactAsset(asset, originalBody) then
        if not valid(anim) or numberProperty(anim, barefootWeightName) == nil then
            return fallback("barefoot pose property unavailable on the original mesh")
        end
        if runtime.tickCount < runtime.retryAt then return fallback("barefoot mesh load retry pending") end
        local target = findAsset(barefootBody, anim)
        if not target then
            runtime.retryAt = runtime.tickCount + 5
            return fallback("verified barefoot mesh asset unavailable")
        end
        if not clearPose(anim, state) then return fallback(nil, true) end
        runtime.originalAsset, runtime.swapKey = asset, key
        if not switchMesh(player, primary, target, barefootBody) then
            return fallback("barefoot mesh swap/readback failed", true)
        end
        asset = getSkeletalMeshAsset(primary)
        -- SetSkeletalMeshAsset can reinitialise the PP instance.
        anim = currentPP(primary)
    elseif path ~= barefootBody then
        return fallback("primary mesh is outside the barefoot trial")
    end
    if not exactAsset(asset, barefootBody) or not currentPrimary(player, primary) then
        return fallback("barefoot mesh identity not verified", true)
    end
    if shoeState.meshKey ~= key and runtime.swapKey ~= key then
        -- A Lua state lost after a prior successful switch cannot infer an
        -- extra height offset from a mesh already lowered by an older loop.
        return fallback("barefoot mesh found without its height baseline", true)
    end
    if not valid(anim) or numberProperty(anim, barefootWeightName) == nil then
        return fallback("post-process unavailable after barefoot mesh swap", true)
    end
    if not restoreBarefootPose(anim, state) then return fallback(nil, true) end
    applyShoes(player, primary, settings, state)
    if state.shoes ~= "hidden" then return fallback("barefoot mesh shoe visibility not verified", true) end
    if not currentPrimary(player, primary) or not exactAsset(getSkeletalMeshAsset(primary), barefootBody)
        or objectKey(currentPP(primary)) ~= objectKey(anim) then
        return fallback("barefoot mesh or post-process changed during activation", true)
    end
    runtime.barefootAnim = anim
    if not setBarefootWeight(anim, numberProperty(anim, barefootWeightName), 1) then
        return fallback("barefoot pose scalar write/readback unavailable", true)
    end
    if not applyHeight(player, primary, false, settings, drop, state) then
        return fallback("barefoot height write/readback failed", true)
    end
    state.barefoot_pose_state, state.barefoot_pose_drop_cm = "active", drop
    state.barefoot_mesh_path = barefootBody
    return anim
end


local function applyWeights(anim, settings, state)
    local errorsBefore = #state.errors
    local current = {}
    for index, control in ipairs(controls) do
        current[index] = numberProperty(anim, control[1])
        if current[index] == nil then
            state.pending[#state.pending + 1] = "weight property unavailable: " .. control[1]
            return
        end
    end

    local values = { settings.hair, settings.chest, settings.skirt }
    for index, control in ipairs(controls) do
        local target
        if index == 3 and settings.skirt_physics == 0 then
            target = 1
        else
            local step = values[index] / 50
            local slot = step < 1 and 2 or 3
            target = control[slot] + (control[slot + 1] - control[slot]) * (step - (slot - 2))
        end
        if math.abs(current[index] - target) > 0.0001 then
            local ok = pcall(function() anim[control[1]] = target end)
            if not ok or numberProperty(anim, control[1]) == nil then
                state.errors[#state.errors + 1] = "weight write failed: " .. control[1]
            end
        end
    end
    if #state.errors == errorsBefore then state.weights = "applied" end
end

local function applyPhysics(anim, settings, state)
    local suffix = Config.selectPhysicsSuffix(settings)
    preloadPhysicsAssets()
    local asset = physicsAssets[suffix]
    if not isPhysicsAsset(asset) then
        state.pending[#state.pending + 1] = "physics asset missing: PHYS_F8_" .. suffix
        return
    end

    local current = property(anim, "YounuoF8PhysicsAsset")
    if sameObject(current, asset) then
        state.physics = suffix
        return
    end
    local animKey = objectKey(anim)
    if lastPhysicsAssignment.anim == animKey and lastPhysicsAssignment.suffix == suffix then
        -- The write already happened; do not re-trigger RigidBody.PreUpdate just
        -- because the reflected readback is unavailable.
        state.pending[#state.pending + 1] = "YounuoF8PhysicsAsset readback unavailable"
        return
    end
    local ok = pcall(function() anim.YounuoF8PhysicsAsset = asset end)
    if ok then
        lastPhysicsAssignment = { anim = animKey, suffix = suffix }
    end
    local after = property(anim, "YounuoF8PhysicsAsset")
    if not ok or not sameObject(after, asset) then
        state.pending[#state.pending + 1] = "YounuoF8PhysicsAsset reflection unavailable"
        return
    end
    state.physics = suffix
end

local function restoreWhenSettingsUnavailable()
    if not runtime.swapKey or not runtime.lastSettings then return end
    local ok, player = pcall(function() return UEHelpers.GetPlayer() end)
    if not ok or not valid(player) then return end
    local mesh = property(player, "Mesh")
    if not valid(mesh) or objectKey(mesh) ~= runtime.swapKey then return end
    local settings = {}
    for key, value in pairs(runtime.lastSettings) do settings[key] = value end
    settings.barefoot_pose = 0
    applyFootwear(player, mesh, settings, { pending = {}, errors = {} })
end

local function tick()
    local text = readText(settingsPath)
    if text == nil then
        restoreWhenSettingsUnavailable()
        writeStatus("format=YounuoF8Status/1\nstatus=pending\nsource=missing\nerrors=\npending=settings.txt missing\n")
        return
    end
    local settings, parseErrors = Parser.parse(text)
    if not settings then
        restoreWhenSettingsUnavailable()
        writeStatus(errorStatus(parseErrors))
        return
    end

    runtime.lastSettings = settings
    local state = { pending = {}, errors = {} }
    local okPlayer, player = pcall(function() return UEHelpers.GetPlayer() end)
    if not okPlayer or not valid(player) then
        restoreBarefootPose(nil, state)
        state.pending[#state.pending + 1] = "engine/player not ready"
        writeStatus(statusText(settings, state))
        return
    end
    local primary = property(player, "Mesh")
    if not valid(primary) then
        restoreBarefootPose(nil, state)
        state.pending[#state.pending + 1] = "player mesh not ready"
        writeStatus(statusText(settings, state))
        return
    end
    local anim = applyFootwear(player, primary, settings, state)
    if not valid(anim) or not currentPrimary(player, primary) or objectKey(currentPP(primary)) ~= objectKey(anim) then
        local _, reason = currentPP(primary)
        state.pending[#state.pending + 1] = reason or "primary post-process changed before F8 update"
        writeStatus(statusText(settings, state))
        return
    end
    applyWeights(anim, settings, state)
    applyPhysics(anim, settings, state)
    applyBackWeapons(player, primary, settings.back_weapons_visible == 1, state)
    writeStatus(statusText(settings, state))
end

runtime.loop = LoopInGameThreadWithDelay(200, function()
    if generation ~= runtime.generation then return end
    local ok, err = pcall(tick)
    if not ok then
        if err ~= lastError then
            lastError = err
            print("[YounuoPhysicsPanel] " .. tostring(err) .. "\n")
            writeStatus("format=YounuoF8Status/1\nstatus=error\nsource=runtime\nerrors="
                .. sanitize(err) .. "\npending=\n")
        end
    else
        lastError = nil
    end
end)

RegisterKeyBind(Key.F8, function()
    if generation ~= runtime.generation then return end
    if panel:find('["%%!\r\n]') then
        print("[YounuoPhysicsPanel] Unsupported characters in panel path\n")
        return
    end
    ExecuteAsync(function()
        os.execute('start "" /B "' .. panel .. '"')
    end)
end)

print("[YounuoPhysicsPanel] F8 opens the tuning panel\n")
