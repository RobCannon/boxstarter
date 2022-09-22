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
Install-Module -Name PowerShellGet -RequiredVersion 3.0.17-beta17 -Force -AllowPrerelease -Scope AllUsers
wsl --update
exit
```


Start powershell core normally and run these commands
```
gh auth login
```

Then run these commands
```
function dtf { git.exe --git-dir=$HOME\.cfg --work-tree=$HOME $args }
git clone --bare "https://github.com/RobCannon/boxstarter.git" $HOME/.cfg
dtf config --local status.showUntrackedFiles no
dtf checkout -f main
dtf push --set-upstream origin main

. "$HOME\.local\bin\boxstarter.ps1"
exit
```