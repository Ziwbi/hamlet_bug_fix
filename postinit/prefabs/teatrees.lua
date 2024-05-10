local modenv = env
GLOBAL.setfenv(1, GLOBAL)

modenv.AddPrefabPostInit("teatree_piko_nest", function(inst)
    inst:DoTaskInTime(0, function()
        if not inst.components.spawner then
            return
        end
        inst.components.spawner.delay = TUNING.PIKO_RESPAWN_TIME -- #FIXES https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/wrong-respawn-timer-for-pikos-r43848/
    end)
end)
