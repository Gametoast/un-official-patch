------------------------------------------------------------------
-- SWBF2 unofficial patch 1.4 
-- by BAD_AL & GT-Anakin
-- based on unofficial patch 1.3 by Zerted
------------------------------------------------------------------

print("shell_interface: Entered")

function ReadUnofficialFile(file)
	ReadDataFile("..\\..\\addon\\unofficial_patch\\data\\_LVL_PC\\" .. file)
end

-- is this the right place?
ReadUnofficialFile("uop_common.lvl")
ReadUnofficialFile("uop_shell.lvl")

__gPcPlatform__ = nil

if ScriptCB_IsFileExist("..\\..\\Galaxy.dll") == 0 then
	__gPcPlatform__ = "CD_DVD"
else
	__gPcPlatform__ = "STEAM_GOG"
end

print("shell_interface: apply unofficial patch")
ScriptCB_DoFile("uop_controller_interface")
ScriptCB_DoFile("stock_shell_interface")

print("shell_interface: Exited")
