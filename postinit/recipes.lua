local modenv = env
GLOBAL.setfenv(1, GLOBAL)

--#FIXES https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/deco_plantholder_winterfeasttree-and-deco_plantholder_winterfeasttreeofsadness-cant-be-crafted-r45905/
local AllRecipes = GetAllRecipes()

AllRecipes["deco_plantholder_winterfeasttreeofsadness"].tab = RENO_RECIPETABS.PLANT_HOLDERS
AllRecipes["deco_plantholder_winterfeasttree"].tab = RENO_RECIPETABS.PLANT_HOLDERS
