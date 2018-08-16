# About this project

This is my personal boxstarter script

This is based on these projects

- Boxstarter [boxstarter.org](http://boxstarter.org)
- Chocolatey [chocolatey.org](http://chocolatey.org)
- Windows Dev Box setup (https://github.com/Microsoft/windows-dev-box-setup-scripts)

## How to run the scripts

To run a setup script, click a link in the table below from your target machine. This will download Boxstarter, and prompt you for Boxstarter to run with Administrator privileges (which it needs to do its job). Clicking yes in this dialog will cause the script to begin. You can then leave the job unattended and come back when it's finished.

| Click link to run                                                                                                                  |
| ---------------------------------------------------------------------------------------------------------------------------------- |
| <a href='http://boxstarter.org/package/nr/url?https://raw.githubusercontent.com/RobCannon/boxstarter/master/step-1.ps1'>Step 1</a> |
| <a href='http://boxstarter.org/package/nr/url?https://raw.githubusercontent.com/RobCannon/boxstarter/master/step-2.ps1'>Step 2</a> |

#### Setup up WSL via curl

First, change the mount point in WSL to /c instead of /mnt/c for shared drives [fixes docker in WSL](https://nickjanetakis.com/blog/setting-up-docker-for-windows-and-wsl-to-work-flawlessly)

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/RobCannon/boxstarter/master/changemount.sh)"
```

Second, exit and restart WSL and run this script

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/RobCannon/boxstarter/master/boxstarter.sh)"
```
