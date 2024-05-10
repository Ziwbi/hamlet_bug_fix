local modenv = env
GLOBAL.setfenv(1, GLOBAL)

local function KeepTarget(inst, target)
    if not inst.currentlyRabid then
        return false
    end
    return inst.components.combat:CanTarget(target)
end

local function refresh_build(inst)
    if inst.components.inventory:NumItems() > 0 then
        inst.updatebuild(inst, true)
    else
        inst.updatebuild(inst, false)
    end
end

local function OnDropped(inst)
    refresh_build(inst)
    inst.sg:GoToState("stunned")
end

local function piko_postinit(inst)
    local _Retarget = inst.components.combat.targetfn
    inst.components.combat.targetfn = function(inst)
        if not inst.currentlyRabid then
            return
        end
        return _Retarget(inst)
    end
    inst.components.combat:SetKeepTargetFunction(KeepTarget) -- #FIXES https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/piko-keeps-combat-target-forever-r43839/
    inst:ListenForEvent("ondropped", OnDropped) -- #FIXES https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/pikos-dont-get-stunned-when-dropped-r43845/

    -- MAKING AN ASSUMPTION HERE THAT ONLY 1 FXDATA EXIST
    -- #FIXES https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/wrong-animation-symbol-for-pikos-burning-and-freezing-animation-r43847/
    local fire_fxdata = inst.components.burnable.fxdata[1]
    local freeze_fxdata = inst.components.freezable[1]
    if fire_fxdata then
        fire_fxdata.follow = "torso"
    end
    if freeze_fxdata then
        freeze_fxdata.follow = "torso"
    end
end

modenv.AddPrefabPostInit("piko", piko_postinit)
modenv.AddPrefabPostInit("piko_orange", piko_postinit)
