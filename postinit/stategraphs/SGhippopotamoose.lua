local modenv = env
GLOBAL.setfenv(1, GLOBAL)

modenv.AddStategraphPostInit("hippopotamoose", function(sg)
    local leap_attack_pst_state = sg.states["leap_attack_pst"]
    if not leap_attack_pst_state then
        return
    end

    leap_attack_pst_state.onenter = function(inst, target)
        if not inst:GetIsOnWater(Vector3(inst.Transform:GetWorldPosition()) ) then
            inst.components.groundpounder:GroundPound()
            inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/groundpound", nil, 0.5)

            -- first ground pound has a delay of 0s, the rest is "inst.components.groundpounder.ringDelay"
            inst:DoTaskInTime(math.max(inst.components.groundpounder.numRings - 1, 0) * inst.components.groundpounder.ringDelay, function()
                if not inst.components.groundpounder.ignoreEnts or not next(inst.components.groundpounder.ignoreEnts) then
                    -- #FIXES https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/onmissother-event-does-not-trigger-with-hippopotamooses-leap-attack-r44676/
                    inst:PushEvent("onmissother")
                end
            end)
        end

        SpawnWaves(inst, 12, 360, 4)

        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("jump_atk_pst")
    end
end)
