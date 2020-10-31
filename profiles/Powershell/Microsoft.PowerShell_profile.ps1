Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Paradox
function startdevelop { Start-azvm -ResourceGroupName CannonSoftware -Name develop }
# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
