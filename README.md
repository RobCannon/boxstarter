# Windows and WSL BoxStarter

To get started, open Microsoft Store and ensure that all packages are updates.  This is needed to get the latest version of winget.

Run these command from a Terminal (Admin).  Use WinKey-X
```
Invoke-WebRequest -Uri https://github.com/RobCannon/boxstarter/raw/main/.config/dsc/admin.dsc.yaml -OutFile .\admin.dsc.yaml
winget configure --file .\admin.dsc.yaml --accept-configuration-agreements
Remove-Item .\admin.dsc.yaml
exit
```

Run these command from a Terminal.  Use WinKey-X.
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

Rob's Preferences
```
Invoke-WebRequest -Uri https://github.com/RobCannon/boxstarter/raw/main/.config/dsc/personalize.dsc.yaml -OutFile .\personalize.dsc.yaml
winget configure --file .\personalize.dsc.yaml --accept-configuration-agreements
Remove-Item .\personalize.dsc.yaml
exit
```
