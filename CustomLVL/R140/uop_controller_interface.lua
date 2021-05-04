------------------------------------------------------------------
-- SWBF2 unofficial patch 1.4 
-- by BAD_AL & GT-Anakin
-- based on unofficial patch 1.3 by Zerted
------------------------------------------------------------------

__v13patchSettings_noColors__ = "..\\..\\addon\\AAA-v1.3patch\\settings\\noColors.txt"
ReadDataFile("v1.3patch_strings.lvl")


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
			if ScriptCB_IsFileExist("custom_gc_" .. i .. ".lvl") == 0 then
				print("Unofficial Patch: No custom_gc_" .. i .. ".lvl")
			else
				print("Unofficial Patch: Found custom_gc_" .. i .. ".lvl")
				ReadDataFile("custom_gc_" .. i .. ".lvl")
				ScriptCB_DoFile("custom_gc_" .. i)
			end
		end
		
		local j = 10
		local stop = false
		local scriptName = nil

		repeat
			j = j + 1;
			scriptName = "custom_gc_" .. j
			
			if ScriptCB_IsFileExist(scriptName .. ".lvl") == 0 then
				stop = true
				print("Unofficial Patch: No " .. scriptName .. ".lvl.  Will stop searching for any more cGC scripts.")
			else
				print("Unofficial Patch: Found " .. scriptName .. ".lvl")
				ReadDataFile(scriptName .. ".lvl")
				ScriptCB_DoFile(scriptName)
			end

		until(stop == true)
		
		
	elseif name == "ifs_vkeyboard" then
		uop_ScriptCB_DoFile("popup_prompt")
	end
	
	return uop_ScriptCB_DoFile(overwrite[name] or name, unpack(arg))
end