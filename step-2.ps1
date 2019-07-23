#--- Ubuntu ---
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile ~/Ubuntu.appx -UseBasicParsing
Add-AppxPackage -Path ~/Ubuntu.appx
Remove-Item ~/Ubuntu.appx

# utils
scoop install 7zip
scoop install git
[environment]::setenvironmentvariable('GIT_SSH', (resolve-path (scoop which ssh)), 'USER')

if ($env:HTTP_PROXY) {
    git config --global http.proxy $env:HTTP_PROXY
    git config --global https.proxy $env:HTTP_PROXY
}
git config --global credential.helper store


scoop bucket add extras
scoop bucket add versions
scoop pwsh
scoop posh-git

# scoop vscode
# # Add Explorer context menus for VS Code
# New-Item -Path 'HKCU:\Software\Classes\*\shell\Open with &Code\command' -Force | Out-Null
# Set-ItemProperty -Path 'HKCU:\Software\Classes\*\shell\Open with &Code' -Name '(Default)' -Value 'Open with &Code' -Force
# Set-ItemProperty -Path 'HKCU:\Software\Classes\*\shell\Open with &Code' -Name 'Icon' -Value "$env:USERPROFILE\scoop\apps\vscode\current\Code.exe" -Force
# Set-ItemProperty -Path 'HKCU:\Software\Classes\*\shell\Open with &Code\command' -Name '(Default)' -Value "$env:USERPROFILE\scoop\apps\vscode\current\Code.exe ""%1""" -Force

# New-Item -Path 'HKCU:\Software\Classes\Directory\shell\Open with &Code\command' -Force | Out-Null
# Set-ItemProperty -Path 'HKCU:\Software\Classes\Directory\shell\Open with &Code' -Name '(Default)' -Value 'Open with &Code' -Force
# Set-ItemProperty -Path 'HKCU:\Software\Classes\Directory\shell\Open with &Code' -Name 'Icon' -Value "$env:USERPROFILE\scoop\apps\vscode\current\Code.exe" -Force
# Set-ItemProperty -Path 'HKCU:\Software\Classes\Directory\shell\Open with &Code\command' -Name '(Default)' -Value "$env:USERPROFILE\scoop\apps\vscode\current\Code.exe ""%1""" -Force

# New-Item -Path 'HKCU:\Software\Classes\Directory\Background\shell\Open with &Code\command' -Force | Out-Null
# Set-ItemProperty -Path 'HKCU:\Software\Classes\Directory\Background\shell\Open with &Code' -Name '(Default)' -Value 'Open with &Code' -Force
# Set-ItemProperty -Path 'HKCU:\Software\Classes\Directory\Background\shell\Open with &Code' -Name 'Icon' -Value "$env:USERPROFILE\scoop\apps\vscode\current\Code.exe" -Force
# Set-ItemProperty -Path 'HKCU:\Software\Classes\Directory\Background\shell\Open with &Code\command' -Name '(Default)' -Value "$env:USERPROFILE\scoop\apps\vscode\current\Code.exe ""%1""" -Force

scoop install sudo

# programming languages
scoop install python
scoop install dotnet-sdk-lts
scoop install diffmerge
scoop install nodejs

if ($env:HTTP_PROXY) {
    npm config set proxy $env:HTTP_PROXY
    npm config set https-proxy $env:HTTP_PROXY
}

# cloud and infrastructure
scoop install azure-cli
scoop install aws
scoop install kubectl
scoop install helm
scoop install k9s
scoop install terraform
scoop install posh-docker


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
