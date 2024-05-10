local modenv = env
GLOBAL.setfenv(1, GLOBAL)

-- #FIXES https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/platapines-might-not-spawn-at-the-right-position-r44002/
local function onpickedfn(inst)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/pickup_reeds")

    if not inst.closed then
        inst.AnimState:PlayAnimation("picking")
        inst.AnimState:PushAnimation("picked", true)
    else
        inst.AnimState:PlayAnimation("picked", true)
    end

    local FIND_BILL_DIST = 50
    local target = FindEntity(inst, FIND_BILL_DIST, function(ent) return ent:HasTag("platapine") end)
    if target then
        return
    end

    if not (math.random() < TUNING.BILL_SPAWN_CHANCE) then
        return
    end

    local lotus_position = inst:GetPosition()
    local angle = math.random() * 360 * DEGREES
    local radius = 12
    local offset = FindWaterOffset(lotus_position, angle, radius, nil)
    if not offset then
        print("NO offset")
        return
    end

    local spawn_point = lotus_position + offset

    local bill = SpawnPrefab("bill")
    bill.Transform:SetPosition(spawn_point.x, 0, spawn_point.z)
    bill.components.combat.target = nil
    bill.sg:GoToState("surface")
end

modenv.AddPrefabPostInit("lotus", function(inst)
    inst.components.pickable.onpickedfn = onpickedfn
end)
