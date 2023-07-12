Install-Module -Name Microsoft.WinGet.Client
Get-WinGetPackage
    | Where-Object {$_.IsUpdateAvailable}
    #| Where-Object {$_.Id -notlike "TechSmith*"} # You can filter out packages you don't want to update
    | Update-WinGetPackage