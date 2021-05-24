Set-PSDebug -Trace 1

Add-WindowsCapability -Online -Name 'OpenSSH.Server~~~~0.0.1.0'

Set-Service sshd -StartupType Automatic

Start-Service sshd


Set-NetFirewallrule -Name OpenSSH-Server-In-TCP -Action Allow

$fwRule = Get-NetFirewallrule -Name OpenSSH-Server-In-TCP




foreach($r in $fwRule) { Set-NetFirewallRule -Name $r.Name -RemoteAddress 192.168.0.250 }


[System.IO.Directory]::CreateDirectory('C:\Users\localadmin\.ssh')

New-Item 'C:\Users\localadmin\.ssh\authorized_keys'
Set-Content C:\Users\localadmin\.ssh\authorized_keys 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILOQjXezZcRZwpzz4A16C3KgOZHIqLBoKPpIZwCIdhEN reeeee'





Restart-Service sshd


(gc C:\ProgramData\ssh\sshd_config) -replace "Match Group administrators", "# Match Group administrators" | sc C:\ProgramData\ssh\sshd_config

(gc C:\ProgramData\ssh\sshd_config) -replace "       AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys", "#       AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys " | sc C:\ProgramData\ssh\sshd_config

(gc C:\ProgramData\ssh\sshd_config) -replace "PasswordAuthentication yes", "PasswordAuthentication no" | sc C:\ProgramData\ssh\sshd_config

(gc C:\ProgramData\ssh\sshd_config) -replace "#PasswordAuthentication no", "PasswordAuthentication no" | sc C:\ProgramData\ssh\sshd_config


Restart-Service sshd