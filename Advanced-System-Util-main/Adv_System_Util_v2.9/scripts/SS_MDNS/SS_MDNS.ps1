Stop-Service -Name "Bonjour Service" -Force -Confirm
Set-Service -Name "Bonjour Service" -StartupType Disabled -Confirm