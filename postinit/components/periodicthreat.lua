local modenv = env
GLOBAL.setfenv(1, GLOBAL)

local PeriodicThreat = require("components/periodicthreat")

local _GoToNextState = PeriodicThreat.GoToNextState
function PeriodicThreat:GoToNextState(key)
    -- #FIXES https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/depths-worms-attacks-spawn-inside-slanty-shanty-r44744/
    if key == "WORM" and not TheCamera.interior then
        _GoToNextState(self, key)
    end

    local next_state
    local state = self.threats[key].state
    if state == "wait" then
        next_state = "warn"
        self:StartWarn(key)
    -- Removed event execution when in interior
    else
        next_state = "wait"
        self:StartWait(key)
    end

    if next_state then
        self.threats[key].state = next_state
        self:OnStateChange(key, next_state)
    end
end
