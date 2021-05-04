------------------------------------------------------------------
-- SWBF2 unofficial patch 1.4 
-- by BAD_AL & GT-Anakin
-- based on unofficial patch 1.3 by Zerted
------------------------------------------------------------------

print("game_interface: Entered")

function ReadUnofficialFile(file)
	ReadDataFile("..\\..\\addon\\unofficial_patch\\" .. file)
end

ReadUnofficialFile("uop_common.lvl")
ReadUnofficialFile("uop_ingame.lvl")

__gPcPlatform__ = nil

if ScriptCB_IsFileExist("..\\..\\Galaxy.dll") == 0 then
	__gPcPlatform__ = "CD_DVD"
else
	__gPcPlatform__ = "STEAM_GOG"
end

print("game_interface: apply unofficial patch")
ScriptCB_DoFile("uop_controller_ingame")
ScriptCB_DoFile("stock_game_interface")

print("game_interface: Exited")
