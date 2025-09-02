$SysInfo = Get-ComputerInfo
$SpeicherInfos = Get-Disk
$RamInfos = Get-WmiObject win32_physicalmemory
$MoboInfos = Get-WmiObject Win32_BaseBoard
$GrakaInfos = Get-WmiObject Win32_VideoController


$MoBoHersteller = $MoboInfos.Manufacturer
$MoBoModell = $MoboInfos.Product

$ProcesserName = $SysInfo.CsProcessors.Name
$NumberOfCores = $SysInfo.CsProcessors.NumberOfCores
$MaxClockSpeed = $SysInfo.CsProcessors.MaxClockSpeed

$Windows = $SysInfo.OsName

$Seriennnummer = (Get-WmiObject -class win32_bios).SerialNumber  

$i = 0
$RamGesamt = 0
foreach ($currentItemName in $RamInfos) {
	$i += 1
	$RamGesamt += $currentItemName.Capacity
	$Typ = $currentItemName.DeviceLocator
	$RamHersteller = $currentItemName.Manufacturer	
	$RamSpeed = $currentItemName.Configuredclockspeed
}
$Typ = $Typ.split("-")[0]
$RamGesamt = $RamGesamt / 1GB
$EinzelRam = $RamGesamt / $i

$ausgabe = "$MoBoHersteller $MoboModell, $ProcesserName ($NumberOfCores Kerne)@$MaxClockSpeed GHz, $RamHersteller $RamGesamt GB $Typ ($i x $EinzelRam GB) @ $RamSpeed MHz,"

foreach ($currentItemName in $SpeicherInfos) {
	$name = $currentItemName.FriendlyName
	$Typ = $currentItemName.BusType
	$speicher = [math]::Round($currentItemName.Size / 1000 / 1000 / 1000)
	$ausgabe += "$Typ $name ($speicher GB), "
}

if ($GrakaInfos) {
	foreach ($Adapter in $GrakaInfos) {
		$name = $Adapter.Description
		if ($name -Match "Intel") {
			$ausgabe += "$name, "
		}
		else {
			$vram = [math]::Round($Adapter.AdapterRAM / 1GB)
			$ausgabe += "$vram GB $name, "
		}
	}
}

$ausgabe += "$Windows"

if ($Seriennnummer) {
	$ausgabe += ", SN: $Seriennnummer"
}

Write-Host $ausgabe
Pause

