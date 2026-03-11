@echo off
setlocal enabledelayedexpansion

set target=8.8.8.8
set logfile=%~dp0ping_output_for_%target%.txt

echo Logging to: %logfile%
echo -------------------------------------------
echo Continuous ping started on %date% %time% >> "%logfile%"
echo ------------------------------------------- >> "%logfile%"

:loop
for /f "delims=" %%a in ('ping -n 1 %target%') do (
    set "line=%%a"
    echo !line!>>"%logfile%"

    echo !line! | find "Request timed out" >nul
    if !errorlevel! == 0 (
        rem ---- RED TEXT ----
        color 0C
        echo *** TIMEOUT DETECTED ***
        echo *** TIMEOUT DETECTED *** >> "%logfile%"
        echo ^G
        color 07
    ) else (
        echo !line!
    )
)

echo.>>"%logfile%"
timeout /t 1 >nul
goto loop