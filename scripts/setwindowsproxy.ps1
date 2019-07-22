param (
    [Parameter(Mandatory = $true, HelpMessage = "Enter proxy password")]
    [ValidateNotNullorEmpty()]
    [SecureString]$Password
)

$credential = (New-Object PSCredential $env:USERNAME, $Password).GetNetworkCredential()

$proxyurl = "http://$($credential.UserName):$($credential.Password)@proxy-user.wip.us.equifax.com:18717"

[Environment]::SetEnvironmentVariable("HTTP_PROXY", $proxyurl, [EnvironmentVariableTarget]::Machine)