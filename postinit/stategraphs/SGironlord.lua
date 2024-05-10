local modenv = env
GLOBAL.setfenv(1, GLOBAL)

-- #FIXES https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/player-wouldnt-exit-work-state-automatically-while-using-the-living-artifact-r44627/
modenv.AddStategraphPostInit("ironlord", function(sg)
    local work_state = sg.states["work"]
    if work_state then
        work_state.events["animover"] = EventHandler("animover", function(inst)
            inst.sg:GoToState("idle")
        end)
    end
end)
