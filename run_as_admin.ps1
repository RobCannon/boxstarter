# Inspired by https://github.com/Microsoft/windows-dev-box-setup-scripts

if (-not (Get-PackageProvider -Name NuGet -ListAvailable -ErrorAction:SilentlyContinue | ? Version -ge '2.8.5.208')) {
    Install-PackageProvider -Name NuGet -MinimumVersion '2.8.5.208' -Force -Scope CurrentUser
}

Write-Host "Bootstrapping NuGet provider" -ForegroundColor Yellow
Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null


cmd.exe /c winrm quickconfig -force

# Write-Host "Enabling CredSSP credentials" -ForegroundColor Yellow
# Enable-WSManCredSSP -Role Client -DelegateComputer * -Force | Out-Null

Update-Help -Force

Write-Host 'Enable Developer Mode'
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" "AllowDevelopmentWithoutDevLicense" 1

Write-Host 'Enable PIN and Windows Hello'
Set-ItemProperty HKLM:\SOFTWARE\Policies\Microsoft\Windows\System -name AllowDomainPINLogon -value 1


Write-Host 'Enable Windows Subsystems/Features'
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart


Write-Host 'Installing docker'
choco install -y docker-desktop
Get-ChildItem "$([Environment]::GetFolderPath('DesktopDirectory'))" | ? { $_.Name -eq 'Docker Desktop.lnk' } | Remove-Item

# Setup synced settings folder from One Drive
if (Test-Path "$env:APPDATA\Code\User") { Remove-Item "$env:APPDATA\Code\User" -Force -Recurse }
if (-Not (Test-Path "$env:APPDATA\Code")) { New-Item -Path "$env:APPDATA\Code" -ItemType Directory | Out-Null }
New-Item -Path "$env:APPDATA\Code\User" -ItemType SymbolicLink -Value "$env:USERPROFILE\OneDrive\Documents\Keep\Tools\Code\User" | Out-Null


# Setup synced .kube settings folder from One Drive
if (Test-Path "$env:USERPROFILE\.kube") { Remove-Item "$env:USERPROFILE\.kube" -Force -Recurse }
New-Item -Path "$env:USERPROFILE\.kube" -ItemType SymbolicLink -Value "$env:USERPROFILE\OneDrive\Documents\Keep\Linux\.kube" | Out-Null
[Environment]::SetEnvironmentVariable('KUBECONFIG', "$env:USERPROFILE\.kube\config", 'User')

# Setup synced .ssh folder from One Drive
if (Test-Path "$env:USERPROFILE\.ssh") { Remove-Item "$env:USERPROFILE\.ssh" -Force -Recurse }
New-Item -Path "$env:USERPROFILE\.ssh" -ItemType SymbolicLink -Value "$env:USERPROFILE\OneDrive\.ssh" | Out-Null

Write-Host "You should reboot to continue"
