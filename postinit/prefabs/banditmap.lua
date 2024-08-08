local modenv = env
GLOBAL.setfenv(1, GLOBAL)

--#FIXES https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/bandit-stash-map-can-be-deleted-but-its-treasure-wouldnt-reveal-r45922/

local function OnRemoveEntity(inst)
    if not inst.treasure or not inst.treasure:IsValid() or inst.treasure:IsRevealed() then
        return
    end

    inst.treasure:Reveal()
end

modenv.AddPrefabPostInit("banditmap", function(inst)
    local _OnRemoveEntity = inst.OnRemoveEntity
    inst.OnRemoveEntity = function(inst)
        if _OnRemoveEntity then
            _OnRemoveEntity(inst)
        end
        OnRemoveEntity(inst)
    end
end)

local function bandittreasure_postinit(inst)
    local _Reveal = inst.Reveal
    function inst:Reveal()
        _Reveal(inst)
        inst.components.workable:SetWorkable(true)
    end

    if not inst:IsRevealed() then
        inst.components.workable:SetWorkable(false)
    end
end

modenv.AddPrefabPostInit("bandittreasure", bandittreasure_postinit)
