# Inspired by https://github.com/Microsoft/windows-dev-box-setup-scripts

Disable-UAC

#--- Ubuntu ---
#Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile ~/Ubuntu.appx -UseBasicParsing
#Add-AppxPackage -Path ~/Ubuntu.appx
#Remove-Item ~/Ubuntu.appx

#--- Browsers ---
Get-ChildItem "$([Environment]::GetFolderPath('DesktopDirectory'))" | ? { $_.Name -eq 'Microsoft Edge.lnk' } | Remove-Item
choco install -y Googlechrome
Get-ChildItem "$([Environment]::GetFolderPath('DesktopDirectory'))" | ? { $_.Name -eq 'Google Chrome.lnk' } | Remove-Item
choco install -y lastpass --ignore-checksums

#--- Tools ---
choco install -y sql-server-management-studio
choco install -y git -params '"/NoShellIntegration /NoAutoCrlf /WindowsTerminal /SChannel"'
choco install -y 7zip.install
choco install -y rsat
choco install -y sysinternals
choco install -y cmder
Copy-Item "$($env:USERPROFILE)\OneDrive\Documents\Keep\Tools\Cmder\ConEmu.xml" "C:\tools\cmder\vendor\conemu-maximus5\ConEmu.xml" -Force | Out-Null
choco install -y DiffMerge --allow-empty-checksums
Get-ChildItem "$([Environment]::GetFolderPath('CommonDesktopDirectory'))" | ? { $_.Name -eq 'DiffMerge.lnk' } | Remove-Item
choco install -y dotnetcore-sdk
choco install -y nodejs # Node.js Current, Latest features
choco install -y docker-for-windows
Get-ChildItem "$([Environment]::GetFolderPath('DesktopDirectory'))" | ? { $_.Name -eq 'Docker for Windows.lnk' } | Remove-Item
choco install -y python
Update-SessionEnvironment
python -m pip install --upgrade pip


# Setup synced .kube settings folder from One Drive
if (Test-Path "$env:USERPROFILE\.kube") { Remove-Item "$env:USERPROFILE\.kube" -Force -Recurse }
New-Item -Path "$env:USERPROFILE\.kube" -ItemType SymbolicLink -Value "$env:USERPROFILE\OneDrive\Documents\Keep\Linux\.kube" | Out-Null
[Environment]::SetEnvironmentVariable('KUBECONFIG', "$env:USERPROFILE\.kube\config;$env:USERPROFILE\.kube\configs\kube-config-sox-dev;", 'User')

choco install -y mongodb.install
Get-ChildItem "$([Environment]::GetFolderPath('DesktopDirectory'))" | ? { $_.Name -eq 'MongoDB Compass Community.lnk' } | Remove-Item

#--- Cloud CLI Tools ---
choco install -y kubernetes-cli
choco install -y terraform
choco install -y awscli
choco install -y azure-cli

# Support for Turner logins to AWS using samld
if (Test-Path "$env:USERPROFILE\.aws") { Remove-Item "$env:USERPROFILE\.aws" -Force -Recurse }
New-Item -Path "$env:USERPROFILE\.aws" -ItemType SymbolicLink -Value "$env:USERPROFILE\OneDrive\Documents\Keep\Linux\.aws" | Out-Null
[Environment]::SetEnvironmentVariable('ADFS_DOMAIN', 'TURNER', 'User')
[Environment]::SetEnvironmentVariable('ADFS_URL', 'https://sts.turner.com/adfs/ls/IdpInitiatedSignOn.aspx?loginToRp=urn:amazon:webservices', 'User')
pip install samlkeygen

#--- VS Code ---
choco install -y vscode
Update-SessionEnvironment
Get-ChildItem "$([Environment]::GetFolderPath('CommonDesktopDirectory'))" | ? { $_.Name -eq 'Visual Studio Code.lnk' } | Remove-Item

# Setup synced settings folder from One Drive
if (Test-Path "$env:APPDATA\Code\User") { Remove-Item "$env:APPDATA\Code\User" -Force -Recurse }
New-Item -Path "$env:APPDATA\Code\User" -ItemType SymbolicLink -Value "$env:USERPROFILE\OneDrive\Documents\Keep\Tools\Code\User" | Out-Null

code --install-extension abusaidm.html-snippets
code --install-extension austincummings.razor-plus
code --install-extension christian-kohler.npm-intellisense
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
code --install-extension humao.rest-client
code --install-extension IBM.output-colorizer
code --install-extension jock.svg
code --install-extension mauve.terraform
code --install-extension Microsoft.vsce
code --install-extension mindginative.terraform-snippets
code --install-extension moppitz.vscode-extension-auto-import
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
code --install-extension NoHomey.angular-io-code
code --install-extension PeterJausovec.vscode-docker
code --install-extension quicktype.quicktype
code --install-extension technosophos.vscode-helm

#--- Visual Studio ---
choco install -y visualstudio2017enterprise
choco install -y visualstudio2017buildtools
choco install -y visualstudio2017-workload-netweb
choco install -y visualstudio2017-workload-webbuildtools
choco install -y visualstudio2017-workload-netcoretools


#--- Applications ---
choco install -y steam --allowEmptyCheckSum
Get-ChildItem "$([Environment]::GetFolderPath('CommonDesktopDirectory'))" | ? { $_.Name -eq 'Steam.lnk' } | Remove-Item
Remove-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Run -Name 'Steam' -ErrorAction SilentlyContinue
choco install adobereader -y --allow-empty-checksums
Get-ChildItem "$([Environment]::GetFolderPath('CommonDesktopDirectory'))" | ? { $_.Name -eq 'Acrobat Reader DC.lnk' } | Remove-Item

npm install -g npm npm-check-updates rimraf typescript@2.7.2 gulp @angular/cli 2>$null


function EnsurePath {
    param
    (
        [Parameter(Mandatory = $true)]
        [string] $Path
    )

    if (-not (Test-Path $Path)) { New-Item -ItemType Directory -Path $Path | Out-Null }
}


EnsurePath c:\Projects
EnsurePath c:\Projects\RobCannon
EnsurePath c:\Projects\GitHub
EnsurePath c:\Projects\BuildServers
EnsurePath c:\Projects\Foundation
EnsurePath c:\Projects\PowerShellModules
EnsurePath c:\Projects\Servers
EnsurePath c:\Projects\TechOps

& "$($env:USERPROFILE)\OneDrive\Documents\Keep\Tools\VSTeam\InitProjects.ps1"

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
