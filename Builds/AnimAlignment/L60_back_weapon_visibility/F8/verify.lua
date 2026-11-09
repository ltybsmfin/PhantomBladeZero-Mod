-- Exercise the staged production Lua with stateful, bounded UE4SS stubs.
local scripts = assert(arg[1]):gsub("\\", "/") .. "/"
package.path = scripts .. "?.lua;" .. package.path
local Config = require("control_config")
local nativeZ = -90
local serial, checks = 0, 0
local settings, statusText, callback
local scalar = "YounuoBarefootPoseWeight"

local function check(ok, label)
    assert(ok, label .. "\n" .. tostring(statusText))
    checks = checks + 1
end

local function object(name, class)
    serial = serial + 1
    local self = { name = name, address = serial, class = class }
    function self:IsValid() return not self.dead end
    function self:GetFullName() return self.name end
    function self:GetAddress() return self.address end
    function self:IsA(expected) return self.class == expected end
    return self
end

local meshClass = object("Class /Script/Engine.SkeletalMesh")
local componentClass = object("Class /Script/Engine.SkeletalMeshComponent")
local physicsClass = object("Class /Script/Engine.PhysicsAsset")
local physics = object("PhysicsAsset PHYS_F8_Normal_Adjacent", physicsClass)
local original = object("SkeletalMesh " .. Config.BAREFOOT_ORIGINAL_ASSET, meshClass)
local flat = object("SkeletalMesh " .. Config.BAREFOOT_RUNTIME_ASSET, meshClass)
local unrelated = object("SkeletalMesh /Game/Unrelated.Unrelated", meshClass)
local spoof = object("SkeletalMesh " .. Config.BAREFOOT_RUNTIME_ASSET)
local loadResult, findResult, loads, loadBySideEffect = nil, nil, 0, false
local allInstances = {}
local directAsset, directCalls = nil, 0

local function newPP(mode)
    if mode == "absent" then return nil end
    local name = mode == "wrong" and "Other_PostProcess_C Fixture" or "ABP_Younuo_TwistAfterIK_C Fixture"
    local pp = object(name)
    pp.YounuoHairAnimationWeight = .033
    pp.YounuoChestAnimationWeight = .37
    pp.YounuoSkirtAnimationWeight = .18
    pp.YounuoF8PhysicsAsset = physics
    function pp:L59LoadBarefootMesh()
        directCalls = directCalls + 1
        return directAsset
    end
    pp.pose, pp.poseWrites = 0, 0
    pp.readable = mode ~= "missing_field"
    pp.reject = mode == "reject_scalar"
    allInstances[#allInstances + 1] = pp
    return setmetatable(pp, {
        __index = function(self, key)
            if key == scalar and self.readable then return self.pose end
        end,
        __newindex = function(self, key, value)
            if key == scalar then
                assert(self.readable and not self.reject, "scalar write rejected")
                self.pose, self.poseWrites = value, self.poseWrites + 1
            else
                rawset(self, key, value)
            end
        end,
    })
end

local mesh = object("SkeletalMeshComponent Fixture.Mesh", componentClass)
mesh.asset, mesh.anim, mesh.z, mesh.shown = original, newPP(), nativeZ, true
mesh.swaps, mesh.heightWrites, mesh.shoeWrites = 0, 0, 0
local peer = object("SkeletalMeshComponent Fixture.Peer", componentClass)
peer.asset, peer.shown, peer.shoeWrites = original, true, 0
local function assetGetter(self) return self.asset end
local function sectionShown(self, material, lod)
    assert(material == 15 and lod == 0)
    assert(not self.rejectShoeRead)
    return self.shown
end
local function showSection(self, material, section, visible, lod)
    assert(material == 15 and section == 15 and lod == 0)
    self.shown, self.shoeWrites = visible, self.shoeWrites + 1
end
for _, component in ipairs({mesh, peer}) do
    component.GetSkeletalMeshAsset = assetGetter
    component.IsMaterialSectionShown = sectionShown
    component.ShowMaterialSection = showSection
end

function mesh:GetPostProcessInstance() return self.anim end
function mesh:SetSkeletalMeshAsset(asset)
    assert(asset == flat or asset == original)
    assert(not self.anim or self.anim.pose == 0, "changing asset while the old PP weight is live")
    self.swaps = self.swaps + 1
    if asset == flat and self.rejectSwap == "noop" then return end
    self.asset, self.shown = asset, true
    self.anim = newPP(asset == flat and self.nextFlatPP or nil)
    if asset == flat and self.rejectSwap == "after" then error("setter failed after swap") end
end
function mesh:GetRelativeTransform()
    return { Translation = { X = 3, Y = 4, Z = self.z }, Scale3D = { X = 1, Y = 1, Z = 1 } }
end
function mesh:K2_SetRelativeLocation(value, sweep, _, teleport)
    assert(value.X == 3 and value.Y == 4 and not sweep and teleport)
    if self.failNextHeight then
        self.failNextHeight = false
        error("height write rejected")
    end
    self.z, self.heightWrites = value.Z, self.heightWrites + 1
end
local pawn = object("Character Fixture")
pawn.Mesh = mesh
function pawn:GetBaseTranslationOffset() return { Z = nativeZ } end
function pawn:K2_GetComponentsByClass(class)
    assert(class == componentClass)
    return { mesh, peer }
end

package.preload.UEHelpers = function() return { GetPlayer = function() return pawn end } end
StaticFindObject = function(path)
    if path == "/Script/Engine.SkeletalMesh" then return meshClass end
    if path == "/Script/Engine.SkeletalMeshComponent" then return componentClass end
    if path == "/Script/Engine.PhysicsAsset" then return physicsClass end
    if path == Config.physicsAssetObjectPath("Normal_Adjacent") then return physics end
    if path == Config.BAREFOOT_ORIGINAL_ASSET then return original end
    if path == Config.BAREFOOT_RUNTIME_ASSET then return findResult end
end
LoadAsset = function(path)
    assert(path == Config.BAREFOOT_RUNTIME_ASSET or path == Config.BAREFOOT_ORIGINAL_ASSET)
    loads = loads + 1
    if path == Config.BAREFOOT_RUNTIME_ASSET and loadBySideEffect then
        findResult = loadResult
        return true
    end
    return path == Config.BAREFOOT_RUNTIME_ASSET and loadResult or nil
end
StaticLoadObject = function() error("must prefer the shipped UE4SS LoadAsset") end
LoopInGameThreadWithDelay = function(delay, handler)
    assert(delay == 200)
    callback = handler
    return handler
end
CancelDelayedAction = function() end
RegisterKeyBind = function() end
Key = { F8 = 119 }
ExecuteAsync = function() error("F8 launch outside fixture") end
io.open = function(path, mode)
    if mode == "r" and path:match("settings.txt$") then
        if settings == nil then return nil end
        return { read = function() return settings end, close = function() end }
    end
    if mode == "w" and path:match("status.txt$") then
        return { write = function(_, text) statusText = text end, close = function() end }
    end
    error("Unexpected fixture I/O: " .. path)
end

local base, extra = Config.DEFAULT_BAREFOOT_HEIGHT_CM, Config.BAREFOOT_POSE_DROP_CM
local function height(offset) return math.abs(mesh.z - (nativeZ - offset)) < 1e-7 end
local function status(token) return statusText and statusText:find(token, 1, true) ~= nil end
local function set(shoes, pose, suffix)
    settings = ("version=2\nshoes_visible=%d\nbarefoot_pose=%d\n%s"):format(shoes, pose, suffix or "")
    callback()
end
local function active()
    return mesh.asset == flat and mesh.anim.pose == 1 and not mesh.shown and not peer.shown
        and height(base + extra) and status("barefoot_pose_state=active")
end
local function baseline(shoes)
    return mesh.asset == original and mesh.anim and mesh.anim.pose == 0 and mesh.shown == shoes
        and peer.shown == shoes and height(shoes and 0 or base)
end
local function newAttempt()
    set(0, 0)
    set(0, 1)
end

dofile(scripts .. "main.lua")
set(1, 1)
check(baseline(true) and mesh.swaps == 0 and loads == 0, "visible shoes prohibit switch")
set(0, 0)
check(baseline(false) and mesh.swaps == 0, "hidden shoes with pose off keeps original")
set(0, 1)
check(baseline(false) and mesh.swaps == 0 and loads == 1 and status("mesh asset unavailable"), "missing asset leaves legacy height")
for _ = 1, 4 do callback() end
check(loads == 1, "missing asset loading is throttled")
loadResult = spoof
callback()
check(baseline(false) and mesh.swaps == 0 and loads == 2, "same name with wrong reflected class rejected")
loadResult, loadBySideEffect = flat, true
local old = mesh.anim
old.pose = 1
for _ = 1, 5 do callback() end
check(active() and mesh.swaps == 1 and old.pose == 0 and mesh.anim ~= old, "verified loader switches and zeroes old PP")
check(mesh.anim.YounuoF8PhysicsAsset == physics and mesh.shoeWrites > 0, "F8 controls reapply on new PP and shoe section")
local switches, writes, poseWrites = mesh.swaps, mesh.heightWrites, mesh.anim.poseWrites
for _ = 1, 20 do callback() end
check(active() and mesh.swaps == switches and mesh.heightWrites == writes
      and mesh.anim.poseWrites == poseWrites, "stable active request is idempotent")

local oldLoop = callback
dofile(scripts .. "main.lua")
oldLoop()
callback()
check(active() and mesh.swaps == switches and mesh.heightWrites == writes, "same-VM reload retains height origin and disables old loop")
local oldFlatPP = mesh.anim
mesh.anim = newPP()
callback()
check(active() and oldFlatPP.pose == 0 and mesh.swaps == switches, "PP recreation on active mesh uses the fresh instance")
local prior = mesh.anim
set(0, 0)
check(baseline(false) and prior.pose == 0 and mesh.anim ~= prior and mesh.swaps == switches + 1, "hidden off restores original mesh and legacy height")
findResult = flat
set(0, 1)
check(active(), "already loaded asset activates through exact find path")
set(1, 1)
check(baseline(true) and status("barefoot_pose_state=off"), "shoe-on clears shape and native height")

mesh.rejectSwap = "noop"
set(0, 1)
check(baseline(false) and status("mesh swap/readback failed"), "silent setter no-op rejected")
local failedSwaps = mesh.swaps
callback()
check(mesh.swaps == failedSwaps, "failed transition is not repeated until another toggle")
mesh.rejectSwap = "after"
newAttempt()
check(baseline(false) and status("mesh swap/readback failed"), "exception after changing asset rolls back")
mesh.rejectSwap = nil

for _, mode in ipairs({"wrong", "absent", "missing_field", "reject_scalar"}) do
    mesh.nextFlatPP = mode
    local start = #allInstances
    newAttempt()
    check(baseline(false) and status("barefoot_pose_state=pending"), "bad replacement PP rolls back: " .. mode)
    for i = start + 1, #allInstances do
        if allInstances[i].name:find("Other_", 1, true) then
            check(allInstances[i].poseWrites == 0, "wrong PP untouched")
        end
    end
end
mesh.nextFlatPP = nil
peer.rejectShoeRead = true
newAttempt()
check(mesh.asset == original and mesh.anim.pose == 0 and height(base)
      and status("shoe visibility not verified"), "post-swap shoe failure restores mesh and removes extra")
peer.rejectShoeRead = false
mesh.failNextHeight = true
newAttempt()
check(baseline(false) and status("height write/readback failed"), "height failure clears scalar and restores mesh")

newAttempt()
check(active(), "later activation recovers after an explicit toggle")
settings = "version=2\nbarefoot_pose=bad\n"
callback()
check(baseline(false) and status("status=error"), "invalid settings clear previously active transaction")
newAttempt()
check(active(), "valid settings can reactivate")
settings = nil
callback()
check(baseline(false) and status("source=missing"), "missing settings clear previously active transaction")

findResult, loadResult, loadBySideEffect = nil, nil, false
directAsset = spoof
local registryBefore, directBefore = loads, directCalls
newAttempt()
check(baseline(false) and loads == registryBefore + 1 and directCalls == directBefore + 1,
    "untyped loader result is rejected and registry may fall back")
directAsset = flat
registryBefore, directBefore = loads, directCalls
newAttempt()
check(active() and loads == registryBefore and directCalls == directBefore + 1,
    "direct loader activates without registry discovery")
set(1, 1)
check(baseline(true), "direct-loaded mesh restores original in shoe mode")

mesh.asset = unrelated
local unrelatedSwaps = mesh.swaps
set(0, 1)
check(mesh.asset == unrelated and mesh.anim.pose == 0 and mesh.swaps == unrelatedSwaps
      and status("outside the barefoot trial"), "unknown primary asset stays untouched")
check(peer.asset == original, "peer mesh never switched")

local function attachable(name, socket, hidden)
    local component = object(name)
    component.socket = socket
    component.bHiddenInGame = hidden
    component.children = {}
    component.visibilityWrites = 0
    function component:GetAttachSocketName()
        return { ToString = function() return self.socket end }
    end
    function component:GetNumChildrenComponents() return #self.children end
    function component:GetChildComponent(index) return self.children[index + 1] end
    function component:SetHiddenInGame(value, propagate)
        assert(not propagate)
        self.bHiddenInGame = value
        self.visibilityWrites = self.visibilityWrites + 1
    end
    return component
end

local weapon = attachable("Weapon Fixture.ZhanMa", "Pt_LongBlade_Back_Socket", false)
local blade = attachable("SkeletalMeshComponent Fixture.ZhanMa.Mesh", "None", true)
local sheath = attachable("Weapon Fixture.Sheath", "Pt_Knife_Back_Socket", false)
local nativeHidden = attachable("Weapon Fixture.NativeHidden", "Pt_Sword_Back_Socket", true)
weapon.children = { blade }
mesh.children = { weapon, sheath, nativeHidden }
mesh.GetAttachSocketName = weapon.GetAttachSocketName
mesh.GetNumChildrenComponents = weapon.GetNumChildrenComponents
mesh.GetChildComponent = weapon.GetChildComponent
mesh.socket = "None"
mesh.asset = original

set(0, 1, "back_weapons_visible=0\n")
check(active() and status("back_state=hidden") and weapon.bHiddenInGame and sheath.bHiddenInGame,
    "visible back components are hidden while the flat mesh is active")
check(blade.visibilityWrites == 0 and nativeHidden.visibilityWrites == 0,
    "components hidden by the game are untouched on the back")
weapon.socket = "weapon_r_Socket"
blade.bHiddenInGame = false
callback()
check(not weapon.bHiddenInGame and not blade.bHiddenInGame and blade.visibilityWrites == 0,
    "game-shown blade remains visible when its branch returns to hand")
check(sheath.bHiddenInGame and nativeHidden.bHiddenInGame and active(),
    "back sheath, native-hidden object and flat mesh retain their states")

weapon.socket = "Pt_LongBlade_Back_Socket"
callback()
check(weapon.bHiddenInGame and blade.bHiddenInGame, "F8 can hide a visibly sheathed blade")
weapon.socket = "weapon_r_Socket"
callback()
check(not weapon.bHiddenInGame and not blade.bHiddenInGame,
    "F8 releases the flags it set when the branch returns to hand")
set(0, 1, "back_weapons_visible=1\n")
check(not sheath.bHiddenInGame and nativeHidden.bHiddenInGame and nativeHidden.visibilityWrites == 0,
    "F8 restores its sheath without writing to native-hidden objects")
print("F8 barefoot and back visibility: " .. checks .. " passed")
