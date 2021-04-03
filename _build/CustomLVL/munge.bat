@REM WARNING: enabledelayedexpansion means ! is a special character,
@REM   which means it isn't available for use as the mungeapp recursive
@REM   wildcard character.  Use the alternate $ instead.
@setlocal enabledelayedexpansion

@set MUNGE_ROOT_DIR=..
@if not "%1"=="" set MUNGE_PLATFORM=%1
@if not "%2"=="" set INPUT_FILE=%2
@if %MUNGE_PLATFORM%x==x set MUNGE_PLATFORM=PC
@if %MUNGE_LANGDIR%x==x set MUNGE_LANGDIR=ENG

@set MUNGE_BIN_DIR=%CD%\%MUNGE_ROOT_DIR%\..\ToolsFL\Bin
@set PATH=%CD%\..\..\ToolsFL\Bin;%PATH%


@set MUNGE_ARGS=-checkdate -continue -platform %MUNGE_PLATFORM%
@set MUNGE_DIR=CustomLVL\MUNGED\%MUNGE_PLATFORM%
@set OUTPUT_DIR=%MUNGE_ROOT_DIR%\_LVL_%MUNGE_PLATFORM%\CustomLVL

@set LOCAL_MUNGE_LOG="%CD%\%MUNGE_PLATFORM%_MungeLog.txt"
@if "%MUNGE_LOG%"=="" (
	@set MUNGE_LOG=%LOCAL_MUNGE_LOG%
	@if exist %LOCAL_MUNGE_LOG% ( del %LOCAL_MUNGE_LOG% )
)

@if not exist MUNGED mkdir MUNGED
@if not exist %MUNGE_DIR% mkdir %MUNGE_DIR%
@if not exist %MUNGE_ROOT_DIR%\_LVL_%MUNGE_PLATFORM% mkdir %MUNGE_ROOT_DIR%\_LVL_%MUNGE_PLATFORM%
@if not exist %MUNGE_ROOT_DIR%\_LVL_%MUNGE_PLATFORM%\CustomLVL mkdir %MUNGE_ROOT_DIR%\_LVL_%MUNGE_PLATFORM%\CustomLVL
@if not exist %OUTPUT_DIR% mkdir %OUTPUT_DIR%

@REM ===== Handle files in CustomLVL\Movies\
@set SOURCE_SUBDIR=CustomLVL\movies
@set SOURCE_DIR=
@if not %MUNGE_OVERRIDE_DIR%x==x (
	@for %%a in (%MUNGE_OVERRIDE_DIR%) do @set SOURCE_DIR=!SOURCE_DIR! %MUNGE_ROOT_DIR%\%%a\%SOURCE_SUBDIR%
)
@set SOURCE_DIR=%SOURCE_DIR% %MUNGE_ROOT_DIR%\%SOURCE_SUBDIR%

configmunge -inputfile *.mcfg %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -outputdir %MUNGE_DIR% -hashstrings 2>>%MUNGE_LOG%
@move /y configmunge.log configmunge_mcfg.log
for %%A in (%MUNGE_ROOT_DIR%\%SOURCE_SUBDIR%\%MUNGE_PLATFORM%\*.mlst) do moviemunge -input %%A -output %MUNGE_ROOT_DIR%\_LVL_%MUNGE_PLATFORM%\Movies\%%~nA.mvs -checkdate 2>>%MUNGE_LOG%


REM ===== Merge and munge localization files
@set SOURCE_SUBDIR=CustomLVL\localize
@set SOURCE_DIR=
@set SOURCE_DIR=%SOURCE_DIR% %MUNGE_ROOT_DIR%\%SOURCE_SUBDIR%

localizemunge -inputfile *.cfg %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -outputdir %MUNGE_DIR% 2>>%MUNGE_LOG%


@REM ===== Handle files in CustomLVL\
@set SOURCE_SUBDIR=CustomLVL
@set SOURCE_DIR=
@set SOURCE_DIR=%SOURCE_DIR% %MUNGE_ROOT_DIR%\%SOURCE_SUBDIR%

configmunge -inputfile effects\*.fx %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -outputdir %MUNGE_DIR% 2>>%MUNGE_LOG%
@move /y configmunge.log configmunge_fx.log
scriptmunge -inputfile scripts\*.lua %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -outputdir %MUNGE_DIR% 2>>%MUNGE_LOG%
@for /f %%A in ('dir %SOURCE_DIR%\scripts /s /b /Ad') do scriptmunge -inputfile *.lua %MUNGE_ARGS% -sourcedir %%A -outputdir %MUNGE_DIR% 2>>%MUNGE_LOG%

%MUNGE_PLATFORM%_texturemunge -inputfile $*.tga %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -outputdir %MUNGE_DIR% 2>>%MUNGE_LOG%
fontmunge -inputfile fonts\*.fff %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -outputdir %MUNGE_DIR% 2>>%MUNGE_LOG%
%MUNGE_PLATFORM%_modelmunge -inputfile $*.msh %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -outputdir %MUNGE_DIR% 2>>%MUNGE_LOG%
if /I "%MUNGE_PLATFORM%"=="PS2" binmunge -inputfile ps2bin\*.ps2bin %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -outputdir %MUNGE_DIR% 2>>%MUNGE_LOG%

@REM ===== Build LVL files

levelpack -inputfile REQ\*.req %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -inputdir %MUNGE_DIR% -outputdir %MUNGE_DIR% 2>>%MUNGE_LOG%
move /y levelpack.log levelpack_sublvl.log

levelpack -inputfile %INPUT_FILE% %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -inputdir %MUNGE_DIR% -outputdir %OUTPUT_DIR% 2>>%MUNGE_LOG%

if /I "%MUNGE_PLATFORM%"=="PS2" levelpack -inputfile %INPUT_FILE% -common Common\MUNGED\%MUNGE_PLATFORM%\core.files Common\MUNGED\%MUNGE_PLATFORM%\common.files %MUNGE_ARGS% -sourcedir %SOURCE_DIR% -inputdir %MUNGE_DIR% -outputdir %OUTPUT_DIR% 2>>%MUNGE_LOG%

@REM If the munge log was created locally and has anything in it, view it
@if not %MUNGE_LOG%x==%LOCAL_MUNGE_LOG%x goto skip_mungelog
@set FILE_CONTENTS_TEST=
@if exist %MUNGE_LOG% for /f %%i in (%MUNGE_LOG:"=%) do @set FILE_CONTENTS_TEST=%%i
@if not "%FILE_CONTENTS_TEST%"=="" ( Notepad.exe %MUNGE_LOG% ) else ( if exist %MUNGE_LOG% (del %MUNGE_LOG%) )

:skip_mungelog
@endlocal
