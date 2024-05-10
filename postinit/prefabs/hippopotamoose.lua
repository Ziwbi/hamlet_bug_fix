local modenv = env
GLOBAL.setfenv(1, GLOBAL)

modenv.AddPrefabPostInit("hippopotamoose", function(inst)
    local _OnWaterChange = inst.components.tiletracker.onwaterchangefn
    inst.components.tiletracker:SetOnWaterChangeFn(function(inst, onwater)
        if not inst.sg:HasStateTag("leapattack") then
            -- #FIXES https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/hippopotamoose-changes-state-while-jumping-across-landwater-r43998/
            return _OnWaterChange(inst, onwater)
        end

        if onwater then
            inst.DynamicShadow:Enable(false)
            inst.AnimState:SetBank("hippo_water")
        else
            inst.DynamicShadow:Enable(true)
            inst.AnimState:SetBank("hippo")
        end
    end)
end)
