------------------------------------------------------------------
-- SWBF2 unofficial patch 1.4 
-- by BAD_AL & GT-Anakin
-- based on unofficial patch 1.3 by Zerted
------------------------------------------------------------------


function getn(v)
    local v_type = type(v);
    if v_type == "table" then
        return table.getn(v);
    elseif v_type == "string" then
        return string.len(v);
    else
        return;
    end
end

function string.starts(str, Start)
    return string.sub(str, 1, getn(Start)) == Start;
end

function tprint(t, indent)
    if not indent then indent = 1, print(tostring(t) .. " {") end
    if t then
        for key,value in pairs(t) do
            if not string.starts(tostring(key), "__") then
                local formatting = string.rep("    ", indent) .. tostring(key) .. ": ";
                if value and type(value) == "table" then
					print(formatting .. tostring(value) .. " {")
                    tprint(value, indent+1);
				else
					print(formatting .. tostring(value))
                end
            end
        end
		print(string.rep("    ", indent - 1) .. "}")
    end
end


--CONMult
--CTFScore
--HUNScore
--ASSScore
--ifs_io_changeFunc
--ifs_io_GetElementLayoutFor


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
		
	elseif name == "ifelem_button" then
		
		if AddIFScreen then
	
			-- backup old function
			local uop_AddIFScreen = AddIFScreen
				
			-- wrap AddIFScreen
			AddIFScreen = function(ifsTable, name,...)

				-- fix profile select screen
				if name == "ifs_instant_options" then
					
					print("marker")
					local CONMult = {low = 1, high = 1000, increment = 25} -- inc 10
					local CTFScore = {low = 1, high = 100, increment = 5}
					local HUNScore = {low = 1, high = 1000, increment = 25} -- inc 5
					local ASSScore = {low = 1, high = 1000, increment = 25}  -- inc 5

					local backup_1 = ifs_io_GetElementLayoutFor
					ifs_io_GetElementLayoutFor = function(tagName, screen, ...)
						local ret = backup_1(tagName, screen, unpack(arg))
						
						if tagName == "con_mult" then
							ret.minValue = CONMult.low
							ret.maxValue = CONMult.high
						elseif tagName == "hun_score" then
							ret.minValue = HUNScore.low
							ret.maxValue = HUNScore.high
						elseif tagName == "ctf_score" then
							ret.minValue = CTFScore.low
							ret.maxValue = CTFScore.high
						elseif tagName == "ass_score" then
							ret.minValue = ASSScore.low
							ret.maxValue = ASSScore.high
						end
						
						return ret
					end
					
					local backup_2 = ifs_io_changeFunc
					ifs_io_changeFunc = function(form, element, ...)
						
						local oldValue = element.selValue
						local ret = {backup_2(form, element, unpack(arg))}
						
						if element.tag == "con_mult" then
							element.selValue = RoundTo(oldValue, CONMult.increment)
							ifs_instant_options.GamePrefs.iCONMult = Clamp(math.floor(element.selValue), CONMult.low, CONMult.high)
							element.selValue = ifs_instant_options.GamePrefs.iCONMult
						elseif element.tag == "hun_score" then
							element.selValue = RoundTo(oldValue, HUNScore.increment)
							this.GamePrefs.iHUNTScoreLimit = Clamp(math.floor(element.selValue), HUNScore.low, HUNScore.high)
							element.selValue = this.GamePrefs.iHUNTScoreLimit
						elseif element.tag == "ctf_score" then
							element.selValue = RoundTo(oldValue, CTFScore.increment)
							this.GamePrefs.iCTFScore = Clamp(math.floor(element.selValue), CTFScore.low, CTFScore.high)
							element.selValue = this.GamePrefs.iCTFScore
						elseif element.tag == "ass_score" then
							element.selValue = RoundTo(oldValue, ASSScore.increment)
							this.GamePrefs.iASSScoreLimit = Clamp(math.floor(element.selValue), ASSScore.low, ASSScore.high)
							element.selValue = this.GamePrefs.iASSScoreLimit
						end
						
						return unpack(ret)
					end
					
					for key,value in pairs(ifs_io_listtags) do
						ifs_instant_options.screens[key] = nil
						ifs_instant_options.screens[key] = NewIFContainer {}
						Form_CreateVertical(ifs_instant_options.screens[key], ifs_io_GetLayoutFor(ifs_io_listtags[key], ifs_instant_options))
						IFObj_fnSetVis(ifs_instant_options.screens[key], nil)
					end
					
					print("ifs_instant_options")
					tprint(ifs_instant_options)
					
				end

				-- let the original function happen
				return uop_AddIFScreen(ifsTable, name, unpack(arg))
			end
		else
			print("Unofficial Patch: Error")
			print("                : AddIFScreen() not found!")
		end
	
	end
	
	return uop_ScriptCB_DoFile(overwrite[name] or name, unpack(arg))
end



