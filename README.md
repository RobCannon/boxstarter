# About this project

This is my personal boxstarter script

This is based on these projects

- Boxstarter [boxstarter.org](http://boxstarter.org)
- Chocolatey [chocolatey.org](http://chocolatey.org)
- Windows Dev Box setup (https://github.com/Microsoft/windows-dev-box-setup-scripts)

### Administrative setup

From a Administrative PowerShell prompt, run these commands:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
iex (new-object net.webclient).downloadstring('https://github.com/RobCannon/boxstarter/raw/master/run_as_admin.ps1')
```


### User setup

From am unelvated PowerShell prompt, run these commands:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
iex (new-object net.webclient).downloadstring('https://github.com/RobCannon/boxstarter/raw/master/boxstarter.ps1')
```
