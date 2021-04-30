# unofficial-patch

The Star Wars Battlefront II un-official patch was initially developed by the GameToast user Zerted.
It provides features deemed essential to today's SWBFII modders and players. 

The source code was posted to Zerted's personal server long ago and has since been lost.

If you happened to have downloaded Zerted's source code, we would very much appreciate if you submitted it to this repo.

This GitHub repo is a space where users can download the patch and a space for modders to maintain the patch.

We do have some of the source code and can get more of it by reverse-engineering the compiled Lua scripts. At some point we may have all of the source and will be able to build/munge completely from source. 


## build from source

* open the _\_build\\_ folder
* depending on your target system run _build\_r129.bat_ or _build\_r130.bat_
* munged lvl files can be found in _\_LVL\_PC\\R130\\_ or _\_LVL\_PC\\R129\\_ folder
* it's only recommended to manual install the mod if you know where the files go to


## Current Status

File                |  r129 | r130
--------------------|-------|------
addme.script        |  \+    |  \+
common.lvl          |  \+    |  \+
shell.lvl           |  \+    |  \+
ingame.lvl          |  \+    |  \+
custom_gc_10.lvl    |  \+    |  \+
user_script_10.lvl  |  \+    |  \+
v1.3patch_strings   |  \*    |  \*
pre-movie.mvs       |  \-    |  \-

\+ \: done and verified

\# \: done, to be verified

\* \: WIP

\- \: TBD


## Future Features 
- [ ] one version that works for both steam and dvd version
- [ ] extract functionality from base game files and move them all to addon folder
- [ ] add a debug mod that allows to quickstart a mission
- [ ] support console with as many functions as possible
