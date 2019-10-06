# About this project

This is my personal boxstarter script

This is based on these projects

- Boxstarter [boxstarter.org](http://boxstarter.org)
- Chocolatey [chocolatey.org](http://chocolatey.org)
- Windows Dev Box setup (https://github.com/Microsoft/windows-dev-box-setup-scripts)

## How to run the scripts

To run a setup script, click a link in the table below from your target machine. This will download Boxstarter, and prompt you for Boxstarter to run with Administrator privileges (which it needs to do its job). Clicking yes in this dialog will cause the script to begin. You can then leave the job unattended and come back when it's finished.

| Click link to run                                                                                                       |
| ----------------------------------------------------------------------------------------------------------------------- |
| <a href='http://boxstarter.org/package/nr/url?https://github.com/RobCannon/boxstarter/raw/master/step-1.ps1'>Step 1</a> |

### Setup using scoop

From a powershell prompt, run these commands:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope Process -Force
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
iex (new-object net.webclient).downloadstring('https://github.com/RobCannon/boxstarter/raw/master/step-2.ps1')
```

#### Setup up WSL via curl

From the wsl command prompt

First, change the mount point in WSL to /c instead of /mnt/c for shared drives [fixes docker in WSL](https://nickjanetakis.com/blog/setting-up-docker-for-windows-and-wsl-to-work-flawlessly)

```powershell
ubuntu1804 install
wsl -d Ubuntu-18.04 -u root -- printf '[automount]\nroot = /\noptions = "metadata"' ^> /etc/wsl.conf
wsl -d Ubuntu-18.04 -- sh -c "$(curl -fsSL https://github.com/RobCannon/boxstarter/raw/master/boxstarter.sh)"
```

Second, exit and restart WSL and run this script

```shell

```
