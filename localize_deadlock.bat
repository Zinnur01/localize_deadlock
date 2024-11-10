@echo off
setlocal enabledelayedexpansion
for /f "tokens=2 delims=:" %%a in ('chcp 65001') do set "cp=%%a"

:: The path to the configuration file
set "configFile=config.txt"

::Reading values from a file
for /f "tokens=1,2 delims==" %%A in (%configFile%) do (
    if "%%A"=="localizationPath" set "localizationPath=%%B"
    if "%%A"=="folders" set "folders=%%B"
    if "%%A"=="fromKey" set "fromKey=%%B"
    if "%%A"=="toKey" set "toKey=%%B"
)
set "extension=.txt"

::Renaming files
for %%F in (!folders!) do (
    set "fromPath=!localizationPath!\%%F\%%F_!fromKey!%extension%"
    set "toPath=!localizationPath!\%%F\%%F_!toKey!%extension%"

    if exist !fromPath! (
        move /y !fromPath! !toPath!
        echo Успешно изменено: %%F
    ) else (
        echo Изменения не потребовались: %%F
    )
)

endlocal
pause