------------------------------------------------------------------
-- Steam/gog recovered source
-- by Anakain
------------------------------------------------------------------


ifs_mpgs_login_vbutton_layout = {
	yHeight = 40,
	ySpacing = 0,
	width = 350,
	font = "gamefont_medium",
	LeftJustify = 1,
	buttonlist = {},
	nocreatebackground = 1,
	noflashycenter = 1,
	bNoDefaultSizing = 1,
}

function ifs_mpgs_login_fnCheckDone()
	return ScriptCB_IsLoginDone()
end

function ifs_mpgs_login_fnOnSuccess()
	local this = ifs_mpgs_login
	Popup_Busy:fnActivate(nil)
	
	ScriptCB_SearchStatsRank()
	ScriptCB_SetIFScreen("ifs_mp_sessionlist")
end

function ifs_mpgs_login_fnOnFail()
	local this = ifs_mpgs_login
	Popup_Busy:fnActivate(nil)
	
	print("Error in logging on!\n")
	
	this.iPromptType = 0
	ifs_mpgs_login_fnSetPieceVis(this, nil, 1, nil)
	
	IFObj_fnSetVis(this.LoginAsTextA, 1)
	IFObj_fnSetVis(this.LoginAsTextB, 1)
	local err = ScriptCB_LastSignInError()
	
	IFText_fnSetString(this.LoginAsTextA, "ifs.mp.galaxy.error")
	IFText_fnSetString(this.LoginAsTextB, err)
end

function ifs_mpgs_login_fnOnCancel()

end

function ifs_mpgs_fnUpdateButtonText(this)

end

function ifs_mpgs_login_fnStartLogin(this, bCreateMode)
	ifelm_shellscreen_fnPlaySound(this.acceptSound)
	
	ScriptCB_StartLogin(this.NickStr, this.EmailStr, this.PasswordStr, bCreateMode)
	ifs_mpgs_login_fnSetPieceVis(this, nil, nil, nil)
	
	Popup_Busy.bCallerSetsString = 1
	IFText_fnSetString(Popup_Busy.BusyTimeStr, "")
	Popup_Busy.fnCheckDone = ifs_mpgs_login_fnCheckDone
	Popup_Busy.fnOnSuccess = ifs_mpgs_login_fnOnSuccess
	Popup_Busy.fnOnFail = ifs_mpgs_login_fnOnFail
	Popup_Busy.fnOnCancel = ifs_mpgs_login_fnOnCancel
	Popup_Busy.bNoCancel = 1
	Popup_Busy.fTimeout = 30
	IFText_fnSetString(Popup_Busy.title, "common.mp.loggingin_gsid")
	
	Popup_Busy:fnActivate(1)
	
	this.bStartedLogin = 1
end

function ifs_mpgs_login_fnMustSpecifyOk()
	local this = ifs_mpgs_login
	
	ifs_mpgs_login_fnSetPieceVis(this, nil, 1, nil)
end

function ifs_mpgs_login_fnSetPieceVis(this,bImmediate,bShowListbox)
	local isLoggedIn = ScriptCB_IsLoggedIn()
	
	IFObj_fnSetVis(this.LoginAsTextA, bShowListbox and isLoggedIn)
	IFObj_fnSetVis(this.LoginAsTextB, bShowListbox and isLoggedIn)
	
	this.bShowEntries = bShowListbox
end

function ifs_mpgs_login_StartSaveProfile()
	ifs_saveop.doOp = "SaveProfile"
	ifs_saveop.OnSuccess = ifs_mpgs_login_SaveProfileSuccess
	ifs_saveop.OnCancel = ifs_mpgs_login_SaveProfileCancel
	ifs_saveop.saveName = ScriptCB_GetCurrentProfileName()
	ifs_saveop.saveProfileNum = 1
	ifs_movietrans_PushScreen(ifs_saveop)
end

function ifs_mpgs_login_SaveProfileSuccess()
	local this = ifs_mpgs_login
	this.bReturningFromSave = 1
	ScriptCB_PopScreen()
end

function ifs_mpgs_login_SaveProfileCancel()
	local this = ifs_mpgs_login
	this.bReturningFromSave = 1
	ScriptCB_PopScreen()
end

ifs_mpgs_login = NewIFShellScreen {

	title = nil,
	bg_texture = "iface_bg_1",
	movieIntro = nil,
	movieBackground = nil,
	enable_autologin = nil,
	bNohelptext_backPC = 1,
	
	buttonlabels = NewIFContainer {	
		ScreenRelativeX = 0.2,
		ScreenRelativeY = 0.5,
	},
	
	buttons = NewIFContainer {
		ScreenRelativeX = 0.215,
		ScreenRelativeY = 0.5,
	},
	
	bStartedList = nil,
	
	Enter = function(this, bFwd)
		UpdatePCTitleText(this)
		
		if ifs_main then
			ifs_main.option_mp = 1
		end
		
		ifelem_tabmanager_SetSelected(this, gPCMainTabsLayout, "_tab_multi")
		ifelem_tabmanager_SetSelected(this, gPCMultiPlayerTabsLayout, "_tab_gamespy", 1)
		
		ScriptCB_SetConnectType("wan")
		
		if ScriptCB_IsLoggedIn() then
			print("mpgs_login Enter : Already logged in")
			
			ifelem_tabmanager_SetDimmed(this, gPCMultiPlayerTabsLayout, "_tab_join", nil, 1)
			ifelem_tabmanager_SetDimmed(this, gPCMultiPlayerTabsLayout, "_tab_create", nil, 1)
			ifelem_tabmanager_SetDimmed(this, gPCMultiPlayerTabsLayout, "_tab_friends", nil, 1)
			ifelem_tabmanager_SetDimmed(this, gPCMultiPlayerTabsLayout, "_tab_leaderboard", nil, 1)
			
			local name = ScriptCB_GetLoginName()
			IFText_fnSetString(this.LoginAsTextA, "ifs.mp.join.login_as")
			IFText_fnSetString(this.LoginAsTextB, name)
			IFObj_fnSetVis(this.LoginAsTextA, 1)
			IFObj_fnSetVis(this.LoginAsTextB, 1)
			
		else
			print("mpgs_login Enter : not logged in")
			
			ifelem_tabmanager_SetDimmed(this, gPCMultiPlayerTabsLayout, "_tab_join", nil, 1)
			ifelem_tabmanager_SetDimmed(this, gPCMultiPlayerTabsLayout, "_tab_create", nil, 1)
			ifelem_tabmanager_SetDimmed(this, gPCMultiPlayerTabsLayout, "_tab_friends", 1, 1)
			ifelem_tabmanager_SetDimmed(this, gPCMultiPlayerTabsLayout, "_tab_leaderboard", 1, 1)
		end
		
		gIFShellScreenTemplate_fnEnter(this, bFwd)
		
		ifs_mpgs_login_fnSetPieceVis(this, 1, 1)
		
		if not ScriptCB_IsLoggedIn() then
			ifs_mpgs_login_fnStartLogin(this)
		end
		
		if not bFwd then
			
			local err, r3 = ScriptCB_GetError()
			
			if 8 <= err then
				ScriptCB_CancelLogin()
				if 8 < err then
					ScriptCB_PopScreen()
				end
			else
				ScriptCB_ClearError()
			end
		end
		
		if bFwd then
			
			this.NickStr, this.EmailStr, this.PasswordStr, this.iSaveType, this.iPromptType = ScriptCB_GetGSProfileInfo()
			ScriptCB_SetAmHost(nil)
			ScriptCB_SetDedicated(nil)
			ifs_missionselect.bForMP = 1
			
			if(ScriptCB_InNetGame()) then
				--ifs_movietrans_PushScreen(ifs_mp_main)
				--print("+++++4")
				ScriptCB_SetIFScreen( "ifs_mp_sessionlist" )
			else
				if (this.iPromptType == 2) then 
					-- never login is their pref
					--ifs_movietrans_PushScreen(ifs_mp_main)
					-- only 
					if( this.enable_autologin ) then
						this.enable_autologin = nil
						--print("+++++5")
						ScriptCB_SetIFScreen( "ifs_mp_sessionlist" )
					end
				elseif (this.iPromptType == 1) then
					if( this.enable_autologin ) then
						this.enable_autologin = nil
						-- logout if already logged in
						if( ScriptCB_IsLoggedIn() ) then
							ScriptCB_CancelLogin()
						else
						
						end
					end
				end
			end
		end
	end,
	
	Exit = function(this, bFwd)
		if not (1) then
			if this.bStartedLogin then
				print("exit gamespy login here")
				
				ScriptCB_CancelLogin()
				this.bStartedLogin = nil
			end
			
			ScriptCB_SetNetLoginName(ScriptCB_GetCurrentProfileName())
		end
	end,
	
	Input_GeneralLeft = function(this)
	
	end,
	
	Input_GeneralRight = function(this)
	
	end,
	
	Input_Accept = function(this)
		if((gPlatformStr == "PC") and
		   ( ifelem_tabmanager_HandleInputAccept(this, gPCMainTabsLayout) or
		     ifelem_tabmanager_HandleInputAccept(this, gPCMultiPlayerTabsLayout, 1) ) ) then
   			return
   		end
		
		if(gShellScreen_fnDefaultInputAccept(this)) then
   			return
   		end
		
		if(ifelem_HandleRadioButtonInputAccept(this)) then
   			return
   		end
		
	end,
	
	Input_Back = function(this)
		if this.bPasswordState then
			this.bPasswordState = nil
			this.CurPassword = ""
			ifs_mpgs_login_fnSetPieceVis(this, nil, 1, nil)
		else
			if gPlatformStr == "PC" then
				ScriptCB_PopScreen("ifs_main")
			else
				ScriptCB_PopScreen()
			end
		end
	end,

	Input_KeyDown = function(this, iKey)
		
	end,
	
	fnPostError = function(this,bUserHitYes,ErrorLevel,ErrorMessage)
		if this.bStartedLogin then
			ScriptCB_CancelLogin()
			ScriptCB_ClearError()
			this.bStartedLogin = nil
			ifs_mpgs_login_fnSetPieceVis(this, nil, 1, nil)
			Popup_Busy:fnActivate(nil)
		end
		
		if 9 <= ErrorLevel then
			ScriptCB_PopScreen()
		end
	end,
	
	fnSaveProfileDone = ifs_mpgs_login_fnSaveProfileDone,
}


ifs_mpgs_login_fnBuildScreen = function(this)
	local w,h = ScriptCB_GetSafeScreenInfo()
	
	AddPCTitleText(this)
	
	this.UseFont = "gamefont_medium"
	ifelem_tabmanager_Create(this, gPCMainTabsLayout, gPCMultiPlayerTabsLayout)
	
	this.LoginAsTextA = NewIFText {
		string = "ifs.mp.join.login_as",
		font = "gamefont_large",
		textw = 200,
		halign = "hcenter",
		ScreenRelativeX = 0.5,
		ScreenRelativeY = 0.5,
		nocreatebackground = 1,
	}
	
	this.LoginAsTextB = NewIFText {
		font = "gamefont_large",
		y = 20,
		textw = 500,
		halign = "hcenter",
		ScreenRelativeX = 0.5,
		ScreenRelativeY = 0.5,
		nocreatebackground = 1,
	}
	
	local r3 = 155
	local r4 = 25
end

ifs_mpgs_login_fnBuildScreen(ifs_mpgs_login)
ifs_mpgs_login_fnBuildScreen = nil
AddIFScreen(ifs_mpgs_login, "ifs_mpgs_login")
