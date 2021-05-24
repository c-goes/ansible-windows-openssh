set firstcmd=Set-Location -Path '%cd%'
set nextcmd=Invoke-Expression (Get-Content 'ssh_windows.ps1' -Raw)

powershell -Command "Start-Process powershell  -Verb RunAs -ArgumentList \"-noexit\",\"-noprofile\",\"-command ^& {%firstcmd%; %nextcmd% }\""

@pause