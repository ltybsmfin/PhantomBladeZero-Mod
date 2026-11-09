-- Pure declarations shared by the runtime and the offline tests. This module
-- deliberately has no UE4SS/UObject dependency.
local M = {}

M.DEFAULT_BAREFOOT_HEIGHT_CM = 0.944533035
-- Extra mesh-local drop measured with the barefoot pose active.
M.BAREFOOT_POSE_DROP_CM = 7.742898158
M.BAREFOOT_ORIGINAL_ASSET = "/HuaShira/Characters/Hero/Hero_Hun/SkinParts/Hun_Body_Simple.Hun_Body_Simple"
M.BAREFOOT_RUNTIME_ASSET = "/Game/YounuoAlignment_L58/SK_Younuo_Barefoot.SK_Younuo_Barefoot"

M.PHYSICS_ASSET_ROOT = "/Game/YounuoF8Controls/Physics/"

-- Order is significant: it is also the order used to preload hard references.
M.PHYSICS_ASSET_SUFFIXES = {
    "Off",
    "Low_None", "Low_Adjacent", "Low_All",
    "Normal_None", "Normal_Adjacent", "Normal_All",
    "High_None", "High_Adjacent", "High_All",
}

-- Exact Younuo replacement mesh package names from the L26 source manifest
-- (Hun_Skin, Hun_Clone, SkinParts/Hun_Body, Hun_UpBody, Hun_DownBody,
-- Hun_Body_Simple). All six live under the Hero_Hun container.
M.KNOWN_MESH_PATHS = {
    "/HuaShira/Characters/Hero/Hero_Hun/Hun_Skin",
    "/HuaShira/Characters/Hero/Hero_Hun/Hun_Clone",
    "/HuaShira/Characters/Hero/Hero_Hun/SkinParts/Hun_Body",
    "/HuaShira/Characters/Hero/Hero_Hun/SkinParts/Hun_UpBody",
    "/HuaShira/Characters/Hero/Hero_Hun/SkinParts/Hun_DownBody",
    "/HuaShira/Characters/Hero/Hero_Hun/SkinParts/Hun_Body_Simple",
}

M.KNOWN_MESH_NAMES = {
    Hun_Skin = true,
    Hun_Clone = true,
    Hun_Body = true,
    Hun_UpBody = true,
    Hun_DownBody = true,
    Hun_Body_Simple = true,
}

M.SHOE_MATERIAL_ID = 15
M.SHOE_LOD = 0
M.BACK_TRAVERSAL_LIMIT = 128
M.BACK_TRAVERSAL_DEPTH = 8

function M.physicsAssetObjectPath(suffix)
    return M.PHYSICS_ASSET_ROOT .. "PHYS_F8_" .. tostring(suffix)
        .. ".PHYS_F8_" .. tostring(suffix)
end

-- Off wins over every other skirt setting. Self collision off maps to the
-- None asset; otherwise the requested collision scope is Adjacent or All.
function M.selectPhysicsSuffix(settings)
    if not settings or settings.skirt_physics == 0 then return "Off" end
    local precision = settings.skirt_precision
    if precision ~= "low" and precision ~= "high" then precision = "normal" end
    local bucket = precision == "low" and "Low"
        or (precision == "high" and "High" or "Normal")
    if settings.skirt_self_collision == 0 then
        return bucket .. "_None"
    end
    local scope = settings.skirt_collision_scope == "all" and "All" or "Adjacent"
    return bucket .. "_" .. scope
end

-- ^Pt_.*_Back_Socket$ or ^Pt_.*_Back$, case insensitive.
function M.isBackSocket(name)
    if type(name) ~= "string" then return false end
    local lower = name:lower()
    return lower:match("^pt_.*_back_socket$") ~= nil
        or lower:match("^pt_.*_back$") ~= nil
end

function M.isKnownMeshPath(path)
    if type(path) ~= "string" then return false end
    local short = path:match("([^/%.]+)$")
    if M.KNOWN_MESH_NAMES[short] then return true end
    for _, known in ipairs(M.KNOWN_MESH_PATHS) do
        if path == known then return true end
    end
    return false
end

function M.isKnownMeshName(name)
    if type(name) ~= "string" then return false end
    return M.KNOWN_MESH_NAMES[name] == true
end

return M
