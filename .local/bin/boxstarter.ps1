winget configure --file $HOME\.config\dsc\configuration.dsc.yaml --accept-configuration-agreements


# Install Powershell modules
Write-Host "Installing PowerShell modules" -ForegroundColor Yellow
Set-PSResourceRepository -Name PSGallery -Trusted

Install-PSResource -Name Powershell-yaml -Reinstall
Install-PSResource -Name posh-git -Reinstall
Install-PSResource -Name PowerShellForGitHub -Reinstall
Install-PSResource -Name ImportExcel -Reinstall
Install-PSResource -Name Terminal-Icons -Reinstall
Install-PSResource -Name Microsoft.Graph -Reinstall
Install-PSResource -Name Microsoft.WinGet.Client -Reinstall
Install-PSResource -Name ExchangeOnlineManagement -Reinstall
Install-PSResource -Name PnP.PowerShell -Reinstall
Install-PSResource -Name PSWriteHTML -Reinstall
Install-PSResource -Name Microsoft.WinGet.DSC -Prerelease


# Cleanup desktop icons
Get-ChildItem "$([Environment]::GetFolderPath('DesktopDirectory'))" | ? { $_.Name -eq 'Microsoft Edge.lnk' } | Remove-Item
Get-ChildItem "$([Environment]::GetFolderPath('DesktopDirectory'))" | ? { $_.Name -eq 'Lens.lnk' } | Remove-Item


# Sync .ssh to
if ((Test-Path $HOME\OneDrive\.ssh) -and -Not (Test-Path $HOME\.ssh)) {
  New-Item -Path $HOME\.ssh -ItemType SymbolicLink -Value $HOME\OneDrive\.ssh | Out-Null
}
if ((Test-Path $HOME\OneDrive\.aws) -and -Not (Test-Path $HOME\.aws)) {
  New-Item -Path $HOME\.aws -ItemType SymbolicLink -Value $HOME\OneDrive\.aws | Out-Null
}

# Ensure .kube\config exists so it can be linked to WSL
if (-Not (Test-Path "$env:USERPROFILE\.kube")) { New-Item "$env:USERPROFILE\.kube" -ItemType Directory | Out-Null }
if (-Not (Test-Path "$env:USERPROFILE\.kube\config")) { New-Item "$env:USERPROFILE\.kube\config" -ItemType File | Out-Null }
$env:KUBECONFIG = "$env:USERPROFILE\.kube\config"
[Environment]::SetEnvironmentVariable('KUBECONFIG', $env:KUBECONFIG, 'User')


# Write-Host 'Install WSL Ubuntu' -ForegroundColor Yellow
# $wsl_distributions = wsl --list
# # if ($wsl_distributions -notcontains "Ubuntu" -or $wsl_distributions -notcontains "Ubuntu (Default)") {
# #   ubuntu.exe
# # }
# wsl --set-default Ubuntu
