# Inspired by https://github.com/Microsoft/windows-dev-box-setup-scripts

Disable-UAC

Set-ExecutionPolicy Bypass -Force -Scope CurrentUser

if (-not (Get-PackageProvider -Name NuGet -ListAvailable -ErrorAction:SilentlyContinue | ? Version -ge '2.8.5.208')) {
    Install-PackageProvider -Name NuGet -MinimumVersion '2.8.5.208' -Force -Scope CurrentUser
}

# Set strong cryptography on 32 bit .Net Framework (version 4 and above) so TLS 1.2 or above it used
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord

Write-Host "Bootstrapping NuGet provider" -ForegroundColor Yellow
Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null

Write-Host "Trusting PSGallery" -ForegroundColor Yellow
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

Write-Host "Installing PowerShell modules" -ForegroundColor Yellow
Install-Module -Name ImportExcel -Scope CurrentUser
Install-Module -Name SqlServer -Scope CurrentUser
# Install-Module -Name AWSPowerShell -Scope CurrentUser
# Install-Module -Name Azure -Scope CurrentUser
Install-Module -Name Pester -Scope CurrentUser -Force -SkipPublisherCheck
Install-Module -Name psake -Scope CurrentUser

cmd.exe /c winrm quickconfig -force

Write-Host "Enabling CredSSP credentials" -ForegroundColor Yellow
Enable-WSManCredSSP -Role Client -DelegateComputer * -Force | Out-Null

Update-Help -Force

Write-Host 'Enable Developer Mode'
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" "AllowDevelopmentWithoutDevLicense" 1

Write-Host 'File Explorer Settings'
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowFileExtensions
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

Write-Host 'Enable PIN and Windows Hello'
Set-ItemProperty HKLM:\SOFTWARE\Policies\Microsoft\Windows\System -name AllowDomainPINLogon -value 1

Write-Host 'Install SauceCodePro font'
$fontFileName = 'Sauce Code Pro Nerd Font Complete Mono Windows Compatible.ttf'
$fontFaceName = 'SauceCodePro NF Regular'
$faceName = 'SauceCodePro NF'
$fontUrl = 'https://github.com/haasosaurus/nerd-fonts/raw/2.0.0/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.ttf'

$fontUrl = 'https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.ttf'


$fontUrl = 'https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.ttf'

$fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)
$font = $fonts.Items() | ? Name -eq $fontFaceName
if (-not $font) {
    $fontFilePath = "$env:TEMP\$fontFileName"
    if (Test-Path $fontFilePath) { Remove-Item $fontFilePath }
    Invoke-WebRequest $fontUrl -OutFile $fontFilePath -UseBasicParsing
    $fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)
    $fonts.CopyHere($fontFilePath)
    Remove-Item $fontFilePath -Force
}

Write-Host 'Set console defaults'
Set-ItemProperty -Path 'HKCU:\Console' -Name 'FaceName' -Value $faceName -Type String -Force
Set-ItemProperty -Path 'HKCU:\Console' -Name 'FontSize' -Value 0x140000 -Type DWord -Force
Set-ItemProperty -Path 'HKCU:\Console' -Name 'ScreenBufferSize' -Value 0x270f0078 -Type DWord -Force
Set-ItemProperty -Path 'HKCU:\Console' -Name 'WindowSize' -Value 0x240078 -Type DWord -Force
Set-ItemProperty -Path 'HKCU:\Console' -Name 'QuickEdit' -Value 1 -Force

Write-Host 'Enable Windows Subsystems/Features'
#Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole, Microsoft-Hyper-V-All, Microsoft-Windows-Subsystem-Linux -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart

Write-Host 'Remove Windows Store Apps'
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
Get-AppxPackage *Solitaire* | Remove-AppxPackage
Get-AppxPackage *MixedReality* | Remove-AppxPackage
Get-AppxPackage *Microsoft3D* | Remove-AppxPackage
Get-AppxPackage *Print3D* | Remove-AppxPackage
Get-AppxPackage Windows.CBSPreview | Remove-AppxPackage
Get-AppxPackage *LinkedIn | Remove-AppxPackage
Get-AppxPackage *McAfeeSecurity | Remove-AppxPackage
Get-AppxPackage Microsoft.Office.Desktop | Remove-AppxPackage
Get-AppxPackage Microsoft.GetHelp | Remove-AppxPackage
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage
Get-AppxPackage RivetNetworks.SmartByte | Remove-AppxPackage

Write-Host 'Installing docker'
choco install docker-desktop -y
Get-ChildItem "$([Environment]::GetFolderPath('DesktopDirectory'))" | ? { $_.Name -eq 'Docker Desktop.lnk' } | Remove-Item

# Setup synced settings folder from One Drive
if (Test-Path "$env:APPDATA\Code\User") { Remove-Item "$env:APPDATA\Code\User" -Force -Recurse }
if (-Not (Test-Path "$env:APPDATA\Code")) { New-Item -Path "$env:APPDATA\Code" -ItemType Directory | Out-Null }
New-Item -Path "$env:APPDATA\Code\User" -ItemType SymbolicLink -Value "$env:USERPROFILE\OneDrive\Documents\Keep\Tools\Code\User" | Out-Null


# Setup synced .kube settings folder from One Drive
if (Test-Path "$env:USERPROFILE\.kube") { Remove-Item "$env:USERPROFILE\.kube" -Force -Recurse }
New-Item -Path "$env:USERPROFILE\.kube" -ItemType SymbolicLink -Value "$env:USERPROFILE\OneDrive\Documents\Keep\Linux\.kube" | Out-Null
[Environment]::SetEnvironmentVariable('KUBECONFIG', "$env:USERPROFILE\.kube\config;$env:USERPROFILE\.kube\configs\kube-config-sox-dev;", 'User')




# Synch aws config
if (Test-Path "$env:USERPROFILE\.aws") { Remove-Item "$env:USERPROFILE\.aws" -Force -Recurse }
New-Item -Path "$env:USERPROFILE\.aws" -ItemType SymbolicLink -Value "$env:USERPROFILE\OneDrive\Documents\Keep\Linux\.aws" | Out-Null


Write-Host 'Install updates'
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula

Enable-UAC

Write-Host "You should reboot to continue"
