# About this project

This is my personal boxstarter script

This is based on these projects

- Boxstarter [boxstarter.org](http://boxstarter.org)
- Chocolatey [chocolatey.org](http://chocolatey.org)
- Windows Dev Box setup (https://github.com/Microsoft/windows-dev-box-setup-scripts)

## How to run the scripts

Run the following script from a Window Powershell Admin prompt

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force;
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')
Invoke-Expression (New-Object Net.WebClient).DownloadString('https://github.com/RobCannon/boxstarter/raw/master/run_as_admin.ps1')
```

### Setup using scoop

From a powershell prompt, run these commands:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope Process -Force
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://github.com/RobCannon/boxstarter/raw/master/boxstarter.ps1')
```
