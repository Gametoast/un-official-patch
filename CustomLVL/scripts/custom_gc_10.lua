------------------------------------------------------------------
-- uop recovered source
-- by Anakain
------------------------------------------------------------------

print("custom_gc_10: Entered")

local i = 10
local stop = false
local scriptName = nil

repeat
	i = i + 1;
	scriptName = "custom_gc_" .. i
	
	if ScriptCB_IsFileExist(scriptName .. ".lvl") == 0 then
		stop = true
		print("custom_gc_10: No " .. scriptName .. ".lvl.  Will stop searching for any more cGC scripts.")
	else
		print("custom_gc_10: Found " .. scriptName .. ".lvl")
		ReadDataFile(scriptName .. ".lvl")
		ScriptCB_DoFile(scriptName)
	end

until(stop == true)

print("custom_gc_10: Exited")