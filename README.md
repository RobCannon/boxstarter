# Windows and WSL BoxStarter

To get started, from Windows PowerShell, install pwsh, git and gh command lines
```
winget install -e --id Microsoft.PowerShell
winget install -e --id Microsoft.WindowsTerminal
winget install -e --id Git.Git
winget install -e --id GitHub.cli
exit
```

Start powershell core prompt as an Admin
```
Install-Module -Name PowerShellGet -RequiredVersion 3.0.18-beta18 -Force -AllowPrerelease -Scope AllUsers
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