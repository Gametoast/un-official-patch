------------------------------------------------------------------
-- SWBF2 unofficial patch 1.4 
-- by BAD_AL & GT-Anakin
-- based on unofficial patch 1.3 by Zerted
------------------------------------------------------------------

ReadUnofficialFile(file)
	ReadDataFile("..\\..\\addon\\unofficial_patch\\" .. file)
end

ReadUnofficialFile("uop_common.lvl")
ReadUnofficialFile("uop_shell.lvl")