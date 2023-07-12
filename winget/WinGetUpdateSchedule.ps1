# Note: This script must be run as admin if "-RunLevel Highest" is present

# TODO replace with the actual path to the script
$ScriptPath=(Resolve-Path (Join-Path $PSScriptRoot "WinGetUpdate.ps1")).Path
Write-Host "Script path: $ScriptPath"

$WinGet = "$env:LOCALAPPDATA\Microsoft\WindowsApps\winget.exe"
$Pwsh = (Get-Command pwsh).Source

$Time = New-ScheduledTaskTrigger -At 04:00 -Daily
$Actions = @(
    # Update all sources, so that winget can find the latest version of the packages
    New-ScheduledTaskAction -Execute "$WinGet" -Argument "source update"
    New-ScheduledTaskAction -Execute "$Pwsh" -Argument "`"$ScriptPath`"}`""
)

$Settings = New-ScheduledTaskSettingsSet -WakeToRun:$false `
                                        -MultipleInstances IgnoreNew `
                                        -RunOnlyIfNetworkAvailable:$true `
                                        -StartWhenAvailable:$true
Register-ScheduledTask -TaskName "Update winget" -TaskPath Updates `
                       -Trigger $Time -Action $Actions -Settings $Settings `
                       -RunLevel Highest # Remove this one if you don't want to run the task as admin