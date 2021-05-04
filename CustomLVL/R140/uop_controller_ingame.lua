------------------------------------------------------------------
-- SWBF2 unofficial patch 1.4 
-- by BAD_AL & GT-Anakin
-- based on unofficial patch 1.3 by Zerted
------------------------------------------------------------------

__v13patchSettings_noAwards__ = "..\\..\\addon\\AAA-v1.3patch\\settings\\noAwards.txt"
local overwrite = {
	error_popup = "uop_error_popup",
	ifs_awardstats = "uop_ifs_awardstats",
	ifs_careerstats = "uop_ifs_careerstats",
	ifs_mp_lobby = "uop_ifs_mp_lobby",
	ifs_opt_general = "uop_ifs_opt_general",
	ifs_opt_mp = "uop_ifs_opt_mp",
	ifs_pausemenu = "uop_ifs_pausemenu",
	ifs_personalstats = "uop_ifs_personalstats",
	ifs_teamstats = "uop_ifs_teamstats",
--	popup_prompt = true,	-- << special, won't be overwritten, call in correct order
	ifs_sideselect = "uop_ifs_sideselect",
--	utility_functions2 = true,	-- << special, won't be overwritten, call in correct order
--	fakeconsole_functions = true,	-- << special, won't be overwritten, call in correct order
	ifs_fakeconsole = "uop_ifs_fakeconsole",
}


ScriptCB_DoFile("utility_functions2")

print("Unofficial Patch: Reading in custom strings")
ReadUnofficialFile("v1.3patch_strings.lvl")

ReadUnofficialFile("hud\\hud.lvl")

local maxScripts = 10
local i = nil

for i = 0, maxScripts, 1 do
	
	if ScriptCB_IsFileExist("..\\..\\addon\\unofficial_patch\\user_scripts\\user_script_" .. i .. ".lvl") == 0 then
		print("Unofficial Patch: No user_script_" .. i .. ".lvl")
	else
		print("Unofficial Patch: Found user_script_" .. i .. ".lvl")
		
		ReadUnofficialFile("user_scripts\\user_script_" .. i .. ".lvl")
		ScriptCB_DoFile("user_script_" .. i)
	end
	
end

local j = 10
local stop = false
local scriptName = nil

repeat
	j = j + 1;
	scriptName = "user_script_" .. j
	
	if ScriptCB_IsFileExist(scriptName .. ".lvl") == 0 then
		stop = true
		print("Unofficial Patch: No " .. scriptName .. ".lvl.  Will stop searching for any more user scripts.")
	else
		print("Unofficial Patch: Found " .. scriptName .. ".lvl")
		ReadDataFile(scriptName .. ".lvl")
		ScriptCB_DoFile(scriptName)
	end

until(stop == true)


local uop_ScriptCB_DoFile = ScriptCB_DoFile
ScriptCB_DoFile = function(name, ...)
	
	if name == "ifs_pausemenu" then
		uop_ScriptCB_DoFile("popup_prompt")
		uop_ScriptCB_DoFile("fakeconsole_functions")
	end
	return uop_ScriptCB_DoFile(overwrite[name] or name, unpack(arg))
end
