------------------------------------------------------------------
-- uop recovered source
-- by Anakin
------------------------------------------------------------------

print("user_script_10: Entered")

if not RetailAddUnitClass then
	print("user_script_10: ERROR: No RetailAddUnitClass found.  Don't know the state of the game, so can't fix the v1.3 (r117)'s Lia bug without breaking something.")
else
	print("user_script_10: Replacing v1.3 (r117)'s AddUnitClass as it should've had a return value.  This fixes the Leia bug.")
	AddUnitClass = function(...)
		local team = arg[1]
		local type1 = arg[2]
		local type2 = arg[3]
		local type3 = arg[4]
	
		--try to learn new classes, so the FakeConsole works on all untis in the map
		if type1 ~= nil and type1 ~= "" then
			uf_updateClassIndex( type1 )
		end
		
		--handles adding the hero from setup_teams?
		if team ~= nil and type1 == nil and type2 == nil and type3 == nil then
			print("utility_functions2: AddUnitClass(): Think found a hero added through SetupTeams.  Please tell [RDH]Zerted which map this is.  Thanks.")
			uf_updateClassIndex( team[1] )
		end
		
		--foward the call to the original function
		return RetailAddUnitClass( unpack(arg) )
	end
end

local i = 10
local stop = false
local scriptName = nil

repeat
	i = i + 1;
	scriptName = "user_script_" .. i
	
	if ScriptCB_IsFileExist(scriptName .. ".lvl") == 0 then
		stop = true
		print("user_script_10: No " .. scriptName .. ".lvl.  Will stop searching for any more user scripts.")
	else
		print("user_script_10: Found " .. scriptName .. ".lvl")
		ReadDataFile(scriptName .. ".lvl")
		ScriptCB_DoFile(scriptName)
	end

until(stop == true)

print("user_script_10: Exited")