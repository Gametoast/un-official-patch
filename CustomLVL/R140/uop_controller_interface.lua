------------------------------------------------------------------
-- SWBF2 unofficial patch 1.4 
-- by BAD_AL & GT-Anakin
-- based on unofficial patch 1.3 by Zerted
------------------------------------------------------------------

__v13patchSettings_noColors__ = "..\\..\\addon\\unofficial_patch\\settings\\noColors.txt"
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
	ifs_login = "uop_ifs_login",
	ifs_missionselect = "uop_ifs_missionselect",
	missionlist = "uop_missionlist",
	ifs_sp = "uop_ifs_sp",
	ifs_sp_campaign = "uop_ifs_sp_campaign",
	ifs_instant_options_tags = "uop_ifs_instant_options_tags",
	ifs_freeform_init_common = "uop_ifs_freeform_init_common",
	ifs_freeform_main = "uop_ifs_freeform_main",
	ifs_freeform_battle_mode = "uop_ifs_freeform_battle_mode",
	ifs_freeform_battle_card = "uop_ifs_freeform_battle_card",
	ifs_mp_leaderboard = "uop_ifs_mp_leaderboard",
	ifs_missionselect_pcMulti = "uop_ifs_missionselect_pcMulti",
--	ifs_era_handler = true,	-- << special, won't be overwritten, call in correct order
}


ReadUnofficialFile("unofficial_patch_strings.lvl")


local uop_ScriptCB_DoFile = ScriptCB_DoFile
ScriptCB_DoFile = function(name, ...)
	
	if name == "globals" then
		print(
			"Unofficial Patch: gPlatformStr, gOnlineServiceStr, gLangStr, gLangEnum: ",
			gPlatformStr or "[Nil]" , gOnlineServiceStr or "[Nil]", gLangStr or "[Nil]",
			gLangEnum or "[Nil]"
		)
	elseif name == "ifs_movietrans" then
		uop_ScriptCB_DoFile("ifs_era_handler")
		
		local maxScripts = 10 
		local i = nil 
		for i = 0, maxScripts, 1 do 
			if ScriptCB_IsFileExist("..\\..\\addon\\unofficial_patch\\uop_scripts\\custom_gc_" .. i .. ".lvl") == 0 then
				print("Unofficial Patch: No custom_gc_" .. i .. ".lvl")
			else
				print("Unofficial Patch: Found custom_gc_" .. i .. ".lvl")
				ReadUnofficialFile("uop_scripts\\custom_gc_" .. i .. ".lvl")
				ScriptCB_DoFile("custom_gc_" .. i)
			end
		end
		
		local j = 10
		local stop = false
		local scriptName = nil

		repeat
			j = j + 1;
			scriptName = "custom_gc_" .. j
			
			if ScriptCB_IsFileExist("..\\..\\addon\\unofficial_patch\\uop_scripts\\" .. scriptName .. ".lvl") == 0 then
				stop = true
				print("Unofficial Patch: No " .. scriptName .. ".lvl.  Will stop searching for any more cGC scripts.")
			else
				print("Unofficial Patch: Found " .. scriptName .. ".lvl")
				ReadUnofficialFile("uop_scripts\\" .. scriptName .. ".lvl")
				ScriptCB_DoFile(scriptName)
			end

		until(stop == true)
		
		
	elseif name == "ifs_vkeyboard" then
		uop_ScriptCB_DoFile("popup_prompt")
	end
	
	return uop_ScriptCB_DoFile(overwrite[name] or name, unpack(arg))
end