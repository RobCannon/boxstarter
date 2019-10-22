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
$fontUrl = 'https://github.com/haasosaurus/nerd-fonts/raw/regen-mono-font-fix/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.ttf'

#$fontUrl = 'https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.ttf'

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


Write-Host 'Installing docker'
choco install docker-desktop -y
Get-ChildItem "$([Environment]::GetFolderPath('DesktopDirectory'))" | ? { $_.Name -eq 'Docker Desktop.lnk' } | Remove-Item

Write-Host 'Install updates'
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula

Enable-UAC

Write-Host "You should reboot to continue"
