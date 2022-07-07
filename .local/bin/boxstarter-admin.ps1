
# Install Powershell modules
Write-Host "Installing PowerShellGet 3.x" -ForegroundColor Yellow
Install-Module -Name PowerShellGet -RequiredVersion 3.0.14-beta14 -Force -AllowPrerelease -Scope AllUsers
Set-PSResourceRepository -Name PSGallery -Trusted

wsl -update