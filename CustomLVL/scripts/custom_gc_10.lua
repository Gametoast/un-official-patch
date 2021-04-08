------------------------------------------------------------------
-- uop recovered source
------------------------------------------------------------------

print("custom_gc_10: Entered")

local i = 10

while true do
	
	i = i + 1;
	local scriptName = "custom_gc_" .. tostring(i)
	
	if ScriptCB_IsFileExist(scriptName .. ".lvl") == 0 then
		print("custom_gc_10: No " .. scriptName .. ".lvl.  Will stop searching for any more cGC scripts.")
		break;
	else
		print("custom_gc_10: Found " .. scriptName .. ".lvl")
		ReadDataFile(scriptName .. ".lvl")
		ScriptCB_DoFile(scriptName)
	end
end

print("custom_gc_10: Exited")