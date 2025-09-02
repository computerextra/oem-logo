Write-Host "Computer  Extra  StanSoft  Installer" ForegroundColor Green
Write-Host "------------------------------------" ForegroundColor Green
Write-Host "------------------------------------" ForegroundColor Green
Write-Host "-------- Es werden folgende --------" ForegroundColor Green
Write-Host "------ Programme installiert: ------" ForegroundColor Green
Write-Host "----------- Adobe Reader -----------" ForegroundColor Green
Write-Host "--------- VLC Media Player ---------" ForegroundColor Green
Write-Host "--------------- 7Zip ---------------" ForegroundColor Green
Write-Host "--- Wahlweise: Chrome || Firefox ---" ForegroundColor Green
Write-Host "------------------------------------" ForegroundColor Green

$firefox = Read-Host "Firefox installieren? (y/N)"

$software = "Adobe.Acrobat.Reader.64-bit", "VideoLAN.VLC", "7zip.7zip"

if ($null -eq (Get-Command "winget" -ErrorAction SilentlyContinue)) {
    Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe
}

foreach ($program in $software) {
    winget install $program --silent --accept-package-agreements --accept-source-agreements --disable-interactivity
}

if ($firefox -eq "y") {
    winget install Mozilla.Firefox.de --silent --accept-package-agreements --accept-source-agreements --disable-interactivity
}
else {
    winget install Google.Chrome --silent --accept-package-agreements --accept-source-agreements --disable-interactivity
}
