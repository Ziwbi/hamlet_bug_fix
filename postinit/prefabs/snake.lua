local modenv = env
GLOBAL.setfenv(1, GLOBAL)

local function snake_postinit(inst)
    local _OnEntitySleep = inst.OnEntitySleep
    inst.OnEntitySleep = function(inst) -- #FIXES https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/snakes-dont-go-home-when-the-entity-sleeps-r43999/
        _OnEntitySleep(inst)
        if GetClock():IsDay() then
            if inst.components.homeseeker then
                inst.components.homeseeker:ForceGoHome()
            end
        end
    end
end

modenv.AddPrefabPostInit("snake", snake_postinit)
modenv.AddPrefabPostInit("snake_poison", snake_postinit)
modenv.AddPrefabPostInit("snake_amphibious", snake_postinit)
