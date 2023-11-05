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


Run these command from a Terminal (Admin).  Use WinKey-X
```
Invoke-WebRequest -Uri https://github.com/RobCannon/boxstarter/raw/main/admin.dsc.yaml -OutFile ~\admin.dsc.yaml
winget configure --file ~\admin.dsc.yaml --accept-configuration-agreements 
```

Run these command from a Terminal.  Use WinKey-X.  This will install several packages that will trigger an Admin prompt.  Those
prompts do not seem to pop-up over the Terminal windows, so be on the lookout for them. Progress will pause until they Admin escalation is approved.
```
Invoke-WebRequest -Uri https://github.com/RobCannon/boxstarter/raw/main/configuration.dsc.yaml -OutFile ~\configuration.dsc.yaml
winget configure --file ~\personalize.dsc.yaml --accept-configuration-agreements 
```
