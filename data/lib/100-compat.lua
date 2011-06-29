--[[
 * File containing deprecated functions and constants used by alot of scripts and other engines
]]--
--bit = require("bit")

TRUE = true
FALSE = false
LUA_ERROR = false
LUA_NO_ERROR = true
LUA_NULL = nil

TALKTYPE_CHANNEL_W = TALKTYPE_CHANNEL_MANAGEMENT
TALKTYPE_CHANNEL_Y = TALKTYPE_CHANNEL
TALKTYPE_CHANNEL_O = TALKTYPE_CHANNEL_HIGHLIGHT
TALKTYPE_BROADCAST = TALKTYPE_GAMEMASTER_BROADCAST
TALKTYPE_CHANNEL_RN = TALKTYPE_GAMEMASTER_CHANNEL
TALKTYPE_PRIVATE_RED = TALKTYPE_GAMEMASTER_PRIVATE_FROM
TALKTYPE_CHANNEL_R1 = TALKTYPE_CHANNEL_RN
TALKTYPE_CHANNEL_R2 = TALKTYPE_CHANNEL_RA
TALKTYPE_CHANNEL_RA = TALKTYPE_CHANNEL_W
TALKTYPE_ORANGE_1 = TALKTYPE_MONSTER_SAY
TALKTYPE_ORANGE_2 = TALKTYPE_MONSTER_YELL
TALKTYPE_MONSTER = TALKTYPE_MONSTER_SAY

TEXTCOLOR_BLACK = COLOR_BLACK
TEXTCOLOR_BLUE = COLOR_BLUE
TEXTCOLOR_GREEN = COLOR_GREEN
TEXTCOLOR_LIGHTGREEN = COLOR_LIGHTGREEN
TEXTCOLOR_DARKBROWN = COLOR_DARKBROWN
TEXTCOLOR_LIGHTBLUE = COLOR_LIGHTBLUE
TEXTCOLOR_DARKRED = COLOR_DARKRED
TEXTCOLOR_DARKPURPLE = COLOR_DARKPURPLE
TEXTCOLOR_BROWN = COLOR_BROWN
TEXTCOLOR_GREY = COLOR_GREY
TEXTCOLOR_TEAL = COLOR_TEAL
TEXTCOLOR_DARKPINK = COLOR_DARKPINK
TEXTCOLOR_PURPLE = COLOR_PURPLE
TEXTCOLOR_DARKORANGE = COLOR_DARKORANGE
TEXTCOLOR_RED = COLOR_RED
TEXTCOLOR_PINK = COLOR_PINK
TEXTCOLOR_ORANGE = COLOR_ORANGE
TEXTCOLOR_DARKYELLOW = COLOR_DARKYELLOW
TEXTCOLOR_YELLOW = COLOR_YELLOW
TEXTCOLOR_WHITE = COLOR_WHITE
TEXTCOLOR_NONE = COLOR_NONE

CONDITION_PARAM_STAT_MAXHITPOINTS = CONDITION_PARAM_STAT_MAXHEALTH
CONDITION_PARAM_STAT_MAXMANAPOINTS = CONDITION_PARAM_STAT_MAXMANA
CONDITION_PARAM_STAT_SOULPOINTS = CONDITION_PARAM_STAT_SOUL
CONDITION_PARAM_STAT_MAGICPOINTS = CONDITION_PARAM_STAT_MAGICLEVEL
CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT = CONDITION_PARAM_STAT_MAXHEALTHPERCENT
CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT = CONDITION_PARAM_STAT_MAXMANAPERCENT
CONDITION_PARAM_STAT_SOULPOINTSPERCENT = CONDITION_PARAM_STAT_SOULPERCENT
CONDITION_PARAM_STAT_MAGICPOINTSPERCENT = CONDITION_PARAM_STAT_MAGICLEVELPERCENT

CONDITION_PHYSICAL = CONDITION_BLEEDING

STACKPOS_FIRST_ITEM_ABOVE_GROUNDTILE = 1
STACKPOS_SECOND_ITEM_ABOVE_GROUNDTILE = 2
STACKPOS_THIRD_ITEM_ABOVE_GROUNDTILE = 3
STACKPOS_FOURTH_ITEM_ABOVE_GROUNDTILE = 4
STACKPOS_FIFTH_ITEM_ABOVE_GROUNDTILE = 5

WORLD_TYPE_NO_PVP = WORLDTYPE_OPTIONAL
WORLD_TYPE_PVP = WORLDTYPE_OPEN
WORLD_TYPE_PVP_ENFORCED = WORLDTYPE_HARDCORE

WORLDTYPE_NO_PVP = WORLDTYPE_OPTIONAL
WORLDTYPE_PVP = WORLDTYPE_OPEN
WORLDTYPE_PVP_ENFORCED = WORLDTYPE_HARDCORE

GUILDLEVEL_MEMBER = GUILD_MEMBER
GUILDLEVEL_VICE = GUILD_VICE
GUILDLEVEL_LEADER = GUILD_LEADER

DATABASE_ENGINE_NONE = DATABASE_NONE
DATABASE_ENGINE_MYSQL = DATABASE_MYSQL
DATABASE_ENGINE_SQLITE = DATABASE_SQLITE
DATABASE_ENGINE_POSTGRESQL = DATABASE_POSTGRESQL
DATABASE_ENGINE_ODBC = DATABASE_ODBC

CHANNEL_STAFF = 2
CHANNEL_COUNSELOR = 4
CHANNEL_GAMECHAT = 5
CHANNEL_TRADE = 6
CHANNEL_TRADEROOK = 7
CHANNEL_RLCHAT = 8

BANTYPE_IP_BANISHMENT = 1
BANTYPE_NAMELOCK = 2
BANTYPE_BANISHMENT = 3
BANTYPE_NOTATION = 4
BANTYPE_DELETION = 3

CONST_PROP_MOVEABLE = CONST_PROP_MOVABLE
CONST_PROP_BLOCKINGANDNOTMOVEABLE = CONST_PROP_BLOCKINGANDNOTMOVABLE

CONDITION_EARTH = CONDITION_POISON

STACKPOS_TOP_MOVEABLE_ITEM_OR_CREATURE = STACKPOS_TOP_MOVABLE_ITEM_OR_CREATURE

RETURNVALUE_NOTMOVEABLE = RETURNVALUE_NOTMOVABLE

SKILLS = SKILL_NAMES

table.getPos = table.find
doSetCreatureDropLoot = doCreatureSetDropLoot
doPlayerSay = doCreatureSay
doPlayerAddMana = doCreatureAddMana
playerLearnInstantSpell = doPlayerLearnInstantSpell
doPlayerRemOutfit = doPlayerRemoveOutfit
pay = doPlayerRemoveMoney
broadcastMessage = doBroadcastMessage
getPlayerName = getCreatureName
getCreaturePosition = getThingPosition
getPlayerPosition = getCreaturePosition
getCreaturePos = getCreaturePosition
creatureGetPosition = getCreaturePosition
getPlayerMana = getCreatureMana
getPlayerMaxMana = getCreatureMaxMana
hasCondition = getCreatureCondition
isMoveable = isMovable
isItemMoveable = isItemMovable
saveData = saveServer
savePlayers = saveServer
getPlayerSkill = getPlayerSkillLevel
getPlayerSkullType = getCreatureSkullType
getCreatureSkull = getCreatureSkullType
getAccountNumberByName = getAccountIdByName
getIPByName = getIpByName
getPlayersByIP = getPlayersByIp
getThingfromPos = getThingFromPos
getPlayersByAccountNumber = getPlayersByAccountId
getIPByPlayerName = getIpByName
getPlayersByIPNumber = getPlayersByIp
getAccountNumberByPlayerName = getAccountIdByName
convertIntToIP = doConvertIntegerToIp
convertIPToInt = doConvertIpToInteger
queryTileAddThing = doTileQueryAdd
getTileHouseInfo = getHouseFromPos
executeRaid = doExecuteRaid
saveServer = doSaveServer
cleanHouse = doCleanHouse
cleanMap = doCleanMap
shutdown = doShutdown
mayNotMove = doCreatureSetNoMove
doPlayerSetNoMove = doCreatureSetNoMove
getPlayerNoMove = getCreatureNoMove
getConfigInfo = getConfigValue
doPlayerAddExp = doPlayerAddExperience
isInArea = isInRange
doPlayerSetSkillRate = doPlayerSetRate
getCreatureLookDir = getCreatureLookDirection
getPlayerLookDir = getCreatureLookDirection
getPlayerLookDirection = getCreatureLookDirection
doCreatureSetLookDir = doCreatureSetLookDirection
getPlayerLookPos = getCreatureLookPosition
setPlayerStamina = doPlayerSetStamina
setPlayerPromotionLevel = doPlayerSetPromotionLevel
setPlayerGroupId = doPlayerSetGroupId
setPlayerPartner = doPlayerSetPartner
doPlayerSetStorageValue = doCreatureSetStorage
setPlayerStorageValue = doPlayerSetStorageValue
getPlayerStorageValue = getCreatureStorage
getGlobalStorageValue = getStorage
setGlobalStorageValue = doSetStorage
getPlayerMount = canPlayerRideMount
setPlayerBalance = doPlayerSetBalance
doAddMapMark = doPlayerAddMapMark
doSendTutorial = doPlayerSendTutorial
getWaypointsList = getWaypointList
getPlayerLastLoginSaved = getPlayerLastLogin
getThingPos = getThingPosition
doAreaCombatHealth = doCombatAreaHealth
doAreaCombatMana = doCombatAreaMana
doAreaCombatCondition = doCombatAreaCondition
doAreaCombatDispel = doCombatAreaDispel
getItemDescriptionsById = getItemInfo
hasProperty = hasItemProperty
hasClient = hasPlayerClient
print = std.cout
getPosByDir = getPositionByDirection
db.updateQueryLimitOperator = db.updateLimiter
db.stringComparisonOperator = db.stringComparer
db.stringComparison = db.stringComparer
db.executeQuery = db.query
isNumber = isNumeric
doSetItemActionId = doItemSetActionId
db.quote = db.escapeString

PlayerFlag_CannotUseCombat = 0
PlayerFlag_CannotAttackPlayer = 1
PlayerFlag_CannotAttackMonster = 2
PlayerFlag_CannotBeAttacked = 3
PlayerFlag_CanConvinceAll = 4
PlayerFlag_CanSummonAll = 5
PlayerFlag_CanIllusionAll = 6
PlayerFlag_CanSenseInvisibility = 7
PlayerFlag_IgnoredByMonsters = 8
PlayerFlag_NotGainInFight = 9
PlayerFlag_HasInfiniteMana = 10
PlayerFlag_HasInfiniteSoul = 11
PlayerFlag_HasNoExhaustion = 12
PlayerFlag_CannotUseSpells = 13
PlayerFlag_CannotPickupItem = 14
PlayerFlag_CanAlwaysLogin = 15
PlayerFlag_CanBroadcast = 16
PlayerFlag_CanEditHouses = 17
PlayerFlag_CannotBeBanned = 18
PlayerFlag_CannotBePushed = 19
PlayerFlag_HasInfiniteCapacity = 20
PlayerFlag_CanPushAllCreatures = 21
PlayerFlag_CanTalkRedPrivate = 22
PlayerFlag_CanTalkRedChannel = 23
PlayerFlag_TalkOrangeHelpChannel = 24
PlayerFlag_NotGainExperience = 25
PlayerFlag_NotGainMana = 26
PlayerFlag_NotGainHealth = 27
PlayerFlag_NotGainSkill = 28
PlayerFlag_SetMaxSpeed = 29
PlayerFlag_SpecialVIP = 30
PlayerFlag_NotGenerateLoot = 31
PlayerFlag_CanTalkRedChannelAnonymous = 32
PlayerFlag_IgnoreProtectionZone = 33
PlayerFlag_IgnoreSpellCheck = 34
PlayerFlag_IgnoreWeaponCheck = 35
PlayerFlag_CannotBeMuted = 36
PlayerFlag_IsAlwaysPremium = 37
PlayerFlag_38 = 38
PlayerFlag_39 = 39 -- ignore
PlayerFlag_ShowGroupNameInsteadOfVocation = 40
PlayerFlag_HasInfiniteStamina = 41
PlayerFlag_CannotMoveItems = 42
PlayerFlag_CannotMoveCreatures = 43
PlayerFlag_CanReportBugs = 44
PlayerFlag_45 = 45 -- ignore
PlayerFlag_CannotBeSeen = 46
PlayerFlag_HideHealth = 47
PlayerFlag_CanPassThroughAllCreatures = 48

PlayerCustomFlag_AllowIdle = 0
PlayerCustomFlag_CanSeePosition	= 1
PlayerCustomFlag_CanSeeItemDetails = 2
PlayerCustomFlag_CanSeeCreatureDetails = 3
PlayerCustomFlag_NotSearchable = 4
PlayerCustomFlag_GamemasterPrivileges = 5
PlayerCustomFlag_CanThrowAnywhere = 6
PlayerCustomFlag_CanPushAllItems = 7
PlayerCustomFlag_CanMoveAnywhere = 8
PlayerCustomFlag_CanMoveFromFar = 9
PlayerCustomFlag_CanLoginMultipleCharacters = 10
PlayerCustomFlag_HasFullLight = 11
PlayerCustomFlag_CanLogoutAnytime = 12
PlayerCustomFlag_HideLevel = 13
PlayerCustomFlag_IsProtected = 14
PlayerCustomFlag_IsImmune = 15
PlayerCustomFlag_NotGainSkull = 16
PlayerCustomFlag_NotGainUnjustified = 17
PlayerCustomFlag_IgnorePacification = 18
PlayerCustomFlag_IgnoreLoginDelay = 19
PlayerCustomFlag_CanStairhop = 20
PlayerCustomFlag_CanTurnhop = 21
PlayerCustomFlag_IgnoreHouseRent = 22
PlayerCustomFlag_CanWearAllAddons = 23
PlayerCustomFlag_IsWalkable = 24
PlayerCustomFlag_CanUseAllMounts = 25