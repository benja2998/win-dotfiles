# Warn the user
Write-Host "This will override your current PowerShell profile with a symlink."
Write-Host "Press Ctrl + C within 5 seconds if you do not want this to happen."
Start-Sleep -Seconds 5

# Get the PowerShell profile path dynamically
$PSProfilePath = $PROFILE

# Make sure the destination folder exists
$profileDir = Split-Path $PSProfilePath
if (-not (Test-Path $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
}

# Remove existing profile if it exists
if (Test-Path $PSProfilePath) {
    Remove-Item $PSProfilePath -Force
}

# Get the full path of the source profile script
$ScriptPath = $PSScriptRoot + "\Microsoft.PowerShell_profile.ps1"

# Function to check if running as administrator
function Test-IsAdmin {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Try to create the symlink
try {
    New-Item -ItemType SymbolicLink -Path $PSProfilePath -Target $ScriptPath -Force
    Write-Host "Symlink created at $PSProfilePath → $ScriptPath"
} catch {
    # If it fails and we're not admin, elevate
    if (-not (Test-IsAdmin)) {
        Write-Host "Elevation required. Restarting with admin privileges..."
        Start-Process powershell "-File `"$PSCommandPath`"" -Verb RunAs
        exit
    } else {
        Write-Error "Failed to create symlink even with admin privileges."
    }
}
