local modenv = env
GLOBAL.setfenv(1, GLOBAL)

--#FIXES https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/gnat-mound-is-burnable-r45938/
modenv.AddPrefabPostInit("gnatmound", function(inst)
    inst:RemoveComponent("burnable")
end)
