param (
    [Parameter(Mandatory = $true, HelpMessage = "Enter proxy password")]
    [ValidateNotNullorEmpty()]
    [SecureString]$Password
)

$credential = (New-Object PSCredential $env:USERNAME, $Password).GetNetworkCredential()

$proxyurl = "http://$($credential.UserName):$($credential.Password)@proxy-user.wip.us.equifax.com:18717"
# $proxyurl = "http://$($credential.UserName):$($credential.Password)@ep.threatpulse.net:80"

$env:HTTP_PROXY = $proxyurl
$env:HTTPS_PROXY = $proxyurl
$env:HTTP_PROXY = $proxyurl
$env:NO_PROXY = '.equifax.com'
$env:WSLENV = 'HTTP_PROXY/u:HTTPS_PROXY/u:NO_PROXY/u'

[Environment]::SetEnvironmentVariable('HTTP_PROXY', $env:HTTP_PROXY, [EnvironmentVariableTarget]::User)
[Environment]::SetEnvironmentVariable('HTTPS_PROXY', $env:HTTPS_PROXY, [EnvironmentVariableTarget]::User)
[Environment]::SetEnvironmentVariable('NO_PROXY', $env:NO_PROXY, [EnvironmentVariableTarget]::User)
[Environment]::SetEnvironmentVariable('WSLENV', $env:WSLENV, [EnvironmentVariableTarget]::User)

# curl -L https://update.code.visualstudio.com/commit:2213894ea0415ee8c85c5eea0d0ff81ecc191529/server-linux-x64/stable -o test