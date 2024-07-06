local modenv = env
GLOBAL.setfenv(1, GLOBAL)

local Inventory = require("components/inventory")

-- It's safe to rewrite the entire function because they aren't updating this game anyways

-- #FIXES https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/oincs-arent-properly-consumed-if-placed-in-a-chest-r43644/
function Inventory:ConsumeByName(item, amount, check_all_containers)
    local total_num_found = 0

    local function try_consume(v)
        local num_found = 0
        if not v or v.prefab ~= item then
            return num_found
        end

        local num_left_to_find = amount - total_num_found
        if v.components.stackable then
            if v.components.stackable.stacksize > num_left_to_find then
                v.components.stackable:SetStackSize(v.components.stackable.stacksize - num_left_to_find)
                num_found = amount
                self:TestForOincSound(v,num_found)
            else
                num_found = num_found + v.components.stackable.stacksize
                self:RemoveItem(v, true):Remove()
            end
        else
            num_found = num_found + 1
            self:RemoveItem(v):Remove()
        end

        return num_found
    end

    for k = 1, self.maxslots do
        local v = self.itemslots[k]
        total_num_found = total_num_found + try_consume(v)

        if total_num_found >= amount then
            break
        end
    end

    if self.overflow and total_num_found < amount and self.overflow.components.container then
        for k = 1, #self.overflow.components.container.slots do
            local v = self.overflow.components.container.slots[k]
            total_num_found = total_num_found + try_consume(v)
            if total_num_found >= amount then
                break
            end
        end
    end

    if self.activeitem and self.activeitem.prefab == item and total_num_found < amount then
        total_num_found = total_num_found + try_consume(self.activeitem)
    end

    if self.activeitem and self.activeitem.prefab == item and total_num_found < amount then
        total_num_found = total_num_found + try_consume(self.activeitem)
    end

    local overflow = self.overflow and self.overflow.components.container

    if check_all_containers then
        for container_inst in pairs(self.opencontainers) do
            local container = container_inst.components.container or container_inst.components.inventory
            if container and container ~= overflow and not container.excludefromcrafting then
                for k, v in pairs(container.slots) do -- this line was originally "k = 1, #container.slots" 
                    total_num_found = total_num_found + try_consume(v)
                    if total_num_found >= amount then
                        return
                    end
                end
            end
        end
    end

    if self.overflow and total_num_found < amount then
        self.overflow.components.container:ConsumeByName(item, (amount - total_num_found))
    end
end
