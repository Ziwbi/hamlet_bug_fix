local modenv = env
GLOBAL.setfenv(1, GLOBAL)

local PUGALISK_MOVE_DIST = 6

local PugaliskUtil = require("prefabs/pugalisk_util")
local _DetermineAction = PugaliskUtil.DetermineAction
PugaliskUtil.DetermineAction = function(inst)
    _DetermineAction(inst)

    if not inst.sg:HasStateTag("underground") then
        return
    end

    local target = PugaliskUtil.FindCurrentTarget(inst)
    local dist = target and inst:GetDistanceSqToInst(target) or nil

    if dist and dist < PUGALISK_MOVE_DIST * PUGALISK_MOVE_DIST and target ~= inst.home then
        return
    end

    -- #FIXES https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/pugalisk-can-get-stuck-in-ground-r44266/
    if not inst.wantstogaze and inst.wantstotaunt then -- when pugalisk wants to taunt while underground, it gets stuck
        local angle = PugaliskUtil.findDirectionToDive(inst, target)
        inst.movecommited = true

        if angle then
            inst.Transform:SetRotation(angle / DEGREES)
            inst.angle = angle

            if inst.sg:HasStateTag("underground") then
                local pos = Vector3(inst.Transform:GetWorldPosition())
                inst.components.multibody:SpawnBody(inst.angle, 0, pos)
            else
                inst.wantstopremove = true
            end
        else
            inst:PushEvent("backup")
        end
    end
end
