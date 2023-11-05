# Windows and WSL BoxStarter

To get started, from Windows PowerShell (WindowsKey-X and select Terminal), install pwsh, wsl, git and gh command lines.  Your computer will restart when this is complete.
```
winget install -e --id Microsoft.PowerShell --accept-package-agreements
winget install -e --id Microsoft.WindowsTerminal --accept-package-agreements
winget install -e --id MicrosoftCorporationII.WindowsSubsystemForLinux --accept-package-agreements
winget install -e --id Git.Git --accept-package-agreements
winget install -e --id GitHub.cli --accept-package-agreements
restart-computer -Force
```

Reboot

Start powershell core prompt as an Admin
```
wsl --update
exit
```


Start powershell core normally and run these commands
```
gh auth login
```

Then run these commands
```
$GitHubProfile = Get-Content "$($env:APPDATA)/GitHub CLI/hosts.yml" | ?{ $_ -match 'user:' } | %{ $_ -replace '\s+user:\s+','' }
function dotfiles { git.exe --git-dir=$HOME\.cfg --work-tree=$HOME $args }
git clone --bare "https://github.com/$GitHubProfile/boxstarter.git" $HOME/.cfg
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout -f main
dotfiles push --set-upstream origin main

. "$HOME\.local\bin\boxstarter.ps1"
exit
```


```
Invoke-WebRequest -Uri https://github.com/RobCannon/boxstarter/raw/main/configuration.dsc.yaml -OutFile ~/configuration.dsc.yaml
```
