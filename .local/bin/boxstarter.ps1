
# Write-Host "Trusting PSGallery" -ForegroundColor Yellow
# Set-PSRepository -Name PSGallery -InstallationPolicy Trusted


# Copy PowerShell profile
# if (-not (Test-Path "$env:USERPROFILE/Documents/PowerShell")) { New-Item "$env:USERPROFILE/Documents/PowerShell" -ItemType Directory | Out-Null }
# if (-not (Test-Path "$env:USERPROFILE/Documents/WindowsPowerShell")) { New-Item "$env:USERPROFILE/Documents/WindowsPowerShell" -ItemType Directory | Out-Null }
# Invoke-WebRequest https://github.com/RobCannon/boxstarter/raw/master/profiles/Powershell/Microsoft.PowerShell_profile.ps1 -OutFile "$env:USERPROFILE/Documents/PowerShell/Microsoft.PowerShell_profile.ps1"
# Invoke-WebRequest https://github.com/RobCannon/boxstarter/raw/master/profiles/Powershell/Microsoft.PowerShell_profile.ps1 -OutFile "$env:USERPROFILE/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1"


# Should be installed from Powershell Core
# Install Powershell modules
# Write-Host "Installing PowerShell modules" -ForegroundColor Yellow
# Install-Module -Name ImportExcel -Scope CurrentUser
# Install-Module -Name posh-git -Scope CurrentUser
# Install-Module -Name oh-my-posh -Scope CurrentUser -AllowPrerelease
# Install-Module -Name TerminalIcons -Scope CurrentUser


Write-Host 'File Explorer Settings' -ForegroundColor Yellow
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name Hidden -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name HideFileExt -Value 0
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2



Write-Host 'Install application from winget' -ForegroundColor Yellow
winget install -e --id Microsoft.WindowsTerminal
winget install -e --id Microsoft.PowerShell
winget install -e --id Git.Git
winget install -e --id 7zip.7zip
winget install -e --id Microsoft.VisualStudioCode
winget install -e --id Microsoft.PowerToys
winget install -e --id Microsoft.dotnet
winget install -e --id Python.Python.3
winget install -e --id Amazon.AWSCLI
winget install -e --id OpenJS.NodeJS 
winget install -e --id suse.RancherDesktop
winget install -e --id Mirantis.Lens

# winget install -e --id Valve.Steam
# Remove-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Run -Name 'Steam' -ErrorAction SilentlyContinue

# # Install Scoop
# Invoke-Expression (New-Object Net.WebClient).DownloadString('https://get.scoop.sh')

# # Sccop required packages
# scoop install 7zip
# scoop install git
# scoop install gzip


# Configure Git
#[environment]::setenvironmentvariable('GIT_SSH', (resolve-path (scoop which ssh)), 'USER')
Write-Host 'Configure git' -ForegroundColor Yellow
git config --global credential.helper manager
git config --global user.name "Rob Cannon"
git config --global user.email "rob@cannonsoftware.com"
git config --global core.autocrlf false

# scoop bucket add extras

# scoop install ssh-agent-wsl


# # cloud and infrastructure tools
# scoop install terraform
# scoop install packer
# scoop install azure-cli
# scoop install diffmerge


#--- Browsers ---
Get-ChildItem "$([Environment]::GetFolderPath('DesktopDirectory'))" | ? { $_.Name -eq 'Microsoft Edge.lnk' } | Remove-Item
#scoop install chrome
#Get-ChildItem "$([Environment]::GetFolderPath('DesktopDirectory'))" | ? { $_.Name -eq 'Google Chrome.lnk' } | Remove-Item

#--- Tools ---

#Get-ChildItem "$([Environment]::GetFolderPath('CommonDesktopDirectory'))" | ? { $_.Name -eq 'DiffMerge.lnk' } | Remove-Item
#Get-ChildItem "$([Environment]::GetFolderPath('CommonDesktopDirectory'))" | ? { $_.Name -eq 'Visual Studio Code.lnk' } | Remove-Item
#Get-ChildItem "$([Environment]::GetFolderPath('CommonDesktopDirectory'))" | ? { $_.Name -eq 'Acrobat Reader DC.lnk' } | Remove-Item


function Install-UserFont {
  [CmdletBinding(ConfirmImpact = 'High')]
  Param (
    [Parameter(Mandatory = $true,
      Position = 0,
      ValueFromPipelineByPropertyName = $true)]
    [Uri]$Uri,
    [Parameter(Mandatory = $true,
      Position = 1,
      ValueFromPipelineByPropertyName = $true)]
    [String]$FontName

  )

  $fontFolder = (New-Object -ComObject Shell.Application).Namespace(0x14)
  if ($fontFolder.Items() | Where-Object Name -eq $FontName) {
    Write-Warning "$FontName is already installed"
  }
  else {
    $fontFileName = [System.Uri]::UnescapeDataString(($Uri.Segments | Select-Object -Last 1 ))
    $fontFilePath = "$env:TEMP\$fontFileName"
    Invoke-WebRequest $Uri -OutFile $fontFilePath -UseBasicParsing

    $fontFolder.CopyHere($fontFilePath, 0x10)

    # Removed the downloaded file
    Remove-Item $fontFilePath -Force
  }
}

Write-Host 'Install Developer Fonts' -ForegroundColor Yellow
Install-UserFont -Uri 'https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete%20Windows%20Compatible.ttf' `
  -FontName 'SauceCodePro NF Regular'
Install-UserFont -Uri 'https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/CascadiaCode/Regular/complete/Caskaydia%20Cove%20Regular%20Nerd%20Font%20Complete%20Windows%20Compatible.otf' `
  -FontName 'CaskaydiaCove NF Regular'

# Ensure SSH config exists so it can be linked to WSL
if (-Not (Test-Path $HOME\.ssh)) { New-Item $HOME\.ssh -ItemType Directory | Out-Null }

# Configure Kubernetes
$env:KUBECONFIG = "$env:USERPROFILE\.kube\config"
if (-Not (Test-Path "$env:USERPROFILE\.kube")) { New-Item "$env:USERPROFILE\.kube" -ItemType Directory | Out-Null }
[Environment]::SetEnvironmentVariable('KUBECONFIG', $env:KUBECONFIG, 'User')

#--- Ubuntu ---
Write-Host 'Install WSL Ubuntu' -ForegroundColor Yellow
$env:WSLENV = 'USERPROFILE/p:APPDATA/p'
[environment]::setenvironmentvariable('WSLENV', $env:WSLENV, 'USER')
wsl --install -d Ubuntu

