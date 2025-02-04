param(
[string]$param1
)
Get-AppxPackage Microsoft.Windows.$param1 | Foreach{Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}