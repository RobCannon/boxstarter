# Windows and WSL BoxStarter

To get started, open Microsoft Store and ensure that all packages are updates.  This is needed to get the latest version of winget.

Run these command from a Terminal (Admin).  Use WinKey-X
```
Invoke-WebRequest -Uri https://github.com/RobCannon/boxstarter/raw/main/.config/dsc/admin.dsc.yaml -OutFile .\admin.dsc.yaml
winget configure --file .\admin.dsc.yaml --accept-configuration-agreements
Remove-Item .\admin.dsc.yaml
exit
```

Run these command from a Terminal.  Use WinKey-X.  This will install several packages that will trigger an Admin prompt.  Those
prompts do not seem to pop-up over the Terminal windows, so be on the lookout for them. Progress will pause until they Admin escalation is approved.
```
Invoke-WebRequest -Uri https://github.com/RobCannon/boxstarter/raw/main/.config/dsc/configuration.dsc.yaml -OutFile .\configuration.dsc.yaml
winget configure --file .\configuration.dsc.yaml --accept-configuration-agreements
Remove-Item .\configuration.dsc.yaml

Invoke-WebRequest -Uri https://github.com/RobCannon/boxstarter/raw/main/.config/dsc/personalize.dsc.yaml -OutFile .\personalize.dsc.yaml
winget configure --file .\personalize.dsc.yaml --accept-configuration-agreements
Remove-Item .\personalize.dsc.yaml
exit
```

Start another Terminal session
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


