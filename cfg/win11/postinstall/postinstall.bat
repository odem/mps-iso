echo off

:: VirtIO guest agent
D:\virtio\virtio-win-guest-tools.exe /install /passive /quite /norestart

:: Some Tools
D:\postinstall\tools\python-3.11.4-amd64.exe /passive
powershell.exe "Remove-Item $env:USERPROFILE\AppData\Local\Microsoft\WindowsApps\python*.exe"

:: Python Environment
setx /M PATH "C:\Users\root\AppData\Local\Programs\Python\Python311\;C:\Users\root\AppData\Local\Programs\Python\Python311\Scripts\;C:\Users\root\daas\env\;C:\Users\root\daas\env\api;C:\Users\root\daas\env\pstools;%PATH%"
C:\Users\root\AppData\Local\Programs\Python\Python311\python -m pip install --upgrade pip
C:\Users\root\AppData\Local\Programs\Python\Python311\Scripts\pip install click

:: Firewall (Allow icmp)
netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol="icmpv4:8,any" dir=in action=allow
netsh advfirewall firewall add rule name="ICMP Allow incoming V6 echo request" protocol="icmpv6:8,any" dir=in action=allow

:: SSH Client and Server
powershell.exe "Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0"
powershell.exe "Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0"
echo D | xcopy /s /Y /I D:\postinstall\ssh\id_rsa.pub C:\ProgramData\ssh\administrators_authorized_keys
echo D | xcopy /s /Y /I D:\postinstall\ssh\sshd_config C:\ProgramData\ssh\sshd_config
echo D | xcopy /s /Y /I D:\postinstall\ssh\id_rsa.pub C:\Users\root\.ssh\authorized_keys
powershell.exe "Set-Service ssh-agent -StartupType automatic"
powershell.exe "Start-Service ssh-agent"
powershell.exe "Set-Service sshd -StartupType automatic"
powershell.exe "Start-Service sshd"

:: Windows update
:: powershell.exe -ExecutionPolicy Bypass "Install-Module PSWindowsUpdate -Confirm"
:: powershell.exe -ExecutionPolicy Bypass "Import-Module PSWindowsUpdate"
:: powershell.exe -ExecutionPolicy Bypass "Get-WindowsUpdate"
:: powershell.exe -ExecutionPolicy Bypass "Install-WindowsUpdate -AcceptAll"
:: Reboot
shutdown -f -r -t 10
::

