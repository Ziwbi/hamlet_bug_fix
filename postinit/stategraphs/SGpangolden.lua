local modenv = env
GLOBAL.setfenv(1, GLOBAL)

local SGpangolden = require("stategraphs/SGPangolden")
SGpangolden.name = "pangolden" -- #FIXES https://forums.kleientertainment.com/klei-bug-tracker/dont-starve/wrong-stategraph-name-for-pangolden-r43840/
