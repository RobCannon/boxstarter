
$release = Invoke-RestMethod "https://api.github.com/repos/PowerShell/Win32-OpenSSH/releases/latest"

Invoke-WebRequest $release.assets.where({$_.name -eq 'OpenSSH-Win64.zip'}).browser_download_url -OutFile OpenSSH-Win64.zip
Expand-Archive OpenSSH-Win64.zip .
Remove-Item .\OpenSSH-Win64.zip

Move-Item ./OpenSSH-Win64 'c:/Program Files/OpenSSH' -Force


& 'c:/Program Files/OpenSSH/install-sshd.ps1'

Set-Service ssh-agent -StartupType Automatic
Start-Service ssh-agent

$path = 'c:\Program Files\OpenSSH;' + [environment]::GetEnvironmentVariable('PATH', 'MACHINE')
[environment]::SetEnvironmentVariable('PATH', $path, 'MACHINE')

