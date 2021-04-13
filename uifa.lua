script_name('UIF Assistant')
script_dependencies('SAMP', 'SAMPFUNCS')
script_version_number(1)
script_moonloader(025)
script_author('Kraxar')

require "lib.moonloader"
require 'lib.sampfuncs'
local SE = require 'lib.samp.events'
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
local keys = require "vkeys"
local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = "CP1251"
u8 = encoding.UTF8

update_state = false

local script_vers = 3
local script_vers_text = "0.9b"

local script_url = "https://raw.githubusercontent.com/yuunusarslann/uifa/master/uifa.lua"
local script_path = thisScript().path

local update_url = "https://raw.githubusercontent.com/yuunusarslann/uifa/master/update.ini"
local update_path = getWorkingDirectory() .. "/update.ini"

local commands = {
--Level 1 Commands
  {
    name = "ins",
    reason = "Insulting a Staff",
    mute = 10,
    ban = 0,
    mban = 0,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "rsc",
    reason = "Racism",
    mute = 10,
    ban = 0,
    mban = 0,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "spm",
    reason = "Spamming",
    mute = 10,
    ban = 0,
    mban = 0,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
--Level 2 Commands
  {
    name = "fh",
    reason = "Fly Hacks",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "air",
    reason = "Airbreak",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "anf",
    reason = "Bike Anti-Fall",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "fsr",
    reason = "Fast Respawn",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "sph",
    reason = "Speed Hacks",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "ar",
    reason = "Anti-Ram",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "tph",
    reason = "Teleport Hacks",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "spr",
    reason = "Sprinthook",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "dev",
    reason = "Death Evasion",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "vhh",
    reason = "Vehicle Health Hacks",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "vjh",
    reason = "Vehicle Jump Hacks",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "jh",
    reason = "Jump Hacks",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "esc",
    reason = "ESC/Pause Menu Abuse",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "tk",
    reason = "Teamkilling",
    mute = 0,
    ban = 0,
    mban = 60,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "tkcnr",
    reason = "Teamkilling",
    mute = 0,
    ban = 0,
    mban = 30,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "sk",
    reason = "Spawnkilling",
    mute = 0,
    ban = 0,
    mban = 30,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "unf",
    reason = "Unfreeze",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "hand",
    reason = "Modified Handling",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "afk",
    reason = "Inactive",
    mute = 0,
    ban = 0,
    mban = 0,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 666
  },
--Level 3 Commands
  {
    name = "ab",
    reason = "Aimbot",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 60,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "rf",
    reason = "Rapid Fire",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 60,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "nr",
    reason = "No Reload",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 60,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "ns",
    reason = "No Spread",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 60,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "aura",
    reason = "Kill-Aura",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 60,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "as",
    reason = "Auto-Scroll",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 60,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "hh",
    reason = "Health Hacks",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 60,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "arm",
    reason = "Armor Hacks",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 60,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "whc",
    reason = "Wall Hacks",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 60,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "ac",
    reason = "Auto C-Bug",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 60,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "db",
    reason = "Drive-by Hacks",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 60,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "ews",
    reason = "Extra WS",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 60,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "alo",
    reason = "Aimlock",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 60,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "fg",
    reason = "Fugga",
    mute = 0,
    ban = 0,
    mban = 180,
    disarm = 0,
    jail = 15,
    kick = 0,
    mkick = 0
  },
  {
    name = "ram",
    reason = "Ramming",
    mute = 0,
    ban = 0,
    mban = 0,
    disarm = 0,
    jail = 15,
    kick = 0,
    mkick = 0
  },
  {
    name = "heli",
    reason = "Heli-Killing",
    mute = 0,
    ban = 0,
    mban = 0,
    disarm = 0,
    jail = 15,
    kick = 0,
    mkick = 0
  },
  {
    name = "wi",
    reason = "Weapons In Interiors",
    mute = 0,
    ban = 0,
    mban = 0,
    disarm = 60,
    jail = 0,
    kick = 0,
    mkick = 0
  },
--Level 4 Commands
  {
    name = "def",
    reason = "Defamatory Remarks Against Server",
    mute = 0,
    ban = 666,
    mban = 0,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "hos",
    reason = "Hostile",
    mute = 0,
    ban = 666,
    mban = 0,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "imp",
    reason = "Staff Impersonation",
    mute = 0,
    ban = 666,
    mban = 0,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "ad",
    reason = "Advertising",
    mute = 0,
    ban = 666,
    mban = 0,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  },
  {
    name = "des",
    reason = "Desynced",
    mute = 0,
    ban = 0,
    mban = 0,
    disarm = 0,
    jail = 0,
    kick = 666,
    mkick = 0
  },
  {
    name = "rtd",
    reason = "Retard",
    mute = 0,
    ban = 666,
    mban = 0,
    disarm = 0,
    jail = 0,
    kick = 0,
    mkick = 0
  }
}

local listitems = [[Level 1 Commands
Level 2 Commands
Level 3 Commands
Level 4 Commands
Level 5 Commands
Miscellaneous Commands
]]
 
local bstatsitems = [[Sawn-Off Shotgun
Desert Eagle
Sniper & Country Rifle
M4 & AK-47
TEC9 & UZI
Combat Shotgun
Shotgun
Silenced Pistol
Bullet Distance Values
]]

local sos = [[{00FF00}Sawn-Off Shotgun Bullet Stats Values

{FFFF00}Scenario: {FFFFFF}DUEL
{00FFFF}Ratio: {FFFFFF}91%+
{00FFFF}Sequence: {FFFFFF}20+

{FFFF00}Scenario: {FFFFFF}GWAR/GZ/DM
{00FFFF}Ratio: {FFFFFF}76%+
{00FFFF}Sequence: {FFFFFF}13+
]]

local deagle = [[{00FF00}Desert Eagle Bullet Stats Values

{FFFF00}Scenario: {FFFFFF}No C-Bug & GWAR/GZ/DM/DUEL
{00FFFF}Ratio: {FFFFFF}60%+
{00FFFF}Sequence: {FFFFFF}6+

{FFFF00}Scenario: {FFFFFF}Regular C-Bug & DUEL
{00FFFF}Ratio: {FFFFFF}60%+
{00FFFF}Sequence: {FFFFFF}5+

{FFFF00}Scenario: {FFFFFF}Regular C-Bug & GWAR/GZ/DM
{00FFFF}Ratio: {FFFFFF}53%+
{00FFFF}Sequence: {FFFFFF}4+

{FFFF00}Scenario: {FFFFFF}Rapid C-Bug & GWAR/GZ/DM/DUEL
{00FFFF}Ratio: {FFFFFF}45%+
{00FFFF}Sequence: {FFFFFF}4+
]]

local sniper = [[{00FF00}Sniper & Country Rifle Bullet Stats Values

{FFFF00}Scenario: {FFFFFF}GZ/GWAR - Player Weapon Set
{00FFFF}Ratio: {FFFFFF}55%+
{00FFFF}Sequence: {FFFFFF}5+

{FFFF00}Scenario: {FFFFFF}GWAR/GZ/DM/DUEL - 'Deagle, Shotgun, Sniper' Weapon Set
{00FFFF}Ratio: {FFFFFF}67%+
{00FFFF}Sequence: {FFFFFF}5+
]]

local mfour = [[{00FF00}M4 & AK-47 Bullet Stats Values

{00FFFF}Ratio: {FFFFFF}50%+
{00FFFF}Sequence: {FFFFFF}7+
]]

local uzi = [[{00FF00}TEC9 & UZI Bullet Stats Values

{00FFFF}Ratio: {FFFFFF}40%+
{00FFFF}Sequence: {FFFFFF}5+
]]

local combat = [[{00FF00}Combat Shotgun Bullet Stats Values

{00FFFF}Ratio: {FFFFFF}70%+
{00FFFF}Sequence: {FFFFFF}7+
]]

local shotgun = [[{00FF00}Shotgun Bullet Stats Values

{00FFFF}Ratio: {FFFFFF}70%+
{00FFFF}Sequence: {FFFFFF}5+
]]

local silencedpistol = [[{00FF00}Silenced Pistol Bullet Stats Values

{00FFFF}Ratio: {FFFFFF}45%+
{00FFFF}Sequence: {FFFFFF}4+
]]

local distance = [[{00FF00}Bullet Distance Values

{00FFFF}- Colt 45 (ID 22)
{00FF00}- {FFFFFF}Max. Bullet Distance: 40.0

{00FFFF}- Silenced Pistol (ID 23)
{00FF00}- {FFFFFF}Max. Bullet Distance: 40.0

{00FFFF}- Desert Eagle (ID 24)
{00FF00}- {FFFFFF}Max. Bullet Distance: 40.0

{00FFFF}- Shotgun (ID 25)
{00FF00}- {FFFFFF}Max. Bullet Distance: 35.0

{00FFFF}- Sawn-Off Shotgun (ID 26)
{00FF00}- {FFFFFF}Max. Bullet Distance: 20.0

{00FFFF}- Combat Shotgun (ID 27)
{00FF00}- {FFFFFF}Max. Bullet Distance: 40.0

{00FFFF}- UZI (ID 28)
{00FF00}- {FFFFFF}Max. Bullet Distance: 50.0

{00FFFF}- MP5 (ID 29)
{00FF00}- {FFFFFF}Max. Bullet Distance: 75.0

{00FFFF}- AK47 (ID 30)
{00FF00}- {FFFFFF}Max. Bullet Distance: 150.0

{00FFFF}- M4 (ID 31)
{00FF00}- {FFFFFF}Max. Bullet Distance: 150.0

{00FFFF}- TEC9 (ID 32)
{00FF00}- {FFFFFF}Max. Bullet Distance: 50.0

{00FFFF}- Rifle (ID 33)
{00FF00}- {FFFFFF}Max. Bullet Distance: 150.0

{00FFFF}- Sniper (ID 34)
{00FF00}- {FFFFFF}Max. Bullet Distance: 300.0

{00FFFF}- Minigun (ID 38)
{00FF00}- {FFFFFF}Max. Bullet Distance: 100.0
]]

local levelone = [[{00FF00}Example Command Usage
{FFFFFF}'{00FFFF}/rsc [ID]{FFFFFF}' to mute a player for racism.

{00FF00}Level 1 Commands List
{00FFFF}/nbv{FFFFFF} - Shortcut for /nearbyvipitems.
{00FFFF}/ins{FFFFFF} - Mutes the player for insulting staff.
{00FFFF}/spm{FFFFFF} - Mutes the player for excessive spamming. 
{00FFFF}/rsc{FFFFFF} - Mutes the player for racism.
]]

local leveltwo = [[{00FF00}Example Command Usage
{FFFFFF}'{00FFFF}/fh [ID]{FFFFFF}' to mode ban a player for using fly hacks.

{00FF00}Level 2 Commands List
{00FFFF}/s - {FFFFFF}Shortcut for /spec.
{00FFFF}/fh - {FFFFFF}Mode bans the player for fly hacks.
{00FFFF}/air - {FFFFFF}Mode bans the player for airbreak.
{00FFFF}/anf - {FFFFFF}Mode bans the player for anti-fall.
{00FFFF}/fsr - {FFFFFF}Mode bans the player for fast respawn.
{00FFFF}/sph - {FFFFFF}Mode bans the player for speed hacks.
{00FFFF}/ar - {FFFFFF}Mode bans the player for anti-ram.
{00FFFF}/tph - {FFFFFF}Mode bans the player for teleport hacks.
{00FFFF}/spr - {FFFFFF}Mode bans the player for sprinthook.
{00FFFF}/dev - {FFFFFF}Mode bans the player for death evasion.
{00FFFF}/vhh - {FFFFFF}Mode bans the player for vehicle health hacks.
{00FFFF}/vjh - {FFFFFF}Mode bans the player for vehicle jump hacks.
{00FFFF}/esc - {FFFFFF}Mode bans the player for esc abuse.
{00FFFF}/tk - {FFFFFF}Mode bans the player for teamkilling.
{00FFFF}/tkcnr - {FFFFFF}Mode bans the player for teamkilling in CNR.
{00FFFF}/sk - {FFFFFF}Mode bans the player for spawnkilling.
{00FFFF}/unf - {FFFFFF}Mode bans the player for unfreeze.
{00FFFF}/hand - {FFFFFF}Mode bans the player for modified handling.
{00FFFF}/afk - {FFFFFF}Mode kicks the player for inactivity.
]]

local levelthree = [[{00FF00}Example Command Usage
{FFFFFF}'{00FFFF}/ab [ID]{FFFFFF}' to mode ban and disarm a player for using aimbot.

{00FF00}Level 3 Commands List
{00FFFF}/rbs - {FFFFFF}Shortcut for /rbstats. (/rbs [ID])
{00FFFF}/bst - {FFFFFF}Shortcut for /bstats. (/bst [ID] [Weapon])
{00FFFF}/bss - {FFFFFF}/spec and /bstats simultaneously. (/bss [ID] [Weapon])
{00FFFF}/munban - {FFFFFF} Unbans the player from specified game mode. (/munban [ID] [Game mode])
{00FFFF}/ab - {FFFFFF}Mode bans and disarms the player for aimbot.
{00FFFF}/rf - {FFFFFF}Mode bans and disarms the player for rapid fire.
{00FFFF}/nr - {FFFFFF}Mode bans and disarms the player for no reload.
{00FFFF}/ns - {FFFFFF}Mode bans and disarms the player for no spread.
{00FFFF}/aura - {FFFFFF}Mode bans and disarms the player for kill-aura.
{00FFFF}/as - {FFFFFF}Mode bans and disarms the player for auto-scroll.
{00FFFF}/hh - {FFFFFF}Mode bans and disarms the player for health hacks.
{00FFFF}/arm - {FFFFFF}Mode bans and disarms the player for armor hacks
{00FFFF}/whc - {FFFFFF}Mode bans and disarms the player for wall hacks.
{00FFFF}/ac - {FFFFFF}Mode bans and disarms the player for auto c-bug.
{00FFFF}/db - {FFFFFF}Mode bans and disarms the player for drive-by hacks.
{00FFFF}/ews - {FFFFFF}Mode bans and disarms the player for ExtraWS.
{00FFFF}/alo - {FFFFFF}Mode bans and disarms the player for Aimlock.
{00FFFF}/fg - {FFFFFF}Mode bans and jails the player for fugga.
{00FFFF}/ram - {FFFFFF}Jails the player for ramming.
{00FFFF}/heli - {FFFFFF}Jails for the player heli-killing.
{00FFFF}/wi - {FFFFFF}Disarms the player for abusing weapons in interiors.
]]

local levelfour = [[{00FF00}Example Command Usage
{FFFFFF}'{00FFFF}/ad [ID]{FFFFFF}' to server ban a player for advertising.

{00FF00}Level 4 Commands List
{00FFFF}/ad - {FFFFFF}Server bans the player for advertising.
{00FFFF}/imp - {FFFFFF}Server bans the player for admin impersonation.
{00FFFF}/def - {FFFFFF}Server bans the player for defamatory remarks.
{00FFFF}/hos - {FFFFFF}Server bans the player for hostile.
{00FFFF}/des - {FFFFFF}Server kicks the player for desynchronization.
]]

local levelfive = [[{00FF00}Example Command Usage
{FFFFFF}'{00FFFF}/mrl [room ID]{FFFFFF}' to reload a gamemode by name.

{00FF00}Level 5 Commands List
{00FFFF}/mrl - {FFFFFF}Reloads the specified gamemode room with selected map's name.
]]

local misc = [[{00FF00}Miscellaneous Commands List
{00FFFF}/help - {FFFFFF}Displays available commands.
{00FFFF}/news - {FFFFFF}Shows the recent update's change log.
{00FFFF}/bsv - {FFFFFF}Lists all weapons' bullet stats values.
{00FFFF}/check - {FFFFFF}Checks if the script is running.
{00FFFF}/relog [NAME] - {FFFFFF}Relogs in with a new name.
{00FFFF}/reconnect - {FFFFFF}Reconnects to the server.
]]

local news = [[{00FF00}UIF Assistant v0.9 Update {FFFFFF}- 08.04.2021

{00FFFF}General
{00FF00}- {FFFFFF}Optimized weapon values in /bsv to newly structured bstats paremeters.
{00FF00}- {FFFFFF}Removed Island Competition Announcer.
{00FF00}- {FFFFFF}Added Discord Server Announcer. (/adisc)

{00FFFF}Commands
{00FF00}- {FFFFFF}Level 1: New command - /nbv: Shortcut for /nearbyvipitems.
{00FF00}- {FFFFFF}Level 2: New command - /s: Shortcut for /spec.
{00FF00}- {FFFFFF}Level 2: New command - /tkcnr: CNR version of /tk which mode bans the player for teamkilling.
{00FF00}- {FFFFFF}Level 2: New command - /unf: Mode bans the player for unfreezing during freeze time.
{00FF00}- {FFFFFF}Level 2: New command - /hand: Mode bans the player for modified handling usage.
{00FF00}- {FFFFFF}Level 3: New Command - /alo: Mode bans and disarms the player for Aimlock usage.
{00FF00}- {FFFFFF}Level 3: New Command - /ews: Mode bans and disarms the player for ExtraWS usage.
{00FF00}- {FFFFFF}Level 3: New Command - /munban: Unbans the player from specified game mode. (/help - LV3 FMI)
{00FF00}- {FFFFFF}Level 3: New Command - /rbs: Shortcut for /rbstats.
{00FF00}- {FFFFFF}Level 3: New Command - /bst: Shortcut for /bstats.
{00FF00}- {FFFFFF}Level 3: New Command - /bss: /spec and /bstats simultaneously. (eg: /bss 92 24)
]]

local gamemodes = [[Deathmatch
Derby
Race
Fall
Protect the President
Cops N' Robbers
]]

local dm = [[Random
Aircraft Carrier
Counter Strike
Glass
Grenade
Golf Course
Minigun
Rocket
Silenced Pistol
Sniper
War Zone
Desert Eagle
Desert Eagle 2
Sawn-Off Shotgun
Desert Eagle 4
]]

local race = [[Random
AA Drag
BMX Mount Chiliad
Bridge Drag
Caddy
Circuit
Circuit 2
Country Drift
Drag
Drift
Harbour
Highway
Highway 2
Highway 3
Highway 4
Hill Drift
Hotring
Hotring 2
Kart
LSA Drag
LSA Drift
Monster Climb
NRG
NRG 2
NRG 3
NRG 4
NRG Red County
Offroad
Panopticon Drift
Parking Drift
Quad
River Speed
Runway Drift
SFA Drag
Street
Street 2
Street 3
Street 4
Vortex
]]

local fall = [[Random
Pilot
Dancing Arena
Observation Point
Triangle Tower
Sky Bridge
]]

local ptp = [[Random
Las Venturas
San Fierro
Los Santos
Desert
]]

local cnr = [[Random
San Fierro
Las Venturas
]]

local derby = [[Random
New Generation
Wheel of Fate (Altuev)
2020 (Altuev)
Pilot
Sphinx
Sky
Pyramid
Bridge
Pirate Islands
Desert Islands
Volcanic Islands
Battlefield
Construction Site
Stadium Arena
Skull
Level 3
Chiliad Skull
Angle
Hexagon
Square
Circle
Tube Madness
Random Luck
Golf Caddy
Pirates
Reactor
Atlantis
Stadium
Skyscraper
Space Ship (Altuev_Ruslan)
Arena Compass
Scorpion
UFO
Star Wars (Altuev)
Balloons
Kingdom
Lonely Strangers
Ten
Star Gate
VITA
]]

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

	sampAddChatMessage("[UIFA]: {FFFFFF}UIF Assistant v0.9a - {00FF00}/help", 0x00FFFF)
	sampRegisterChatCommand('help', help)
	sampRegisterChatCommand("adisc", functionUAadisc)   
	sampRegisterChatCommand("check", functionUAcheck)
	sampRegisterChatCommand("uifavers", functionUAvers)			
	sampRegisterChatCommand("relog", functionUArelog) 
	sampRegisterChatCommand("reconnect", functionUAreconnect) 
	sampRegisterChatCommand('bss', bss)
	sampRegisterChatCommand('bst', bst)
	sampRegisterChatCommand('bsv', bsv)
	sampRegisterChatCommand('munban', munban)

	_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
	nick = sampGetPlayerNickname(id)

	downloadUrlToFile(update_url, update_path, function(id, status)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			updateIni = inicfg.load(nil, update_path)
			if tonumber(updateIni.info.vers) > script_vers then
				sampAddChatMessage("[UIFA] {FFFFFF}New version of UIFA has been released! {00FF00}" .. updateIni.info.vers_text, 0x00FFFF)
				update_state = true
			end
			os.remove(update_path)
		end
	end)

	while true do 
		wait(0)

		if update_state then
			downloadUrlToFile(script_url, script_path, function(id, status)
				if status == dlstatus.STATUS_ENDDOWNLOADDATA then
					sampAddChatMessage("Something happened!", 0xFF0000)
					thisScript():reload()
				end
			end)
			break
		end

	end
end

function checker()
	while sampIsDialogActive() do
		wait(0)
		local result, button, list, input = sampHasDialogRespond(1337)
		if result then
			if button == 1 then 
				if list == 0 then
					wait(50)
					sampShowDialog(2001, "{00FF00}UIFA - Admin Commands", levelone, "OK", "", DIALOG_STYLE_MSGBOX)
				elseif list == 1 then
					wait(50)
					sampShowDialog(2002, "{00FF00}UIFA - Admin Commands", leveltwo, "OK", "", DIALOG_STYLE_MSGBOX)
				elseif list == 2 then
					wait(50)
					sampShowDialog(2003, "{00FF00}UIFA - Admin Commands", levelthree, "OK", "", DIALOG_STYLE_MSGBOX)
				elseif list == 3 then
					wait(50)				
					sampShowDialog(2004, "{00FF00}UIFA - Admin Commands", levelfour, "OK", "", DIALOG_STYLE_MSGBOX)
				elseif list == 4 then
					wait(50)				
					sampShowDialog(2005, "{00FF00}UIFA - Admin Commands", levelfive, "OK", "", DIALOG_STYLE_MSGBOX)
				elseif list == 5 then
					wait(50)
					sampShowDialog(2006, "{00FF00}UIFA - Miscellaneous Commands", misc, "OK", "", DIALOG_STYLE_MSGBOX)
				end
			else
				wait(50)
			end
		end
	end
end

function checkerBstats()
	while sampIsDialogActive() do
		wait(0)
		local result, button, list, input = sampHasDialogRespond(9890)
		if result then
			if button == 1 then 
				if list == 0 then
					wait(50)
					sampShowDialog(9891, "{00FF00}UIFA - Bullet Stats Values", sos, "OK", "", DIALOG_STYLE_MSGBOX)
				elseif list == 1 then
					wait(50)
					sampShowDialog(9892, "{00FF00}UIFA - Bullet Stats Values", deagle, "OK", "", DIALOG_STYLE_MSGBOX)
				elseif list == 2 then
					wait(50)
					sampShowDialog(9893, "{00FF00}UIFA - Bullet Stats Values", sniper, "OK", "", DIALOG_STYLE_MSGBOX)
				elseif list == 3 then
					wait(50)				
					sampShowDialog(9894, "{00FF00}UIFA - Bullet Stats Values", mfour, "OK", "", DIALOG_STYLE_MSGBOX)
				elseif list == 4 then
					wait(50)				
					sampShowDialog(9895, "{00FF00}UIFA - Bullet Stats Values", uzi, "OK", "", DIALOG_STYLE_MSGBOX)
				elseif list == 5 then
					wait(50)
					sampShowDialog(9897, "{00FF00}UIFA - Bullet Stats Values", combat, "OK", "", DIALOG_STYLE_MSGBOX)
				elseif list == 6 then
					wait(50)
					sampShowDialog(9898, "{00FF00}UIFA - Bullet Stats Values", shotgun, "OK", "", DIALOG_STYLE_MSGBOX)
				elseif list == 7 then
					wait(50)
					sampShowDialog(9899, "{00FF00}UIFA - Bullet Stats Values", silencedpistol, "OK", "", DIALOG_STYLE_MSGBOX)
				elseif list == 8 then
					wait(50)
					sampShowDialog(9900, "{00FF00}UIFA - Bullet Stats Values", distance, "OK", "", DIALOG_STYLE_MSGBOX)
				end
			else
				wait(50)
			end
		end
	end
end


function checkerMap()
	while sampIsDialogActive() do
		wait(0)

		local result, button, list, input = sampHasDialogRespond(21)
		if result then
			if button == 1 then
				if list == 0 then
					wait(100)
					sampShowDialog(31, "{00FF00}UIFA - Select Map", dm, "Select", "Cancel", 2)
					lua_thread.create(checkerReset01)
				elseif list == 1 then
					wait(100)
					sampShowDialog(32, "{00FF00}UIFA - Select Map", derby, "Select", "Cancel", 2)
					lua_thread.create(checkerReset02)
				elseif list == 2 then
					wait(100)
					sampShowDialog(33, "{00FF00}UIFA - Select Map", race, "Select", "Cancel", 2)
					lua_thread.create(checkerReset03)
				elseif list == 3 then
					wait(100)
					sampShowDialog(34, "{00FF00}UIFA - Select Map", fall, "Select", "Cancel", 2)
					lua_thread.create(checkerReset04)
				elseif list == 4 then
					wait(100)
					sampShowDialog(35, "{00FF00}UIFA - Select Map", ptp, "Select", "Cancel", 2)
					lua_thread.create(checkerReset05)
				elseif list == 5 then
					wait(100)
					sampShowDialog(36, "{00FF00}UIFA - Select Map", cnr, "Select", "Cancel", 2)
					lua_thread.create(checkerReset06)
				end
			else
				wait(100)
			end
		end
	end
end

-- General Commands

function functionUAcheck(check)
    sampShowDialog(12800, "{00FF00}UIFA - Status", "{00FFFF}UIF Assistant {FFFFFF}is up and working!", "OK", "", DIALOG_STYLE_MSGBOX)
end

function functionUAvers(check)
	sampAddChatMessage(string.format('UIFA is on version ' .. script_vers_text), 0xFF0000)
end

function functionUAadisc()
    sampSendChat("*<white>United Islands Freeroam's <aqua>Official Discord Server is waiting for you!")
    sampSendChat("*Join the Discord Server now! <green>www.uifserver.net/discord")
end

function functionUArelog(arg)
    if #arg == 0 then
        sampShowDialog(12800, "{00FF00}UIFA - Relog", "{FFFFFF}You must type a name to relog with. {00FFFF}(/relog [name])", "OK", "", DIALOG_STYLE_MSGBOX)
    else
        sampShowDialog(12800, "{00FF00}UIFA - Relog", "{FFFFFF}Relogging to the server as {00FFFF}"..arg.."", "OK", "", DIALOG_STYLE_MSGBOX)
        sampDisconnectWithReason(true)
        sampSetLocalPlayerName(arg)
        sampConnectToServer("51.254.85.134", 7776)
    end
end

function functionUAreconnect(reconnect)
    ip, port = sampGetCurrentServerAddress()
        sampShowDialog(12800, "{00FF00}UIFA - Reconnect", "{FFFFFF}Reconnecting to the server...", "OK", "", DIALOG_STYLE_MSGBOX)

    lua_thread.create(function ()
        wait(150)
        sampDisconnectWithReason(false)

        wait(3500)
        sampConnectToServer(ip, port)
    end)
end

function help()
	sampShowDialog(1337, '{00FF00}UIFA - Commands', listitems, 'Select', 'Cancel', 2)
	lua_thread.create(checker)
end

function bss(arg)
	var1, var2 = string.match(arg, "(.+) (.+)")

	if var1 and var2 then
		sampSendChat(string.format('/spec %d', var1))
		sampSendChat(string.format('/bstats %d %d', var1, var2))
	else
		sampAddChatMessage("[UIFA] {ffffff}Invalid or missing weapon ID. {00ff00}(/bss [player ID] [weapon ID])", 0x00FFFF)
	end
end

function bst(arg)
	var1, var2 = string.match(arg, "(.+) (.+)")

	if var1 and var2 then
		sampSendChat(string.format('/bstats %d %d', var1, var2))
	else
		sampAddChatMessage("[UIFA] {ffffff}Invalid or missing weapon ID. {00ff00}(/bst [player ID] [weapon ID])", 0x00FFFF)
	end
end

function munban(arg)
	var1, var2 = string.match(arg, "(.+) (.+)")

	if var1 and var2 then
		sampSendChat(string.format('/mban2 %d %s 0 Incorrect ban - Unbanned', var1, var2))
	else
		sampAddChatMessage("[UIFA] {ffffff}Invalid or missing game mode. {00ff00}(/munban [Player ID] [Game Mode])", 0x00FFFF)
	end
end

function bsv()
	sampShowDialog(9890, '{00FF00}UIFA - Bullet Stats Values', bstatsitems, 'Select', 'Cancel', 2)
	lua_thread.create(checkerBstats)
end

if not sampRegisterChatCommand("news", function(args)

    sampShowDialog(12800, "{00FF00}UIFA - Update Log", news, "OK", "", DIALOG_STYLE_MSGBOX)

end) then
    print("Unable to register command: /news")
end

-- Start of Admin Commands

for _, t in pairs(commands) do
  if not sampRegisterChatCommand(t["name"], function(args)
    if #args ~= 0 then
      local id = math.floor(tonumber(args))

      if id and id >= 0 and id <= 500 then
        if t["mban"] ~= 0 then
          sampSendChat(string.format("/mban %d %d %s", id, t["mban"], t["reason"]), 0x00FFFF)
        end

        if t["disarm"] ~= 0 then
          sampSendChat(string.format("/disarm %d %d %s", id, t["disarm"], t["reason"]), 0x00FFFF)
        end

        if t["jail"] ~= 0 then
          sampSendChat(string.format("/jail %d %d %s", id, t["jail"], t["reason"]), 0x00FFFF)
        end

        if t["ban"] ~= 0 then
          sampSendChat(string.format("/ban %d %s", id, t["reason"]), 0x00FFFF)
        end

        if t["kick"] ~= 0 then
          sampSendChat(string.format("/kick %d %s", id, t["reason"]), 0x00FFFF)
        end

        if t["mkick"] ~= 0 then
          sampSendChat(string.format("/mkick %d %s", id, t["reason"]), 0x00FFFF)
        end

        if t["mute"] ~= 0 then
          sampSendChat(string.format("/mute %d %d %s", id, t["mute"], t["reason"]), 0x00FFFF)
        end
      else
        sampAddChatMessage("[UIFA]: {FF0000}Player is not online.", 0x00FFFF)
      end
    end
  end) then
    print(string.format("Unable to register chat command: /%s", t["name"]))
  end
end

if not sampRegisterChatCommand("s", function(args)
    if #args > 0 then
        local id = math.floor(tonumber(args))

        if id and id >= 0 and id <= 500 then
            sampSendChat(string.format('/spec %d', id))
        else
            sampAddChatMessage("[UIFA]: {FF0000}Player is not online.", 0x00FFFF)
        end
    end 
end) then
    print("Unable to register command: /s")
end

if not sampRegisterChatCommand("sts", function(args)
    if #args > 0 then
        local id = math.floor(tonumber(args))

        if id and id >= 0 and id <= 500 then
            sampSendChat(string.format('/stats %d', id))
        else
            sampAddChatMessage("[UIFA]: {FF0000}Player is not online.", 0x00FFFF)
        end
    end 
end) then
    print("Unable to register command: /sts")
end

if not sampRegisterChatCommand("pts", function(args)
    if #args > 0 then
        local id = math.floor(tonumber(args))

        if id and id >= 0 and id <= 500 then
            sampSendChat(string.format('/pnetstats %d', id))
        else
            sampAddChatMessage("[UIFA]: {FF0000}Player is not online.", 0x00FFFF)
        end
    end 
end) then
    print("Unable to register command: /pts")
end

if not sampRegisterChatCommand("rbs", function(args)
    if #args > 0 then
        local id = math.floor(tonumber(args))

        if id and id >= 0 and id <= 500 then
            sampSendChat(string.format('/rbstats %d', id))
        else
            sampAddChatMessage("[UIFA]: {FF0000}Player is not online.", 0x00FFFF)
        end
    end 
end) then
    print("Unable to register command: /rbs")
end

if not sampRegisterChatCommand("nbv", function(args)
	sampSendChat(string.format('/nearbyvipitems'))
end) then
    print("Unable to register command: /nbv")
end

-- End of Admin Commands

-- Start of MRL

if not sampRegisterChatCommand("mrl", function(args)
    if #args > 0 then
        local roomID = math.floor(tonumber(args))

        if roomID and roomID >= 0 and roomID <= 20 then
			sampShowDialog(21, '{00FF00}UIFA - Select Gamemode', gamemodes, 'Select', 'Cancel', 2)
			lua_thread.create(checkerMap)
		else
			sampAddChatMessage("[UIFA]: Entered room does not exist.", 0xFF0000)
		end
	else
			sampAddChatMessage("[UIFA]: Incorrect input, please use /mrl [room ID]", 0xFF0000)
    end

	function checkerReset01()
		while sampIsDialogActive() do
			wait(0)
	
			local result, button, list, input = sampHasDialogRespond(31)
			if result then
				if button == 1 then
					if list == 0 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Deathmatch room "..args.." to Random", 0x00FFFF)
						sampSendChat(string.format('/rldm '..args..' -1'))
					elseif list == 1 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Deathmatch room "..args.." to Aircraft Carrier", 0x00FFFF)
						sampSendChat(string.format('/rldm '..args..' 0'))
					elseif list == 2 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Deathmatch room "..args.." to Counter Strike", 0x00FFFF)				
						sampSendChat(string.format('/rldm '..args..' 1'))
					elseif list == 3 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Deathmatch room "..args.." to Glass", 0x00FFFF)				
						sampSendChat(string.format('/rldm '..args..' 2'))
					elseif list == 4 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Deathmatch room "..args.." to Grenade", 0x00FFFF)				
						sampSendChat(string.format('/rldm '..args..' 3'))
					elseif list == 5 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Deathmatch room "..args.." to Golf Course", 0x00FFFF)				
						sampSendChat(string.format('/rldm '..args..' 4'))
					elseif list == 6 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Deathmatch room "..args.." to Minigun", 0x00FFFF)				
						sampSendChat(string.format('/rldm '..args..' 5'))
					elseif list == 7 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Deathmatch room "..args.." to Rocket", 0x00FFFF)				
						sampSendChat(string.format('/rldm '..args..' 6'))
					elseif list == 8 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Deathmatch room "..args.." to Silenced Pistol", 0x00FFFF)				
						sampSendChat(string.format('/rldm '..args..' 7'))
					elseif list == 9 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Deathmatch room "..args.." to Sniper", 0x00FFFF)				
						sampSendChat(string.format('/rldm '..args..' 8'))
					elseif list == 10 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Deathmatch room "..args.." to War Zone", 0x00FFFF)				
						sampSendChat(string.format('/rldm '..args..' 9'))
					elseif list == 11 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Deathmatch room "..args.." to Desert Eagle", 0x00FFFF)				
						sampSendChat(string.format('/rldm '..args..' 10'))
					elseif list == 12 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Deathmatch room "..args.." to Desert Eagle 2", 0x00FFFF)				
						sampSendChat(string.format('/rldm '..args..' 11'))
					elseif list == 13 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Deathmatch room "..args.." to Sawn-Off Shotgun", 0x00FFFF)				
						sampSendChat(string.format('/rldm '..args..' 12'))
					elseif list == 14 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Deathmatch room "..args.." to Desert Eagle 4", 0x00FFFF)				
						sampSendChat(string.format('/rldm '..args..' 13'))
					end
				else
					wait(100)
				end
			end
		end
	end	

	function checkerReset02()
		while sampIsDialogActive() do
			wait(0)
	
			local result, button, list, input = sampHasDialogRespond(32)
			if result then
				if button == 1 then
					if list == 0 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Random", 0x00FFFF)
    	    		    sampSendChat(string.format('/rlderby '..args..' -1'))
					elseif list == 1 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to New Generation", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 0'))
					elseif list == 2 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Wheel of Fate (Altuev)", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 1'))
					elseif list == 3 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to 2020 (Altuev)", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 2'))
					elseif list == 4 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Pilot", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 3'))
					elseif list == 5 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Sphinx", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 4'))
					elseif list == 6 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Sky", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 5'))
					elseif list == 7 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Pyramid", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 6'))
					elseif list == 8 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Bridge", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 7'))
					elseif list == 9 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Pirate Islands", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 8'))
					elseif list == 10 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Desert Islands", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 9'))
					elseif list == 11 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Volcanic Islands", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 10'))
					elseif list == 12 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Battlefield", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 11'))
					elseif list == 13 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Construction Site", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 12'))
					elseif list == 14 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Stadium Arena", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 13'))
					elseif list == 15 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Skull", 0x00FFFF)
    	    		    sampSendChat(string.format('/rlderby '..args..' 14'))
					elseif list == 16 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Level 3", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 15'))
					elseif list == 17 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Chiliad Skull", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 16'))
					elseif list == 18 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Angle", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 17'))
					elseif list == 19 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Hexagon", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 18'))
					elseif list == 20 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Square", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 19'))
					elseif list == 21 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Circle", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 20'))
					elseif list == 22 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Tube Madness", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 21'))
					elseif list == 23 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Random Luck", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 22'))
					elseif list == 24 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Golf Caddy", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 23'))
					elseif list == 25 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Pirates", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 24'))
					elseif list == 26 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Reactor", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 25'))
					elseif list == 27 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Atlantis", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 26'))
					elseif list == 28 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Stadium", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 27'))
					elseif list == 29 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Skyscraper", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 28'))
					elseif list == 30 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Space Ship (Altuev_Ruslan)", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 29'))
					elseif list == 31 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Arena Compass", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 30'))
					elseif list == 32 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Scorpion", 0x00FFFF)
    	    		    sampSendChat(string.format('/rlderby '..args..' 31'))
					elseif list == 33 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to UFO", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 32'))
					elseif list == 34 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Star Wars (Altuev)", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 33'))
					elseif list == 35 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Balloons", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 34'))
					elseif list == 36 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Kingdom", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 35'))
					elseif list == 37 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Lonely Strangers", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 36'))
					elseif list == 38 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Ten", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 37'))
					elseif list == 39 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to Star Gate", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 38'))
					elseif list == 40 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Derby room "..args.." to VITA", 0x00FFFF)				
    	    		    sampSendChat(string.format('/rlderby '..args..' 39'))
					end
				else
					wait(100)
				end
			end
		end
	end

	function checkerReset03()
		while sampIsDialogActive() do
			wait(0)
	
			local result, button, list, input = sampHasDialogRespond(33)
			if result then
				if button == 1 then
					if list == 0 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Random", 0x00FFFF)
	        		    sampSendChat(string.format('/rlrace '..args..' -1'))
					elseif list == 1 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to AA Drag", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 0'))
					elseif list == 2 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to BMX Mount Chiliad", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 1'))
					elseif list == 3 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Bridge Drag", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 2'))
					elseif list == 4 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Caddy", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 3'))
					elseif list == 5 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Circuit", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 4'))
					elseif list == 6 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Circuit 2", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 5'))
					elseif list == 7 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Country Drift", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 6'))
					elseif list == 8 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Drag", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 7'))
					elseif list == 9 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Drift", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 8'))
					elseif list == 10 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Harbour", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 9'))
					elseif list == 11 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Highway", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 10'))
					elseif list == 12 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Highway 2", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 11'))
					elseif list == 13 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Highway 3", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 12'))
					elseif list == 14 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Highway 4", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 13'))
					elseif list == 15 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Hill Drift", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 14'))
					elseif list == 16 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Hotring", 0x00FFFF)			
	        		    sampSendChat(string.format('/rlrace '..args..' 15'))
					elseif list == 17 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Hotring 2", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 16'))
					elseif list == 18 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Kart", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 17'))
					elseif list == 19 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to LSA Drag", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 18'))
					elseif list == 20 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to LSA Drift", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 19'))
					elseif list == 21 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Monster Climb", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 20'))
					elseif list == 22 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to NRG", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 21'))
					elseif list == 23 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to NRG 2", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 22'))
					elseif list == 24 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to NRG 3", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 23'))
					elseif list == 25 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to NRG 4", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 24'))
					elseif list == 26 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to NRG Red County", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 25'))
					elseif list == 27 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Offroad", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 26'))
					elseif list == 28 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Panopticon Drift", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 27'))
					elseif list == 29 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Parking Drift", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 28'))
					elseif list == 30 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Quad", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 29'))
					elseif list == 31 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to River Speed", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 30'))
					elseif list == 32 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Runway Drift", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 31'))
					elseif list == 33 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to SFA Drag", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 32'))
					elseif list == 34 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Street", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 33'))
					elseif list == 35 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Street 2", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 34'))
					elseif list == 36 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Street 3", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 35'))
					elseif list == 37 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Street 4", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 36'))
					elseif list == 38 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Race room "..args.." to Vortex", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlrace '..args..' 37'))
					end
				else
					wait(100)
				end
			end
		end
	end

	function checkerReset04()
		while sampIsDialogActive() do
			wait(0)
	
			local result, button, list, input = sampHasDialogRespond(34)
			if result then
				if button == 1 then
					if list == 0 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Fall room "..args.." to Random", 0x00FFFF)
	        		    sampSendChat(string.format('/rlfall '..args..' -1'))
					elseif list == 1 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Fall room "..args.." to Pilot", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlfall '..args..' 0'))
					elseif list == 2 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Fall room "..args.." to Dancing Arena", 0x00FFFF)					
	        		    sampSendChat(string.format('/rlfall '..args..' 1'))
					elseif list == 3 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Fall room "..args.." to Observation Point", 0x00FFFF)					
	        		    sampSendChat(string.format('/rlfall '..args..' 2'))
					elseif list == 4 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Fall room "..args.." to Triangle Tower", 0x00FFFF)					
	        		    sampSendChat(string.format('/rlfall '..args..' 3'))
					elseif list == 5 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded Fall room "..args.." to Sky Bridge", 0x00FFFF)					
	        		    sampSendChat(string.format('/rlfall '..args..' 4'))
					end
				else
					wait(100)
				end
			end
		end
	end
	
	function checkerReset05()
		while sampIsDialogActive() do
			wait(0)
	
			local result, button, list, input = sampHasDialogRespond(35)
			if result then
				if button == 1 then 
					if list == 0 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded PTP room "..args.." to Random", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlptp '..args..' -1'))
					elseif list == 1 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded PTP room "..args.." to Las Venturas", 0x00FFFF)					
	        		    sampSendChat(string.format('/rlptp '..args..' 0'))
					elseif list == 2 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded PTP room "..args.." to San Fierro", 0x00FFFF)					
	        		    sampSendChat(string.format('/rlptp '..args..' 1'))
					elseif list == 3 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded PTP room "..args.." to Los Santos", 0x00FFFF)					
	        		    sampSendChat(string.format('/rlptp '..args..' 2'))
					elseif list == 4 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded PTP room "..args.." to Desert", 0x00FFFF)					
	        		    sampSendChat(string.format('/rlptp '..args..' 3'))
					end
				else
					wait(100)
				end
			end
		end
	end
	
	function checkerReset06()
		while sampIsDialogActive() do
			wait(0)
	
			local result, button, list, input = sampHasDialogRespond(36)
			if result then
				if button == 1 then
					if list == 0 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded CNR room "..args.." to Random", 0x00FFFF)								
	        		    sampSendChat(string.format('/rlcnr '..args..' -1'))
					elseif list == 1 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded CNR room "..args.." to San Fierro", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlcnr '..args..' 0'))
					elseif list == 2 then
						sampAddChatMessage("{00FF00}[UIFA]: Successfully reloaded CNR room "..args.." to Las Venturas", 0x00FFFF)				
	        		    sampSendChat(string.format('/rlcnr '..args..' 1'))
					end
				else
					wait(100)
				end
			end
		end
	end

end) then
    print("Unable to register command: /mrl")
end

-- End of MRL
