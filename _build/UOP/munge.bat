@REM WARNING: enabledelayedexpansion means ! is a special character,
@REM   which means it isn't available for use as the mungeapp recursive
@REM   wildcard character.  Use the alternate $ instead.
@setlocal enabledelayedexpansion

@set MUNGE_ROOT_DIR=..
@if not "%1"=="" set BUILD_NUMBER=%1
@if %BUILD_NUMBER%x==x set BUILD_NUMBER=R129


@REM ===== set variables
@REM set MUNGE_LANGDIR=ENG
@set MUNGE_PLATFORM=PC
@REM set MUNGE_BIN_DIR=%CD%\%MUNGE_ROOT_DIR%\..\ToolsFL\Bin
@set PATH=%CD%\..\..\ToolsFL\Bin;%PATH%
@set MUNGE_ARGS=-checkdate -continue -platform %MUNGE_PLATFORM%
@set MUNGE_DIR=UOP\MUNGED\%MUNGE_PLATFORM%
@set MUNGE_DIR_R129=UOP\MUNGED\R129
@set MUNGE_DIR_R130=UOP\MUNGED\R130
@set OUTPUT_DIR=%MUNGE_ROOT_DIR%\_LVL_%MUNGE_PLATFORM%\%BUILD_NUMBER%

@set LOCAL_MUNGE_LOG="%CD%\%MUNGE_PLATFORM%_MungeLog.txt"
@if "%MUNGE_LOG%"=="" (
	@set MUNGE_LOG=%LOCAL_MUNGE_LOG%
	@if exist %LOCAL_MUNGE_LOG% ( del %LOCAL_MUNGE_LOG% )
)


@REM ===== check folders
@if not exist UOP\MUNGED mkdir UOP\MUNGED
@if not exist %MUNGE_DIR% mkdir %MUNGE_DIR%
@if not exist %MUNGE_DIR_R129% mkdir %MUNGE_DIR_R129%
@if not exist %MUNGE_DIR_R130% mkdir %MUNGE_DIR_R130%
@if not exist %MUNGE_ROOT_DIR%\_LVL_%MUNGE_PLATFORM% mkdir %MUNGE_ROOT_DIR%\_LVL_%MUNGE_PLATFORM%
@if not exist %OUTPUT_DIR% mkdir %OUTPUT_DIR%


@REM ===== copy premunged files
@set SOURCE_SUBDIR=CustomLVL
if exist %MUNGE_ROOT_DIR%\%SOURCE_SUBDIR%\MUNGED xcopy %MUNGE_ROOT_DIR%\%SOURCE_SUBDIR%\MUNGED\*.* %MUNGE_DIR% /D /Q /Y


@REM ===== Handle files in CustomLVL\movies\
@set SOURCE_SUBDIR=CustomLVL\movies
@set SOURCE_DIR=
@if not %MUNGE_OVERRIDE_DIR%x==x (
	@for %%a in (%MUNGE_OVERRIDE_DIR%) do @set SOURCE_DIR=!SOURCE_DIR! %MUNGE_ROOT_DIR%\%%a\%SOURCE_SUBDIR%
)
@set SOURCE_DIR=%SOURCE_DIR% %MUNGE_ROOT_DIR%\%SOURCE_SUBDIR%

configmunge -inputfile *.mcfg %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -outputdir %MUNGE_DIR% -hashstrings 2>>%MUNGE_LOG%
@move /y configmunge.log UOP\configmunge_mcfg.log
for %%A in (%MUNGE_ROOT_DIR%\%SOURCE_SUBDIR%\%MUNGE_PLATFORM%\*.mlst) do moviemunge -input %%A -output %MUNGE_ROOT_DIR%\_LVL_%MUNGE_PLATFORM%\Movies\%%~nA.mvs -checkdate 2>>%MUNGE_LOG%


REM ===== Merge and munge localization files
@set SOURCE_SUBDIR=CustomLVL\localize
@set SOURCE_DIR=
@set SOURCE_DIR=%SOURCE_DIR% %MUNGE_ROOT_DIR%\%SOURCE_SUBDIR%

localizemunge -inputfile *.cfg %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -outputdir %MUNGE_DIR% 2>>%MUNGE_LOG%
@move /y localizemunge.log UOP\localizemunge.log

@REM ===== Addme
@set SOURCE_SUBDIR=CustomLVL\addme
@set SOURCE_DIR=
@set SOURCE_DIR=%SOURCE_DIR% %MUNGE_ROOT_DIR%\%SOURCE_SUBDIR%
scriptmunge -inputfile addme.lua %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -outputdir %OUTPUT_DIR%

@REM ===== Handle files in CustomLVL\
@set SOURCE_SUBDIR=CustomLVL
@set SOURCE_DIR=
@set SOURCE_DIR=%SOURCE_DIR% %MUNGE_ROOT_DIR%\%SOURCE_SUBDIR%

odfmunge -inputfile $*.odf %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -outputdir %MUNGE_DIR% 2>>%MUNGE_LOG%
@move /y odfmunge.log UOP\odfmunge.log

configmunge -inputfile effects\*.fx %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -outputdir %MUNGE_DIR% 2>>%MUNGE_LOG%
@move /y configmunge.log UOP\configmunge_fx.log

scriptmunge -inputfile scripts\*.lua %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -outputdir %MUNGE_DIR% 2>>%MUNGE_LOG%
@for /f %%A in ('dir %SOURCE_DIR%\scripts /s /b /Ad') do scriptmunge -inputfile *.lua %MUNGE_ARGS% -sourcedir %%A -outputdir %MUNGE_DIR% 2>>%MUNGE_LOG%
scriptmunge -inputfile *.lua %MUNGE_ARGS% -sourcedir %SOURCE_DIR%\%BUILD_NUMBER% -outputdir UOP\MUNGED\%BUILD_NUMBER% 2>>%MUNGE_LOG%
@move /y scriptmunge.log UOP\scriptmunge.log

configmunge -inputfile $*.sanm %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -outputdir %MUNGE_DIR% 2>>%MUNGE_LOG%
@move /y configmunge.log UOP\configmunge_sanm.log

configmunge -inputfile $*.hud %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -outputdir %MUNGE_DIR% 2>>%MUNGE_LOG%
@move /y configmunge.log UOP\configmunge_hud.log

%MUNGE_PLATFORM%_texturemunge -inputfile $*.tga %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -outputdir %MUNGE_DIR% 2>>%MUNGE_LOG%
@move /y PC_texturemunge.log UOP\PC_texturemunge.log

fontmunge -inputfile fonts\*.fff %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -outputdir %MUNGE_DIR% 2>>%MUNGE_LOG%
@move /y fontmunge.log UOP\fontmunge.log

%MUNGE_PLATFORM%_modelmunge -inputfile $*.msh %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -outputdir %MUNGE_DIR% 2>>%MUNGE_LOG%
@move /y PC_modelmunge.log UOP\PC_modelmunge.log


@REM ===== Build sub LVL files
levelpack -inputfile REQ\*.req %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -inputdir %MUNGE_DIR% -outputdir %MUNGE_DIR% 2>>%MUNGE_LOG%
move /y levelpack.log UOP\levelpack_sublvl.log


@REM ===== pack LVL files
@set SOURCE_SUBDIR=CustomLVL
@set SOURCE_DIR=
@set SOURCE_DIR=%SOURCE_DIR% %MUNGE_ROOT_DIR%\%SOURCE_SUBDIR%


levelpack -inputfile common.req -writefiles %MUNGE_DIR%\common.files %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -inputdir %MUNGE_DIR% UOP\MUNGED\%BUILD_NUMBER% -outputdir %OUTPUT_DIR% 2>>%MUNGE_LOG%
levelpack -inputfile ingame.req -common %MUNGE_DIR%\common.files %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -inputdir %MUNGE_DIR% UOP\MUNGED\%BUILD_NUMBER% -outputdir %OUTPUT_DIR% 2>>%MUNGE_LOG%
levelpack -inputfile shell.req -common %MUNGE_DIR%\common.files %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -inputdir %MUNGE_DIR% UOP\MUNGED\%BUILD_NUMBER% -outputdir %OUTPUT_DIR% 2>>%MUNGE_LOG%
levelpack -inputfile user_script_10.req -common %MUNGE_DIR%\common.files %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -inputdir %MUNGE_DIR% UOP\MUNGED\%BUILD_NUMBER% -outputdir %OUTPUT_DIR% 2>>%MUNGE_LOG%
levelpack -inputfile custom_gc_10.req -common %MUNGE_DIR%\common.files %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -inputdir %MUNGE_DIR% UOP\MUNGED\%BUILD_NUMBER% -outputdir %OUTPUT_DIR% 2>>%MUNGE_LOG%
levelpack -inputfile v1.3patch_strings.req -common %MUNGE_DIR%\common.files %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -inputdir %MUNGE_DIR% UOP\MUNGED\%BUILD_NUMBER% -outputdir %OUTPUT_DIR% 2>>%MUNGE_LOG%
@move /y levelpack.log UOP\levelpack.log


@REM If the munge log was created locally and has anything in it, view it
@if not %MUNGE_LOG%x==%LOCAL_MUNGE_LOG%x goto skip_mungelog
@set FILE_CONTENTS_TEST=
@if exist %MUNGE_LOG% for /f %%i in (%MUNGE_LOG:"=%) do @set FILE_CONTENTS_TEST=%%i
@if not "%FILE_CONTENTS_TEST%"=="" ( Notepad.exe %MUNGE_LOG% ) else ( if exist %MUNGE_LOG% (del %MUNGE_LOG%) )

:skip_mungelog
@endlocal
