:: Scrape FRST.txt and Addition.txt for pertinent data
:: Created by Furtivex
@ECHO OFF
@SETLOCAL
@PROMPT #
SET "downloads=C:\Users\d1savow3d\Downloads"

DIR /B/S/A:-D "%downloads%\FRST*.txt" 2>NUL>"%TEMP%\clipboard00"
DIR /B/S/A:-D "%downloads%\Addition*.txt" 2>NUL>>"%TEMP%\clipboard00"

IF EXIST "%TEMP%\ClipboardFinal.txt" DEL /F/Q "%TEMP%\ClipboardFinal.txt"

FOR /F "TOKENS=*" %%G IN ( %TEMP%\clipboard00 ) DO @(
  TYPE "%%G">>"%TEMP%\Clipboard01"
  )

GREP -Eis "detected!|\[X\]|== (ATTENTION|Cyrillic)|AlternateDataStreams|\\StartupApproved\\|\\MountPoints|\(?No File\)?|no ImagePath|ATTENTION:|zero byte File|not found|grubx64\.efi" <"%TEMP%\Clipboard01" >"%TEMP%\Clipboard02"
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
ECHO.>>"%TEMP%\ClipboardFinal.txt"
ECHO.StartBatch:>>"%TEMP%\ClipboardFinal.txt"
ECHO.REG ADD "HKLM\Software\Microsoft\Windows Defender" /T REG_DWORD /V DisableAntiSpyware /D 0 /F>>"%TEMP%\ClipboardFinal.txt"
ECHO.REG ADD "HKLM\Software\Microsoft\Windows Defender" /T REG_DWORD /V DisableAntiVirus /D 0 /F>>"%TEMP%\ClipboardFinal.txt"
ECHO.cd %ProgramFiles%\Windows Defender>>"%TEMP%\ClipboardFinal.txt"
ECHO.MpCmdRun.exe -removedefinitions -dynamicsignatures>>"%TEMP%\ClipboardFinal.txt"
ECHO.MpCmdRun.exe -SignatureUpdate>>"%TEMP%\ClipboardFinal.txt"
ECHO.EndBatch:>>"%TEMP%\ClipboardFinal.txt"
ECHO.>>"%TEMP%\ClipboardFinal.txt"

ECHO.CMD: reg export HKLM\System\CurrentControlSet\Services\SharedAccess\Defaults\FirewallPolicy\FirewallRules C:\FirewallBackup.reg>>"%TEMP%\ClipboardFinal.txt"
ECHO.C:\FirewallBackup.reg>>"%TEMP%\ClipboardFinal.txt"
ECHO.CMD: bitsadmin /reset /allusers>>"%TEMP%\ClipboardFinal.txt"

ECHO.StartPowerShell:>>"%TEMP%\ClipboardFinal.txt"
ECHO.# Function to create a new firewall rule if it does not exist. Credits AdvancedSetup>>"%TEMP%\ClipboardFinal.txt"
ECHO.$ruleNameTCP = "Block Inb TCP">>"%TEMP%\ClipboardFinal.txt"
ECHO.$ruleNameUDP = "Block Inb UDP">>"%TEMP%\ClipboardFinal.txt"
ECHO.$tcpPorts = "135-139","445","1234","3389","5555","9034" # TCP ports and ranges as an array>>"%TEMP%\ClipboardFinal.txt"
ECHO.$udpPorts = "135-139","445","1234","3389","5555","9034" # UDP ports and ranges as an array>>"%TEMP%\ClipboardFinal.txt"
ECHO.>>"%TEMP%\ClipboardFinal.txt"
ECHO.function Create-FirewallRule {>>"%TEMP%\ClipboardFinal.txt"
ECHO.    param ^(>>"%TEMP%\ClipboardFinal.txt"
ECHO.        [string]$ruleName,>>"%TEMP%\ClipboardFinal.txt"
ECHO.        [string[]]$ports, # Accepts an array of ports>>"%TEMP%\ClipboardFinal.txt"
ECHO.        [string]$protocol>>"%TEMP%\ClipboardFinal.txt"
ECHO.    ^)>>"%TEMP%\ClipboardFinal.txt"
ECHO.>>"%TEMP%\ClipboardFinal.txt"
ECHO.    # Check if the rule already exists>>"%TEMP%\ClipboardFinal.txt"
ECHO.    if ^(-not ^(Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue^)^) {>>"%TEMP%\ClipboardFinal.txt"
ECHO.        try {>>"%TEMP%\ClipboardFinal.txt"
ECHO.            # Try to create the new firewall rule>>"%TEMP%\ClipboardFinal.txt"
ECHO.            New-NetFirewallRule -DisplayName $ruleName -Direction Inbound -LocalPort $ports -Protocol $protocol -Action Block>>"%TEMP%\ClipboardFinal.txt"
ECHO.            Write-Host "Created rule '$ruleName'.">>"%TEMP%\ClipboardFinal.txt"
ECHO.        } catch {>>"%TEMP%\ClipboardFinal.txt"
ECHO.            Write-Error "Failed to create rule '$ruleName': $_">>"%TEMP%\ClipboardFinal.txt"
ECHO.        }>>"%TEMP%\ClipboardFinal.txt"
ECHO.    } else {>>"%TEMP%\ClipboardFinal.txt"
ECHO.        Write-Host "Rule '$ruleName' already exists.">>"%TEMP%\ClipboardFinal.txt"
ECHO.    }>>"%TEMP%\ClipboardFinal.txt"
ECHO.}>>"%TEMP%\ClipboardFinal.txt"
ECHO.EndPowerShell:>>"%TEMP%\ClipboardFinal.txt"

ECHO.EmptyEventLogs:>>"%TEMP%\ClipboardFinal.txt"
ECHO.CMD: DIR /B/S/A:-D ^<LOOK IN HERE^>>>"%TEMP%\ClipboardFinal.txt"
ECHO.CMD: DISM /Online /Cleanup-image /Restorehealth>>"%TEMP%\ClipboardFinal.txt"
ECHO.CMD: sfc /scannow>>"%TEMP%\ClipboardFinal.txt"
ECHO.CMD: ECHO Y^|chkdsk c: /f /r>>"%TEMP%\ClipboardFinal.txt"
ECHO.CMD: IF EXIST %WINDIR%\Logs\DISM\dism.log TYPE %WINDIR%\Logs\DISM\dism.log^|FINDSTR -ri "[^DISM|^cleanmgr|^la57setup]\.exe">>"%TEMP%\ClipboardFinal.txt"
ECHO.Emptytemp:>>"%TEMP%\ClipboardFinal.txt"
ECHO.End::>>"%TEMP%\ClipboardFinal.txt"
ECHO.>>"%TEMP%\ClipboardFinal.txt"
ECHO.>>"%TEMP%\ClipboardFinal.txt"
ECHO.>>"%TEMP%\ClipboardFinal.txt"
ECHO.>>"%TEMP%\ClipboardFinal.txt"
TYPE "%TEMP%\Clipboard06">>"%TEMP%\ClipboardFinal.txt"

"C:\Program Files\Notepad2\Notepad2.exe" "%TEMP%\ClipboardFinal.txt"
DEL /F/Q "%TEMP%\Clipboard0?" >NUL 2>&1