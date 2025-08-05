#OEM Info Auslesen

#Auslesen der Informationen

Param
(
[String]$Computer = "LocalHost"  # entspricht $Computer = "."
)
$Line = "`n" # Zeilenumbruch schreiben

Function Get-Mainboard
{
	#collect Mainboard data:
	$colItems = Get-WmiObject -class win32_baseboard -Computername $Computer
	
	Foreach($objItem in $colItems)
	{
		$objItem.Manufacturer + " " + $objItem.Product + ","
	}
}

Function Get-ComputerInfo
{
# collect computer data:
$colItems = Get-WmiObject -class win32_physicalmemory -Computername $Computer
$gb = 0
ForEach($ObjItem in $colItems)
{
	$gb += $objItem.Capacity / 1073741824
} #ForEach
return "" + $gb + " GB "
} #Function

Function Get-RAM
{
# collect computer data:

$colItems = Get-WmiObject -class win32_physicalmemory -Computername $Computer

Foreach($objItem in $colItems)
{
$objItem.SMBIOSMemoryType
} #ForEach
} #Function

Function Get-DiskInfo
{
# collect disk data:
$colItems = Get-PhysicalDisk

ForEach($objItem in $colItems)
{
$gbt = [Math]::Round($objItem.Size / 1000000000,0)
"" + $gbt + " GB " + $objItem.MediaType + " " + $objItem.BusType + ","
} #ForEach
} #Function

Function Get-GraphicsInfo
{
# collect grafics data:
$colItems = Get-WmiObject -class cim_PCVideoController -Computername $Computer

ForEach($objItem in $colItems)
{
#$objItem.Name + " " + [Math]::Round($objItem.AdapterRAM/1GB,2) + " GB, "
"" + [Math]::Round($objItem.AdapterRAM/1GB,0) + "GB " + $objItem.Name + ","
} #ForEach
} #Function

Function Get-ProcessorInfo
{
# collect processor data
$colItems = Get-WmiObject -class win32_Processor -Computername $Computer

ForEach($objItem in $colItems)
{
$objItem.Name.Trim() + ","
} #ForEach
} #Function

Function Get-OSInfo
{
# collect OS data
$colItems = Get-WmiObject -class win32_OperatingSystem -Computername $Computer

ForEach($objItem in $colItems)
{
$objItem.Caption + " " + $objItem.OSArchitecture
} #ForEach
} #Function

Function Get-BiosInfo
{
$Line + "Seriennummer lt BIOS:"
"-----"
# collect BIOS data
$colItems = Get-WmiObject -class win32_Bios -Computername $Computer

ForEach($objItem in $colItems)
{
"SN:" + $objItem.SerialNumber 
$Line
} #ForEach
} #Function

Function Get-RamConfig
{
$line + "Ram Configuration:"
"-----"
#Collect Data
$colItems = Get-WmiObject -class win32_physicalmemory -Computername $Computer

ForEach($ObjItem in $colItems)
{
	$gb = $objItem.Capacity / 1073741824
	$objItem.Manufacturer + " - " + $objItem.Banklabel + " - " + $objItem.Configuredclockspeed + "Mhz - " + $objItem.Devicelocator + " - " + $gb + "GB - SN: " + $objItem.Serialnumber
} #ForEach
} #Funtion



# and here we go
$m = Get-Mainboard
$p = Get-ProcessorInfo
$c = Get-ComputerInfo
$ram = Get-RAM
switch ($ram[0]){
	0 {$type = " unknown,";break;}
	1 {$type = " OTHER,";break;}
	2 {$type = " DRAM,";break;}
	3 {$type = " Synchronous DRAM,";break;}
	4 {$type = " Cache DRAM,";break;}
	5 {$type = " EDO,";break;}
	6 {$type = " EDRAM,";break;}
	7 {$type = " VRAM,";break;}
	8 {$type = " SRAM,";break;}
	9 {$type = " RAM,";break;}
	10 {$type = " ROM,";break;}
	11 {$type = " Flash,";break;}
	12 {$type = " EEPROM,";break;}
	13 {$type = " FEPROM,";break;}
	14 {$type = " EPROM,";break;}
	15 {$type = " CDRAM,";break;}
	16 {$type = " 3DRAM,";break;}
	17 {$type = " SDRAM,";break;}
	18 {$type = " SGRAM,";break;}
	19 {$type = " RDRAM,";break;}
	20 {$type = " DDR,";break;}
	21 {$type = " DDR2,";break;}
	22 {$type = " DDR2 FB-DIMM,";break;}
    24 {$type = " DDR3,";break;}
	25 {$type = " FBD2,";break;}
    26 {$type = " DDR4,";break;}
	27 {$type = " vllt. DDR5,";break;}
    default {$type = " Irgendwas,"}
}
$d = Get-DiskInfo
$g = Get-GraphicsInfo
$o = Get-OSInfo
"$m $p $c$type $d $g $o" > info.txt
Get-BiosInfo >> info.txt
Get-RamConfig >> info.txt

