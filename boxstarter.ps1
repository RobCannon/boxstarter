Write-Host 'Remove Windows Store Apps'
Import-Module Appx

Get-AppxPackage Microsoft.3DBuilder | Remove-AppxPackage
Get-AppxPackage Microsoft.BingFinance | Remove-AppxPackage
Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage
Get-AppxPackage Microsoft.BingSports | Remove-AppxPackage
Get-AppxPackage Microsoft.CommsPhone | Remove-AppxPackage
Get-AppxPackage Microsoft.Getstarted | Remove-AppxPackage
Get-AppxPackage Microsoft.Messaging | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftOfficeHub | Remove-AppxPackage
Get-AppxPackage Microsoft.OneConnect | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsPhone | Remove-AppxPackage
Get-AppxPackage Microsoft.SkypeApp | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsSoundRecorder | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftStickyNotes | Remove-AppxPackage
Get-AppxPackage Microsoft.Office.Sway | Remove-AppxPackage
Get-AppxPackage Microsoft.XboxApp | Remove-AppxPackage
Get-AppxPackage Microsoft.XboxIdentityProvider | Remove-AppxPackage
Get-AppxPackage Microsoft.ZuneMusic | Remove-AppxPackage
Get-AppxPackage Microsoft.ZuneVideo | Remove-AppxPackage
Get-AppxPackage *Autodesk* | Remove-AppxPackage
Get-AppxPackage ActiproSoftware* | Remove-AppxPackage
Get-AppxPackage *EclipseManager | Remove-AppxPackage
Get-AppxPackage *AdobePhotoshopExpress | Remove-AppxPackage
Get-AppxPackage *Dualingo* | Remove-AppxPackage
Get-AppxPackage *Dropbox* | Remove-AppxPackage
Get-AppxPackage *BubbleWitch* | Remove-AppxPackage
Get-AppxPackage king.com.CandyCrush* | Remove-AppxPackage
Get-AppxPackage *Keeper* | Remove-AppxPackage
Get-AppxPackage *Minecraft* | Remove-AppxPackage
Get-AppxPackage *MarchofEmpires* | Remove-AppxPackage
Get-AppxPackage *Plex* | Remove-AppxPackage
Get-AppxPackage *MixedReality* | Remove-AppxPackage
Get-AppxPackage *Microsoft3D* | Remove-AppxPackage
Get-AppxPackage *Print3D* | Remove-AppxPackage
Get-AppxPackage *LinkedIn | Remove-AppxPackage
Get-AppxPackage *McAfeeSecurity | Remove-AppxPackage
Get-AppxPackage Microsoft.Office.Desktop | Remove-AppxPackage
Get-AppxPackage Microsoft.GetHelp | Remove-AppxPackage
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage

Write-Host "Trusting PSGallery" -ForegroundColor Yellow
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted


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


Write-Host 'Set console defaults' -ForegroundColor Yellow
Set-ItemProperty -Path 'HKCU:\Console' -Name 'FontSize' -Value 0x140000 -Type DWord -Force
Set-ItemProperty -Path 'HKCU:\Console' -Name 'ScreenBufferSize' -Value 0x270f0078 -Type DWord -Force
Set-ItemProperty -Path 'HKCU:\Console' -Name 'WindowSize' -Value 0x240078 -Type DWord -Force
Set-ItemProperty -Path 'HKCU:\Console' -Name 'QuickEdit' -Value 1 -Force

Write-Host 'Install application from winget' -ForegroundColor Yellow
winget install -e --id Microsoft.WindowsTerminalPreview
winget install -e --id Microsoft.PowerShell
winget install -e --id Git.Git
winget install -e --id 7zip.7zip
winget install -e --id Microsoft.VisualStudioCode-User-x64
winget install -e --id Valve.Steam
Remove-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Run -Name 'Steam' -ErrorAction SilentlyContinue

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

# # programming languages
# scoop install python
# scoop install nodejs

# # cloud and infrastructure tools
# scoop install terraform
# scoop install packer
# scoop install kubectl
# scoop install azure-cli
# scoop install diffmerge


#--- Browsers ---
Get-ChildItem "$([Environment]::GetFolderPath('DesktopDirectory'))" | ? { $_.Name -eq 'Microsoft Edge.lnk' } | Remove-Item
#scoop install chrome
#Get-ChildItem "$([Environment]::GetFolderPath('DesktopDirectory'))" | ? { $_.Name -eq 'Google Chrome.lnk' } | Remove-Item

#scoop install steam
#Remove-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Run -Name 'Steam' -ErrorAction SilentlyContinue

#--- Tools ---

#Get-ChildItem "$([Environment]::GetFolderPath('CommonDesktopDirectory'))" | ? { $_.Name -eq 'DiffMerge.lnk' } | Remove-Item
#Get-ChildItem "$([Environment]::GetFolderPath('CommonDesktopDirectory'))" | ? { $_.Name -eq 'Visual Studio Code.lnk' } | Remove-Item
#Get-ChildItem "$([Environment]::GetFolderPath('CommonDesktopDirectory'))" | ? { $_.Name -eq 'Acrobat Reader DC.lnk' } | Remove-Item


# code --install-extension abusaidm.html-snippets
# code --install-extension angular.ng-template
# code --install-extension austincummings.razor-plus
# code --install-extension christian-kohler.npm-intellisense
# code --install-extension christian-kohler.path-intellisense
# code --install-extension CoenraadS.bracket-pair-colorizer
# code --install-extension cssho.vscode-svgviewer
# code --install-extension davidbabel.vscode-simpler-icons
# code --install-extension deerawan.vscode-whitespacer
# code --install-extension DotJoshJohnson.xml
# code --install-extension DSKWRK.vscode-generate-getter-setter
# code --install-extension EditorConfig.EditorConfig
# code --install-extension eg2.tslint
# code --install-extension eg2.vscode-npm-script
# code --install-extension esbenp.prettier-vscode
# code --install-extension formulahendry.auto-close-tag
# code --install-extension formulahendry.auto-rename-tag
# code --install-extension hookyqr.beautify
# code --install-extension humao.rest-client
# code --install-extension IBM.output-colorizer
# code --install-extension jock.svg
# code --install-extension mauve.terraform
# code --install-extension mindginative.terraform-snippets
# code --install-extension moppitz.vscode-extension-auto-import
# code --install-extension ms-azure-devops.azure-pipelines
# code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
# code --install-extension ms-mssql.mssql
# code --install-extension ms-python.python
# code --install-extension ms-vscode.azure-account
# code --install-extension ms-vscode.csharp
# code --install-extension ms-vscode.PowerShell
# code --install-extension ms-vscode.typescript-javascript-grammar
# code --install-extension ms-vsts.team
# code --install-extension msjsdiag.debugger-for-chrome
# code --install-extension msjsdiag.debugger-for-edge
# code --install-extension natewallace.angular2-inline
# code --install-extension NoHomey.angular-io-code
# code --install-extension PeterJausovec.vscode-docker
# code --install-extension quicktype.quicktype
# code --install-extension redhat.vscode-yaml
# code --install-extension technosophos.vscode-helm
# code --install-extension tyriar.shell-launcher
# code --install-extension visualstudioexptteam.vscodeintellicode


#npm install -g npm npm-check-updates rimraf typescript gulp @angular/cli 2>$null

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

# # Ensure SSH config exists so it can be linked to WSL
# if (-Not (Test-Path $HOME\.ssh)) { New-Item $HOME\.ssh -ItemType Directory | Out-Null }

# # Configure Kubernetes
# $env:KUBECONFIG = "$env:USERPROFILE\.kube\config"
# if (-Not (Test-Path $env:KUBECONFIG)) { New-Item $env:KUBECONFIG -ItemType Directory | Out-Null }
# [Environment]::SetEnvironmentVariable('KUBECONFIG', $env:KUBECONFIG, 'User')

# Configure Windows Terminal from OneDrive
# New-Item -Path "$ENV:Userprofile\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" `
#   -ItemType "HardLink" `
#   -Value "$ENV:Userprofile\OneDrive\Documents\Keep\WindowsTerminal\settings.json" `
#   -Force | Out-Null

#--- Ubuntu ---
Write-Host 'Install WSL Ubuntu' -ForegroundColor Yellow
$env:WSLENV = 'USERPROFILE/p'
[environment]::setenvironmentvariable('WSLENV', $env:WSLENV, 'USER')
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile ~/Ubuntu.appx -UseBasicParsing
Add-AppxPackage -Path ~/Ubuntu.appx
ubuntu1804 install

Write-Host 'Configure ubuntu on WSL' -ForegroundColor Yellow
wsl -d Ubuntu-18.04 -u root -- printf '[automount]\nroot = /\noptions = "metadata"' ^> /etc/wsl.conf
wsl -d Ubuntu-18.04 -- sh -c "`$(curl -fsSL https://github.com/RobCannon/boxstarter/raw/master/boxstarter.sh)"
Remove-Item ~/Ubuntu.appx
