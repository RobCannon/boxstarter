# Jump out if run from a script
# if ($PSScriptRoot) {
#   return
# }

function dotfiles { git.exe --git-dir=$HOME\.cfg --work-tree=$HOME $args }
function Select-AWSProfile { & "$HOME\.local\bin\select-awsprofile.ps1" }

oh-my-posh init pwsh --config $HOME/.config/oh-my-posh/my-posh.json -s | Invoke-Expression

Import-Module PSReadLine
# Set-PSReadLineOption -PredictionSource History
# Set-PSReadLineOption -PredictionViewStyle ListView

# Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
# Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
# Set-PSReadLineOption -HistorySearchCursorMovesToEnd
# Set-PSReadLineOption -EditMode Emacs