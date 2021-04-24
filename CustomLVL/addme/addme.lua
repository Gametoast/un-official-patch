-- addme.lua un-official patch 1.3 
-- decompile by BAD_AL (verified)
-- Original By Zerted


print("Mission Checker: Entered addme")
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



__LISTENING_TO_ADDDOWNLOADABLECONTENT__ = true 
print("Mission Checker: Exited addme")
