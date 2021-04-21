Unofficial v1.3 Patch r129 - Readme
by [RDH]Zerted and Zerted - January 13th, 2010

Overview:
* Simple installation (can install to dedicated server too)
* Works online in multiplayer
* Supports WinXP, Vista, Win7
* Supports the unofficial v1.2 patch
* Supports unlimited new eras (only 5 can be displayed per map)
* Supports unlimited new game modes (only 14 can be displayed per map)
* Supports unlimited custom user scripts (example: use a script to enforce dedicated server rules like 'no vehicles' and 'no CPs')
* Supports unlimited custom Galactic Conquest (cGC) campaigns and cGC scripts
* Supports over 158 FakeConsole commands and displays their descriptions
* Includes player tracking, player teleporting, and causing the AI to follow certain players
* Replaces the outdated mods: FC Mod, Era Shell, FreeCam, FakeConsole
* Allows disabling the award effects (just the graphical and sound parts, you still get their bonuses)
* Supports map preview videos
* Compatable with mod maps
* Extends and expands the cheat menu to MP
* Supports no-namer booting (non-server admins can boot them too)
* Allows you to become a no-namer without changing your profile
* Supports custom FakeConsole command by map modders
* Displays warning if over the game's 500 mission limit
* Allows Free Camera
* Allows directly setting the displayed side selection names (for modders)
* Supports custom map colors (can be removed from the menu)

FakeConsole:
* A correctly executed command turns light blue
* An errored command turns pink

Added Shortcut Keys:
* Close the FakeConsole list: 'Esc'
* Cancel (no) the prompt pop-up: 'Esc'
* Accept (yes) the prompt pop-up: 'Enter'
* Close team stats screen: 'l' (lowercase L)
* Select the team selection's auto-assign button: 'a'
* Select the team selection's auto-assign button: 'A'
* Select the team selection's team 1 button: '1'
* Select the team selection's team 2 button: '2'
* Select the team selection's auto-assign button: '3'
* Select the team selection's spectator button: '4'

Keys To Control FreeCam:
[Home] - Move camera up
[End] - Move camera down
[M] - Pause/Unpause the game
[Backspace] - Pause/Unpause the game
[+] - Speed up 
[-] - Slow down

Keys To Control the FakeConsole list:
[Up] - Move the selection up one element
[Down] - Move the selection down one element
[Page Up] - Move the selection up 19 elements (one page)
[Page Down] - Move the selection down 19 elements (one page)
[Escape] - Close the FakeConsole list

Crashing Issues:
* Misuse of the FakeConsole commands may result in crashes
* Filling the cheatbox with spaces makes the game crash.  I don't have a clue why...
* Galactic Conquest's Versus is completely untested (had been disabled by LA but I renabled it)
* Displays a warning if you have over 500 missions (The original game can only handle 500 modded missions.  It crashes with FATAL when attempting to play a mission after about the first 500)

Other Issues:
* The non-spawning Leia bug has been fixed.
* A few people will not be able to see any of the new strings.  Upgrade to the correct official v1.1 patch and/or read installer-extra-info.txt
* FakeConsole commands built into the exe always turn pink when clicked no matter if they worked or not.  The section description commands turn pink too.
* It takes a second at the start of each map to disable award effects (if set to disabled).  An AI bot has an extremely low chance of gaining an award in this period.
* There is a bug in displaying the preview video when switching between the MP and SP map selection screens.  The preview video may not play until a map with a different video is selected.
* If a map directly sets the side selection names, the team buttons will no longer flash when selected.

Important Notes For Modders:
* The FakeConsole command 'Code Console' lets you type and run Lua code directly ingame
* Space Assualt's name changed to 'modename.name.spa-assault' from 'modename.name.assault'
* Hero Assualt's name changed to 'modename.name.hero-assault' from 'modename.name.elimination'
* Voice over errors mostly gone from the modtool log
* Custom game mode and era names, icons, and descriptions are supported.  Meaning, you can have your map set the text on its game mode checkbox no matter the mode.
* The ingame variable '__thisMapsCode__' should contain the current map's 3-char code (will always be lowercase).  The variable is nil if the code couldn't be detected or has yet to be detected.
* The ingame variable '__thisMapsMode__' should contain the current map's loaded layer/game mode (will always be lowercase).  The variable is nil if the mode couldn't be detected or has yet to be detected.
* The uf_processPlayers() function allows you to get the names of the ingame players (see 'Using Ingame Player Data.txt')
* See the howtos docs for more info on how to use the v1.3's new modding related features
* User scripts allows one to inject code into any map
* cGC scripts allows one to inject code into the shell
