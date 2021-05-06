------------------------------------------------------------------
-- SWBF2 unofficial patch 1.4 
-- by BAD_AL & GT-Anakin
-- based on unofficial patch 1.3 by Zerted
------------------------------------------------------------------

print("Unofficial Patch: Entered addme")

print("    install mission checker..")
if(__LISTENING_TO_ADDDOWNLOADABLECONTENT__ == true ) then 
	print( "Mission Checker: Someone else is already listening...")
	print("Mission Checker: Exited addme")
	return 
end 


__sp_n_limit__ = nil 
__mp_n_limit__ = nil 
__max_missions__ = 500 


if( AddDownloadableContent ) then 
	
	OldAdd = AddDownloadableContent
	__ADDDOWNLOADABLECONTENT_COUNT__ = 0 
	
	-- ------------------------------------------------------------------------------------
	-- Overwrite 'AddDownloadableContent()' to listen for adds 
	-- 
	AddDownloadableContent = function(mapLuaFile, missionName, defaultMemoryModelPlus)
		__ADDDOWNLOADABLECONTENT_COUNT__ = __ADDDOWNLOADABLECONTENT_COUNT__ + 1
		
		if(__ADDDOWNLOADABLECONTENT_COUNT__ >= __max_missions__ ) then 
		
			if( mapLuaFile == nil or missionName == nil  or defaultMemoryModelPlus == nil ) then 
				print("Mission Checker: AddDownloadableContent(): WARNING: Over the limit and one or more parameters is nil")
			else 
				print("Mission Checker: AddDownloadableContent(): WARNING: Over the limit: Count: " ..
					__ADDDOWNLOADABLECONTENT_COUNT__, mapLuaFile, missionName, defaultMemoryModelPlus )
			end 
			if( __sp_n_limit__ == nil ) then 
				__sp_n_limit__ = table.getn(sp_missionselect_listbox_contents)   - 1
				__mp_n_limit__ = table.getn(mp_missionselect_listbox_contents)   - 1
				print("Mission Checker: AddDownloadableContent(): SP cut-off is: ",
						__sp_n_limit__ or  "[Oops]" )
				print("Mission Checker: AddDownloadableContent(): MP cut-off is: ",
						__mp_n_limit__ or  "[Oops]" )				
			end
			return 				
		
		end 
		OldAdd(mapLuaFile, missionName, defaultMemoryModelPlus)
	end
	--
	-- ------------------------------------------------------------------------------------
	
	print("Mission Checker: addme: Now listening in on AddDownloadableContent() calls")
else 
	print( "Mission Checker: WARNING: Unable to listen in on AddDownloadableContent() calls.  Mission length will be unchecked!")
end 


print("    install debug mode..")

function uopDebugStartMission()
	tprint(rema_database)
	
	if __uopDebugDatabase__ then
		rema_database = __uopDebugDatabase__
	end
	ScriptCB_SetMissionNames({{Map = __uopDebugMission__, dnldable = nil, Side = 1, SideChar = nil, Team1 = "team1", Team2 = "team2"}}, false)
	ScriptCB_SetTeamNames(0,0)
	ScriptCB_EnterMission()
end

if(gPlatformStr == "PC") then
	if ScriptCB_IsFileExist("..\\..\\addon\\unofficial_patch\\debug.lua") == 1 then
		require("addon\\unofficial_patch\\debug")
	end
end

local uop_debug_backup_push = ScriptCB_PushScreen
ScriptCB_PushScreen = function(name, ...)
	if name == "ifs_legal" then
	
		if __uopDebugMission__ then	
			print("")
			print("----------------------------------------------------------------------------------------------------")
			print("-- DEBUG MODE -- DEBUG MODE -- DEBUG MODE -- DEBUG MODE -- DEBUG MODE -- DEBUG MODE -- DEBUG MODE --")
			print("")
			print("-- mission:", __uopDebugMission__)
			print("-- profil:", __uopDebugProfile__ or "[NIL]")
			print("----------------------------------------------------------------------------------------------------")
			print("")

			if __uopDebugProfile__ then
			
				ScriptCB_SetConnectType("wan")
				ScriptCB_CancelLogin()

				ifs_saveop.doOp = "LoadProfile"
				ifs_saveop.OnSuccess = function()
					print("UOP Debug Script: profile loaded")
					uopDebugStartMission()
				end
				ifs_saveop.OnCancel = function() 
					print("ERROR loading profil..")
					uopDebugStartMission()
				end
				ifs_saveop.profile1 = ScriptCB_tounicode(__uopDebugProfile__)
				ifs_saveop.profile2 = nil
				
				gPrevMixConfig = ScriptCB_GetMixConfig()
				gPrevEffects   = ScriptCB_EffectsEnabled()

				ifs_movietrans_PushScreen(ifs_saveop)
			else
				uopDebugStartMission()
			end
			
			return
		end
	end
	
	return uop_debug_backup_push(name, unpack(arg))

end


__LISTENING_TO_ADDDOWNLOADABLECONTENT__ = true 
print("Unofficial Patch: Exited addme")
