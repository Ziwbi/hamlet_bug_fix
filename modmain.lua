-- Hamlet Script Bug Fixes
-- Copyright (C) 2024  ziwbi

-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.

local modenv = env
GLOBAL.setfenv(1, GLOBAL)

if not IsDLCEnabled(PORKLAND_DLC) then
    return
end

local component_postinits = {
    "periodicthreat",
}

local prefab_postinits = {
    "hippopotamoose",
    "lotus",
    "piko",
    "pugalisk_util",
    "snake",
    "teatrees",
}

local stategraph_postinits = {
    "hippopotamoose",
    "ironlord",
    "pangolden",
}

for _, component in pairs(component_postinits) do
    modenv.modimport(string.format("postinit/components/%s.lua", component))
end

for _, prefab in pairs(prefab_postinits) do
    modenv.modimport(string.format("postinit/prefabs/%s.lua", prefab))
end

for _, stategraph in pairs(stategraph_postinits) do
    modenv.modimport(string.format("postinit/stategraphs/SG%s.lua", stategraph))
end

--[[ Component Bug Fixes ]]--
--- https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/depths-worms-attacks-spawn-inside-slanty-shanty-r44744/

--[[ Prefab Bug Fixes ]]--
--- https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/hippopotamoose-changes-state-while-jumping-across-landwater-r43998/
--- https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/platapines-might-not-spawn-at-the-right-position-r44002/
--- https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/piko-keeps-combat-target-forever-r43839/
--- https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/pikos-dont-get-stunned-when-dropped-r43845/
--- https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/wrong-animation-symbol-for-pikos-burning-and-freezing-animation-r43847/
--- https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/pugalisk-can-get-stuck-in-ground-r44266/
--- https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/snakes-dont-go-home-when-the-entity-sleeps-r43999/
--- https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/wrong-respawn-timer-for-pikos-r43848/

--[[ Stategraph Bug Fixes ]]--
--- https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/player-wouldnt-exit-work-state-automatically-while-using-the-living-artifact-r44627/
--- https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/onmissother-event-does-not-trigger-with-hippopotamooses-leap-attack-r44676/
--- https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/wrong-stategraph-name-for-pangolden-r43840/
