function Show-SimpleMenu ([array]$Options, [string]$Title = 'Choose an option', $border = '┌─┐│└┘', [int]$highlighted = 0) {
    $maxLength = [Math]::Max(($Options | Measure-Object -Max -Prop Length).Maximum, $Title.Length) #get longest option or title
    $MenuTop = [Console]::CursorTop
    Do {
        [Console]::CursorTop = $MenuTop
        $LeftPad = [string]$border[1] * [Math]::Max(0, [math]::Floor(($maxlength - $Title.Length) / 2)) #gets the left padding required to center the title
        Write-Host "$($border[0])$(($LeftPad + $Title).PadRight($maxLength,$border[1]))$($border[2])" # #top border: ┌Title─┐   left-aligned: Write-Host "$($border[0])$($Title.PadRight($maxLength,$border[1]))$($border[2])" 
        for ($i = 0; $i -lt $Options.Length; $i++) {
            Write-Host $border[3] -NoNewLine 
            if ($i -eq $highlighted) {
                Write-Host ([string]$Options[$i]).PadRight($maxLength, ' ') -fore ([Console]::BackgroundColor) -back ([Console]::ForegroundColor) -NoNewline
            }
            else {
                Write-Host ([string]$Options[$i]).PadRight($maxLength, ' ') -NoNewline 
            }
            Write-Host $border[3]
        }
        Write-Host "$($border[4])$([string]$border[1] * $maxLength)$($border[5])" #bottom border:└─┘
        $key = [Console]::ReadKey($true)
        If ($key.Key -eq [ConsoleKey]::UpArrow -and $highlighted -gt 0 ) { $highlighted-- }
        ElseIf ($key.Key -eq [ConsoleKey]::DownArrow -and $highlighted -lt $Options.Length - 1) { $highlighted++ }
        ElseIf ( (1..9 -join '').contains($key.KeyChar) -and $Options.Length -ge [int]::Parse($key.KeyChar)) { $highlighted = [int]::Parse($key.KeyChar) - 1 }#change highlight with 1..9 
        Else { 
            (([math]::min($highlighted + 1, $Options.Length) .. $Options.Length) + (0 .. ($highlighted - 1))) | % { #cycle from highlighted + 1 to end, and restart
                If ($Options[$_] -and $Options[$_].StartsWith($key.KeyChar) ) { $highlighted = $_; Continue } #if letter matches first letter, highlight 
            }
        }
    }While ( -not ([ConsoleKey]::Enter, [ConsoleKey]::Escape).Contains($key.Key) )
    If ($Key.Key -eq [ConsoleKey]::Enter) { $Options[$highlighted] }
}

$profiles = Get-Content "~/.aws/config" | Where-Object { $_ -match '^\[profile\s+(\S+)\]' } | ForEach-Object { $matches[1] } | Sort-Object { $_ }
wsl.exe -u root -- hwclock -s

$selected_profile = Show-SimpleMenu $profiles 'Select AWS Profile'

$env:AWS_PROFILE = $selected_profile
[environment]::setenvironmentvariable('AWS_PROFILE', $env:AWS_PROFILE, 'USER')

aws sso login

$clusters = aws eks list-clusters --output json | ConvertFrom-Json | ForEach-Object { $_.clusters } | Sort-Object { $_ }

if ($clusters) {
    if ($clusters.Count -eq 1) {
        $selected_cluster = $clusters
    }
    else {
        $selected_cluster = Show-SimpleMenu $clusters 'Select a Kubernetes Cluster'
    }
    aws eks update-kubeconfig --region us-east-2 --name $selected_cluster --alias $selected_cluster
}

