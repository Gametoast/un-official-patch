------------------------------------------------------------------
-- SWBF2 unofficial patch 1.4 
-- by BAD_AL & GT-Anakin
-- based on unofficial patch 1.3 by Zerted
------------------------------------------------------------------

print("game_interface: Entered")

__gPcPlatform__ = nil
__gUnofficialPatch__ = nil
__gRemastered__ = nil

if ScriptCB_IsFileExist("..\\..\\Galaxy.dll") == 0 then
	__gPcPlatform__ = "CD_DVD"
else
	__gPcPlatform__ = "STEAM_GOG"
end

if ScriptCB_IsFileExist("..\\..\\addon\\unofficial_patch\\addme.script") == 1 then
	__gUnofficialPatch__ = true
end

if ScriptCB_IsFileExist("..\\..\\addon\\Remaster\\addme.lvl") == 1 then
	__gRemastered__ = true
end

if not __gUnofficialPatch__ then
	print("game_interface: ERROR - unofficial patch not found - ERROR")
	print("              : reverting to default..")
	ReadDataFile("HUD\\hud.lvl")
else

	function ReadUnofficialFile(file)
		ReadDataFile("..\\..\\addon\\unofficial_patch\\data\\_LVL_PC\\" .. file)
	end

	ReadUnofficialFile("uop_common.lvl")
	ReadUnofficialFile("uop_ingame.lvl")
	
	if __gRemastered__ then
		print("game_interface: apply remaster")
		ReadDataFile("..\\..\\addon\\Remaster\\addme.lvl")
		ScriptCB_DoFile("addme_ingame")
	end

	print("game_interface: apply unofficial patch")
	ScriptCB_DoFile("uop_controller_ingame")
end

ScriptCB_DoFile("stock_game_interface")

print("game_interface: Exited")
