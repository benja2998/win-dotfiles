Set-Alias -Name vim -Value nvim
Set-Alias -Name sudo -Value gsudo

function sudo.ti {
    sudo --ti
}

function sudo.system {
    sudo -s
}

function df {
    Get-PSDrive -PSProvider FileSystem | ForEach-Object {
        $used = $_.Used
        $free = $_.Free
        $total = $used + $free
        [PSCustomObject]@{
            Filesystem   = $_.Name
            SizeGB       = [math]::Round($total / 1GB, 2)
            UsedGB       = [math]::Round($used / 1GB, 2)
            AvailableGB  = [math]::Round($free / 1GB, 2)
            'Use%'       = [math]::Round(($used / $total) * 100, 0)
            MountedOn    = $_.Root
        }
    }
}

function free {
    $os = Get-CimInstance Win32_OperatingSystem
    $total = $os.TotalVisibleMemorySize / 1MB
    $free = $os.FreePhysicalMemory / 1MB
    $used = $total - $free

    [PSCustomObject]@{
        Total = "{0:N2} GB" -f $total
        Used  = "{0:N2} GB" -f $used
        Free  = "{0:N2} GB" -f $free
    }
}

Import-Module "gsudoModule"

# Check if the session is running as admin
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

function prompt {
    # ANSI escape sequences
    $green = "`e[32m"
    $blue  = "`e[34m"
    $red   = "`e[31m"
    $yellow = "`e[33m"
    $reset = "`e[0m"

    # User and host
    $user = $env:USERNAME
    $hostName = $env:COMPUTERNAME
    $pwd = (Get-Location).Path

    if ($pwd.StartsWith($home)) {
        $pwd = "~" + $pwd.Substring($home.Length)
    }

    # Exit code coloring
    if ($LASTEXITCODE -eq 0) {
        $exit = "$yellow[$LASTEXITCODE]$reset"
    } else {
        $exit = "$red[$LASTEXITCODE]$reset"
    }

    # Compose prompt
    if ($IsAdmin) {
        return "$exit $red$user$reset@$hostName $pwd # "
    } else {
        return "$exit $green$user@$hostName$reset $blue$pwd$reset $ "
    }
}

Invoke-Expression (& { (zoxide init powershell | Out-String) })
