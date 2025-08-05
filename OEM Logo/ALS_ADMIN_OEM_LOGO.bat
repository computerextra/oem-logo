@echo off
Set /P nummer=geraetenummer: 
Set nummer
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation /v Manufacturer /t REG_SZ /d "Computer Extra GmbH" /f
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation /v SupportHours /t REG_SZ /d "Montag - Freitag 9:00 - 18:00 Uhr" /f
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation /v SupportPhone /t REG_SZ /d "0561 60 144 0" /f
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation /v SupportProvider /t REG_SZ /d "Computer Extra GmbH" /f
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation /v SupportURL /t REG_SZ /d "https://computer-extra.de" /f
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation /v HelpCustomized /t REG_SZ /d "0" /f
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation /v Model /t REG_SZ /d "GN: "%nummer% /f
exit
