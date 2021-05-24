# Control Windows from Ansible using Windows Service *OpenSSH.Server*

OpenSSH is included in Windows. In this example an installation of Windows 10 21H1 is controlled from a Linux host using Ansible over SSH.

## Adapt the `ssh_windows.ps1` file

- IP addresses
- SSH key

## Windows SSH Ansible

serve this repo from a webserver on the Linux host

```
python3 -m http.server
```


## On Windows: prepare for Ansible

Open cmd.exe and download the files

```
curl -O http://192.168.0.250:8000/ssh_windows.bat
curl -O http://192.168.0.250:8000/ssh_windows.ps1
```


Execute bat to configure SSH server.

Now this Windows host can be controlled securely via SSH and Ansible.

## Install choco

```
ansible-playbook -i hosts.ini install_choco.yml
```

## Run my playbook


```
ansible-playbook -i hosts.ini my.yml
```

My playbook assumes the Windows user `localadmin` has no password and enables login with empty password.

## SSH-tunneled RDP connection without password

The playbook enables RDP to demonstrate how to use RDP tunneled in SSH.

```
ssh -L 3389:127.0.0.1:3389 localadmin@192.168.0.124
```

In another window

```
# dynamic size and scaled to hdpi (choices: 100, 140, 180)
xfreerdp +clipboard /u:localadmin /p:'' /v:127.0.0.1 /dynamic-resolution /scale:180
# fixed size
xfreerdp +clipboard /u:localadmin /p:'' /v:127.0.0.1 /size:1920x1080 
```


# References

- [This PowerShell Script used here is made by @illudium](https://github.com/illudium/ssh_install_and_secure_config_for_windows/blob/master/openssh_for_windows.ps1)
- [Ansible code to install choco is taken from @deekayen](https://github.com/deekayen/ansible-role-chocolatey)
- [Ansible home from @donhector](https://github.com/donhector/ansible-home)
- [Ansible 101 - Episode 14 - Ansible and Windows](https://www.youtube.com/watch?v=N7tgLVCXup4)
- [Ansible Windows packer](https://github.com/ruzickap/packer-templates)