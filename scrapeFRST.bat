:: Scrape FRST.txt and Addition.txt for pertinent data
:: Created by Furtivex
@ECHO OFF
@SETLOCAL
@PROMPT #
SET "downloads=C:\Users\d1savow3d\Downloads"

DIR /B/S/A:-D "%downloads%\FRST*.txt" 2>NUL>"%TEMP%\clipboard00"
DIR /B/S/A:-D "%downloads%\Addition*.txt" 2>NUL>>"%TEMP%\clipboard00"



FOR /F "TOKENS=*" %%G IN ( %TEMP%\clipboard00 ) DO @(
  TYPE "%%G">>"%TEMP%\Clipboard01"
  )

GREP -Eis "detected!|\[X\]|== (ATTENTION|Cyrillic)|AlternateDataStreams|StartupApproved\\Run|\\MountPoints|\(?No File\)?|no ImagePath|ATTENTION:|zero byte File|not found" <"%TEMP%\Clipboard01" >"%TEMP%\Clipboard02"
GREP -Eis "\[File not signed\]|000000000 __SHD" <"%TEMP%\Clipboard01" >"%TEMP%\Clipboard05"
SORT_ -f -u <"%TEMP%\Clipboard02" >"%TEMP%\Clipboard03"
SORT_ -f -u <"%TEMP%\Clipboard05" >"%TEMP%\Clipboard06"

ECHO.Start::>"%TEMP%\ClipboardFinal.txt"
ECHO.SystemRestore: On>>"%TEMP%\ClipboardFinal.txt"
ECHO.CreateRestorePoint:>>"%TEMP%\ClipboardFinal.txt"
ECHO.>>"%TEMP%\ClipboardFinal.txt"
TYPE "%TEMP%\Clipboard03">>"%TEMP%\ClipboardFinal.txt"
ECHO.>>"%TEMP%\ClipboardFinal.txt"
ECHO.Removeproxy:>>"%TEMP%\ClipboardFinal.txt"
ECHO.Hosts:>>"%TEMP%\ClipboardFinal.txt"
ECHO.CMD: reg export HKLM\System\CurrentControlSet\Services\SharedAccess\Defaults\FirewallPolicy\FirewallRules C:\FirewallBackup.reg>>"%TEMP%\ClipboardFinal.txt"
ECHO.C:\FirewallBackup.reg>>"%TEMP%\ClipboardFinal.txt"
ECHO.CMD: bitsadmin /reset /allusers>>"%TEMP%\ClipboardFinal.txt"
ECHO.EmptyEventLogs:>>"%TEMP%\ClipboardFinal.txt"
ECHO.CMD: DIR /B/S/A:-D ^<LOOK IN HERE^>>>"%TEMP%\ClipboardFinal.txt"
ECHO.CMD: DISM /Online /Cleanup-image /Restorehealth>>"%TEMP%\ClipboardFinal.txt"
ECHO.CMD: sfc /scannow>>"%TEMP%\ClipboardFinal.txt"
ECHO.Emptytemp:>>"%TEMP%\ClipboardFinal.txt"
ECHO.End::>>"%TEMP%\ClipboardFinal.txt"
ECHO.>>"%TEMP%\ClipboardFinal.txt"
ECHO.>>"%TEMP%\ClipboardFinal.txt"
ECHO.>>"%TEMP%\ClipboardFinal.txt"
ECHO.>>"%TEMP%\ClipboardFinal.txt"
TYPE "%TEMP%\Clipboard06">>"%TEMP%\ClipboardFinal.txt"


"C:\Program Files\Notepad2\Notepad2.exe" "%TEMP%\ClipboardFinal.txt"
DEL /F/Q "%TEMP%\Clipboard0?" >NUL 2>&1