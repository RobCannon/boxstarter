param (
    [Parameter(Mandatory = $true, HelpMessage = "Enter proxy password")]
    [ValidateNotNullorEmpty()]
    [SecureString]$Password
)

$credential = (New-Object PSCredential $env:USERNAME, $Password).GetNetworkCredential()

$proxyurl = "http://$($credential.UserName):$($credential.Password)@proxy-user.wip.us.equifax.com:18717"

$filePath = Join-Path $env:TEMP '.proxy'

if (Test-Path $filePath) { Remove-Item $filePath }

"HTTP_PROXY=$proxyUrl`nHTTPS_PROXY=$proxyUrl" | Set-Content $filePath

$linuxPath = $filePath.Replace('\', '/').Replace('C:', '/c')
$linuxCommand = "echo cp $linuxPath ~/.proxy"

$linuxCommand
Start-Process -FilePath "$env:SystemRoot\system32\wsl.exe" -ArgumentList "--exec", $linuxCommand -Wait -NoNewWindow

#Remove-Item $filePath
