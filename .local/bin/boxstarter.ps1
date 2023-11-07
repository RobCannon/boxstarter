winget configure --file $HOME\.config\dsc\personalize.dsc.yaml --accept-configuration-agreements 


# Install Powershell modules
Write-Host "Installing PowerShell modules" -ForegroundColor Yellow
Set-PSResourceRepository -Name PSGallery -Trusted

Install-PSResource PSReadLine -Reinstall
Install-PSResource Powershell-yaml -Reinstall
Install-PSResource posh-git -Reinstall
Install-PSResource PowerShellForGitHub -Reinstall
Install-PSResource ImportExcel -Reinstall
Install-PSResource Terminal-Icons -Reinstall


# Cleanup desktop icons
Get-ChildItem "$([Environment]::GetFolderPath('DesktopDirectory'))" | ? { $_.Name -eq 'Microsoft Edge.lnk' } | Remove-Item
Get-ChildItem "$([Environment]::GetFolderPath('DesktopDirectory'))" | ? { $_.Name -eq 'Lens.lnk' } | Remove-Item


# Ensure SSH config exists so it can be linked to WSL
if (-Not (Test-Path $HOME\.ssh)) { New-Item $HOME\.ssh -ItemType Directory | Out-Null }

# Ensure .kube\config exists so it can be linked to WSL
if (-Not (Test-Path "$env:USERPROFILE\.kube")) { New-Item "$env:USERPROFILE\.kube" -ItemType Directory | Out-Null }
if (-Not (Test-Path "$env:USERPROFILE\.kube\config")) { New-Item "$env:USERPROFILE\.kube\config" -ItemType File | Out-Null }
$env:KUBECONFIG = "$env:USERPROFILE\.kube\config"
[Environment]::SetEnvironmentVariable('KUBECONFIG', $env:KUBECONFIG, 'User')


Write-Host 'Install WSL Ubuntu' -ForegroundColor Yellow
$env:WSLENV = 'USERPROFILE/p:APPDATA'
[environment]::setenvironmentvariable('WSLENV', $env:WSLENV, 'USER')
$wsl_distributions = wsl --list
if ($wsl_distributions -notcontains "Ubuntu" -or $wsl_distributions -notcontains "Ubuntu (Default)") {
  ubuntu.exe --ui=tui
}
wsl --set-default Ubuntu
