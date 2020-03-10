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
#Get-AppxPackage Windows.CBSPreview | Remove-AppxPackage
Get-AppxPackage *LinkedIn | Remove-AppxPackage
Get-AppxPackage *McAfeeSecurity | Remove-AppxPackage
Get-AppxPackage Microsoft.Office.Desktop | Remove-AppxPackage
Get-AppxPackage Microsoft.GetHelp | Remove-AppxPackage
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage
Get-AppxPackage RivetNetworks.SmartByte | Remove-AppxPackage

Write-Host "Trusting PSGallery" -ForegroundColor Yellow
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted


# Copy PowerShell profile
if (-not (Test-Path "$env:USERPROFILE/Documents/PowerShell")) { New-Item "$env:USERPROFILE/Documents/PowerShell" -ItemType Directory | Out-Null }
Invoke-WebRequest https://github.com/RobCannon/boxstarter/raw/master/profiles/Powershell/Microsoft.PowerShell_profile.ps1 -OutFile "$env:USERPROFILE/Documents/PowerShell/Microsoft.PowerShell_profile.ps1"
Invoke-WebRequest https://github.com/RobCannon/boxstarter/raw/master/profiles/Powershell/Microsoft.PowerShell_profile.ps1 -OutFile "$env:USERPROFILE/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1"


# Install Powershell modules
Write-Host "Installing PowerShell modules" -ForegroundColor Yellow
Install-Module -Name ImportExcel -Scope CurrentUser
Install-Module -Name SqlServer -Scope CurrentUser
# Install-Module -Name AWSPowerShell -Scope CurrentUser
# Install-Module -Name Azure -Scope CurrentUser
Install-Module -Name Pester -Scope CurrentUser -Force -SkipPublisherCheck
Install-Module -Name psake -Scope CurrentUser
Install-Module -Name posh-git -Scope CurrentUser
Install-Module -Name oh-my-posh -Scope CurrentUser


Write-Host 'File Explorer Settings'
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name Hidden -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name HideFileExt -Value 0
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2


Write-Host 'Set console defaults'
Set-ItemProperty -Path 'HKCU:\Console' -Name 'FontSize' -Value 0x140000 -Type DWord -Force
Set-ItemProperty -Path 'HKCU:\Console' -Name 'ScreenBufferSize' -Value 0x270f0078 -Type DWord -Force
Set-ItemProperty -Path 'HKCU:\Console' -Name 'WindowSize' -Value 0x240078 -Type DWord -Force
Set-ItemProperty -Path 'HKCU:\Console' -Name 'QuickEdit' -Value 1 -Force


choco install -y microsoft-windows-terminal
choco install -y vscode.portable
choco install -y 7zip

# Install Scoop
Invoke-Expression (New-Object Net.WebClient).DownloadString('https://get.scoop.sh')

# Sccop required packages
scoop install 7zip
scoop install git


# Configure Git
[environment]::setenvironmentvariable('GIT_SSH', (resolve-path (scoop which ssh)), 'USER')
git config --global credential.helper manager
git config --global user.name "Rob Cannon"
git config --global user.email "rob@cannonsoftware.com"
git config --global core.autocrlf false

scoop bucket add extras

scoop install ssh-agent-wsl

# programming languages
scoop install pwsh
scoop install python
scoop install diffmerge
scoop install nodejs

# cloud and infrastructure tools
scoop install terraform
scoop install packer
scoop install kubectl
scoop install python
scoop install azure-cli
scoop install diffmerge


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


code --install-extension abusaidm.html-snippets
code --install-extension angular.ng-template
code --install-extension austincummings.razor-plus
code --install-extension christian-kohler.npm-intellisense
code --install-extension christian-kohler.path-intellisense
code --install-extension CoenraadS.bracket-pair-colorizer
code --install-extension cssho.vscode-svgviewer
code --install-extension davidbabel.vscode-simpler-icons
code --install-extension deerawan.vscode-whitespacer
code --install-extension DotJoshJohnson.xml
code --install-extension DSKWRK.vscode-generate-getter-setter
code --install-extension EditorConfig.EditorConfig
code --install-extension eg2.tslint
code --install-extension eg2.vscode-npm-script
code --install-extension esbenp.prettier-vscode
code --install-extension formulahendry.auto-close-tag
code --install-extension formulahendry.auto-rename-tag
code --install-extension hookyqr.beautify
code --install-extension humao.rest-client
code --install-extension IBM.output-colorizer
code --install-extension jock.svg
code --install-extension mauve.terraform
code --install-extension mindginative.terraform-snippets
code --install-extension moppitz.vscode-extension-auto-import
code --install-extension ms-azure-devops.azure-pipelines
code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
code --install-extension ms-mssql.mssql
code --install-extension ms-python.python
code --install-extension ms-vscode.azure-account
code --install-extension ms-vscode.csharp
code --install-extension ms-vscode.PowerShell
code --install-extension ms-vscode.typescript-javascript-grammar
code --install-extension ms-vsts.team
code --install-extension msjsdiag.debugger-for-chrome
code --install-extension msjsdiag.debugger-for-edge
code --install-extension natewallace.angular2-inline
code --install-extension NoHomey.angular-io-code
code --install-extension PeterJausovec.vscode-docker
code --install-extension quicktype.quicktype
code --install-extension redhat.vscode-yaml
code --install-extension technosophos.vscode-helm
code --install-extension tyriar.shell-launcher
code --install-extension visualstudioexptteam.vscodeintellicode


npm install -g npm npm-check-updates rimraf typescript gulp @angular/cli 2>$null


function Add-Font {
    <#
        #requires -Version 2.0
        .SYNOPSIS
        This will install Windows fonts.

        .DESCRIPTION
        Requries Administrative privileges. Will copy fonts to Windows Fonts folder and register them.

        .PARAMETER Path
        May be either the path to a font file to install or the path to a folder containing font files to install.
        Valid file types are .fon, .fnt, .ttf,.ttc, .otf, .mmm, .pbf, and .pfm

        .EXAMPLE
        Add-Font -Path Value
        Will get all font files from provided folder and install them in Windows.

        .EXAMPLE
        Add-Font -Path Value
        Will install provided font in Windows.


    #>



    [CmdletBinding(DefaultParameterSetName = 'Directory')]
    Param(
        [Parameter(Mandatory = $false,
            ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True)]
        [Parameter(ParameterSetName = 'Directory')]
        [ValidateScript( { Test-Path $_ -PathType Container })]
        [System.String[]]
        $Path,

        [Parameter(Mandatory = $false,
            ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True)]
        [Parameter(ParameterSetName = 'File')]
        [ValidateScript( { Test-Path $_ -PathType Leaf })]
        [System.String]
        $FontFile
    )

    begin {
        Set-Variable Fonts -Value 0x14 -Option ReadOnly
        $fontRegistryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"

        $shell = New-Object -ComObject Shell.Application
        $folder = $shell.NameSpace($Fonts)
        $objfontFolder = $folder.self.Path
        #$copyOptions = 20
        $copyFlag = [string]::Format("{0:x}", 4 + 16)
        $copyFlag
    }

    process {
        switch ($PsCmdlet.ParameterSetName) {
            "Directory" {
                ForEach ($fontsFolder in $Path) {
                    Write-Log -Info -Message "Processing folder {$fontsFolder}"
                    $fontFiles = Get-ChildItem -Path $fontsFolder -File -Recurse -Include @("*.fon", "*.fnt", "*.ttf", "*.ttc", "*.otf", "*.mmm", "*.pbf", "*.pfm")
                }
            }
            "File" {
                $fontFiles = Get-ChildItem -Path $FontFile -Include @("*.fon", "*.fnt", "*.ttf", "*.ttc", "*.otf", "*.mmm", "*.pbf", "*.pfm")
            }
        }
        if ($fontFiles) {
            foreach ($item in $fontFiles) {
                Write-Host "Processing font file {$item}"
                if (Test-Path (Join-Path -Path $objfontFolder -ChildPath $item.Name)) {
                    Write-Host "Font {$($item.Name)} already exists in {$objfontFolder}"
                }
                else {
                    Write-Host "Font {$($item.Name)} does not exists in {$objfontFolder}"
                    Write-Host "Reading font {$($item.Name)} full name"

                    Add-Type -AssemblyName System.Drawing
                    $objFontCollection = New-Object System.Drawing.Text.PrivateFontCollection
                    $objFontCollection.AddFontFile($item.FullName)
                    $FontName = $objFontCollection.Families.Name

                    Write-Host "Font {$($item.Name)} full name is {$FontName}"
                    Write-Host "Copying font file {$($item.Name)} to system Folder {$objfontFolder}"
                    $folder.CopyHere($item.FullName, $copyFlag)

                    $regTest = Get-ItemProperty -Path $fontRegistryPath -Name "*$FontName*" -ErrorAction SilentlyContinue
                    if (-not ($regTest)) {
                        New-ItemProperty -Name $FontName -Path $fontRegistryPath -PropertyType string -Value $item.Name
                        Write-Host "Registering font {$($item.Name)} in registry with name {$FontName}"
                    }
                }
            }
        }
    }
    end {
    }
}

Write-Host 'Install SauceCodePro font'
$fontUrl = 'https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete%20Windows%20Compatible.ttf'
$fontFileName = 'Sauce Code Pro Nerd Font Complete Windows Compatible.ttf'
$fontFilePath = "$env:TEMP\$fontFileName"
Invoke-WebRequest $fontUrl -OutFile $fontFilePath -UseBasicParsing
Add-Font -FontFile $fontFilePath
Remove-Item $fontFilePath -Force

# Ensure SSH config exists so it can be linked to WSL
if (-Not (Test-Path $HOME\.ssh)) { New-Item $HOME\.ssh -ItemType Directory | Out-Null }

# Configure Kubernetes
$env:KUBECONFIG = "$env:USERPROFILE\.kube\config"
[Environment]::SetEnvironmentVariable('KUBECONFIG', $env:KUBECONFIG, 'User')


#--- Ubuntu ---
$env:WSLENV = 'USERPROFILE/l'
[environment]::setenvironmentvariable('WSLENV', $env:WSLENV, 'USER')
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile ~/Ubuntu.appx -UseBasicParsing
Add-AppxPackage -Path ~/Ubuntu.appx
ubuntu1804 install
wsl -d Ubuntu-18.04 -u root -- printf '[automount]\nroot = /\noptions = "metadata"' ^> /etc/wsl.conf
wsl -d Ubuntu-18.04 -- sh -c "`$(curl -fsSL https://github.com/RobCannon/boxstarter/raw/master/boxstarter.sh)"
Remove-Item ~/Ubuntu.appx
