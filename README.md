# unofficial patch r140 working branch

```diff
! This is a unstable developer branch.
! Do not use it unless you are part of the developer team
```


*********************************************************************

## ToDo list

- [x] debug integration
- [x] uop_controller_ingame
- [ ] uop_controller_shell
- [ ] Does the texture overwrite work? calling order: what common/ingame/shell is called first? 
- [ ] Do we need the modifications from steam? r130 changes by spiret or steam?
- [ ] Does the modified movie work? Do movie mcfg files overwrite existing once?
- [ ] Is the msh.option differences important?
- [ ] Remaster integration
- [ ] Installer that modifies exisiting lvl files while install process


*********************************************************************

## Files to take care of

### Modified by Spiret/Steam
- [ ] ifs_instant_options.lua
- [ ] ifs_mpgs_friends.lua
- [ ] ifs_mpgs_pclogin.lua

### Modified by Zerted
- [x] ifs_instant_options_tags.lua
- [x] ifs_mp_leaderboard.lua
- [x] ifs_mp_lobby.lua
- [x] ifs_mp_sessionlist.lua
- [x] ifs_opt_mp.lua
- [x] ifs_pausemenu.lua
- [x] error_popup.lua
- [x] ifs_awardstats.lua
- [x] ifs_careerstats.lua
- [x] ifs_opt_general.lua
- [x] ifs_personalstats.lua
- [x] ifs_teamstats.lua
- [x] game_interface.lua
- [x] ifs_fakeconsole.lua
- [x] ifs_sideselect.lua
- [x] ifs_freeform_battle_card.lua
- [x] ifs_freeform_battle_mode.lua
- [x] ifs_freeform_init_common.lua
- [x] ifs_freeform_main.lua
- [x] ifs_login.lua
- [x] ifs_missionselect.lua
- [x] ifs_missionselect_pcmulti.lua
- [x] ifs_sp.lua
- [x] ifs_sp_campaign.lua
- [x] missionlist.lua
- [x] shell_interface.lua

- [ ] com_sfx_landmine.fx

- [x] 1playerhud.hud
- [x] hudtransforms.hud

- [x] shell_movies.mcfg

- [ ] iface_bgmeta_space.tga
- [ ] com_sfx_laser_orange.tga
- [ ] mode_icon_XL.tga
- [ ] mode_icon_eli.tga

### New by Zerted
- [x] addme.lua
- [x] popup_prompt.lua
- [x] fakeconsole_functions.lua
- [x] utility_functions2.lua
- [x] ifs_era_handler.lua

- [x] sfo_kmsx.fx

- [ ] com_item_weaponrecharge.msh.option

- [ ] custom_gc_10.lvl
- [ ] user_script_10.lvl
- [ ] v1.3patch_strings.lvl

- [ ] com_sfx_scorchmark.tga
- [x] bfx_cw_icon.tga
- [x] bfx_gcw_icon.tga
- [x] earth_icon.tga
- [x] exgcw_icon.tga
- [x] front_icon.tga
- [x] gray_rect.tga
- [x] halo_icon.tga
- [x] i_icon.tga
- [x] imp_icon.tga
- [x] j_icon.tga
- [x] kotor_icon.tga
- [x] lego_icon.tga
- [x] newrep_icon.tga
- [x] newsithwars_icon.tga
- [x] oldsith_icon.tga
- [x] rebirth_icon.tga
- [x] rep_icon.tga
- [x] rvb_icon.tga
- [x] toys_icon.tga
- [x] u_icon.tga
- [x] v_icon.tga
- [x] wacky_icon.tga
- [x] yuz_icon.tga
- [x] z_icon.tga
- [ ] mode_icon_avh.tga
- [ ] mode_icon_bf1.tga
- [ ] mode_icon_c.tga
- [ ] mode_icon_c1.tga
- [ ] mode_icon_c2.tga
- [ ] mode_icon_c3.tga
- [ ] mode_icon_c4.tga
- [ ] mode_icon_control.tga
- [ ] mode_icon_dm.tga
- [ ] mode_icon_hctf.tga
- [ ] mode_icon_holo.tga
- [ ] mode_icon_ins.tga
- [ ] mode_icon_jhu.tga
- [ ] mode_icon_koh.tga
- [ ] mode_icon_lms.tga
- [ ] mode_icon_obj.tga
- [ ] mode_icon_ord66.tga
- [ ] mode_icon_race.tga
- [ ] mode_icon_rpg.tga
- [ ] mode_icon_siege.tga
- [ ] mode_icon_space.tga
- [ ] mode_icon_survival.tga
- [ ] mode_icon_tdf.tga
- [ ] mode_icon_tdm.tga
- [ ] mode_icon_uber.tga
- [ ] mode_icon_vehicle.tga
- [ ] mode_icon_vh.tga
- [ ] mode_icon_wav.tga
- [ ] mode_icon_wea.tga
- [ ] mode_icon_xtra.tga
