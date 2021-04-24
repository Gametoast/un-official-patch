# un-official-patch

The Star Wars Battlefront II un-official patch was initially developed by the GameToast user Zerted.
It provides features deemed essential to today's SWBFII modders and players. 

The source code was posted to Zerted's personal server long ago and has since been lost.

If you happened to have downloaded Zerted's source code, we would very much appreciate if you submitted it to this repo.

This GitHub repo is a space where users can download the patch and a space for modders to maintain the patch.

We do have some of the source code and can get more of it by reverse-engineering the compiled Lua scripts. At some point we may have all of the source and will be able to build/munge completely from source.


# build notes

2021/04/24 new munge bats
* there are stand alone munge bats that can munge both versions r129 and r130
* run the bat in _build folder
* output will be in _lvl_PC\BUILD_NUMBER

2021/04/19 modified munge.bat
* now when the lvl is packed you can ignore stuff that is already munged in a global file.
* there needs to be a globalfiles.req (in general it's just common.req)
* be aware that if you munge common.lvl nothing is gonna be in there
* to avoid, remove globalfiles.req
* or just take \data_UOP\_build\CustomLVL\MUNGED\PC\globalfiles\globalfiles.lvl and rename it.
