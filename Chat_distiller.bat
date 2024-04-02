@echo off
if not exist "chat_distiller\TMP" (md chat_distiller\TMP)

setlocal enabledelayedexpansion

FOR %%x in ("*.log") DO (
    set "filename=%%x"
    set "chd=chat_distiller"
    set "chdTMP=!chd!\TMP"
    set "chdTMPlogfile=!chdTMP!\!filename!"
    set "newname=!filename:.log=_chat-distiller.log!"

    set "chkfile=!chd!\!newname!"
    if exist "!chkfile!" (
        echo !newname! already exists.
    ) else (
        type %%x | find "[CHAT]" >> !chdTMPlogfile!

        set "rendir=!chdTMP!\!filename!"
        ren !rendir! !newname!
        echo %%x distilled.
    )
)

cd !chdTMP!
if exist *.log (
    move *.log ..\
)
cd ..
rd TMP /S /Q

endlocal

pause
