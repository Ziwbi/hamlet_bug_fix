local modenv = env
GLOBAL.setfenv(1, GLOBAL)

local Banditmanager = require("components/banditmanager")

function Banditmanager:deactivatebandit(bandit, killed)
    self.banditactive = nil

    local loot = bandit.components.inventory:GetItems(function(k, v)
        return v.oincvalue ~= nil
    end)

    if killed then
        self.deathtime = self.deathtimeMax
        self.bandit = nil
    else
        bandit.components.health:SetPercent(1)
        bandit.attacked = nil
        for i, item in ipairs(loot) do
            if not self.loot[item.prefab] then
                if item.components.stackable then
                    self.loot[item.prefab] = item.components.stackable:StackSize()
                else
                    self.loot[item.prefab] = 1
                end
            else
                if item.components.stackable then
                    self.loot[item.prefab] = self.loot[item.prefab] + item.components.stackable:StackSize()
                else
                    self.loot[item.prefab] = self.loot[item.prefab] + 1
                end
            end

            bandit.components.inventory:RemoveItem(item, true)
            item:Remove() --#FIXES https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/masked-pig-leaves-oincs-at-0-0-0-r45921/
        end
    end
end
