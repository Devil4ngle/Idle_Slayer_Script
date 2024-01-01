$ErrorActionPreference = "Stop"
$url = "https://api.github.com/repos/Devil4ngle/Idle_Slayer_Script/releases/latest"

# Check system architecture
if ([Environment]::Is64BitOperatingSystem) {
    $file = "Idle.Runner_x64.exe"
} else {
    $file = "Idle.Runner_x32.exe"
}

Start-Sleep -Seconds 1

# Remove the old file
if (Test-Path $file) {
    Remove-Item -Path $file -Force
}

# Download the latest release
$response = Invoke-RestMethod -Uri $url
$downloadUrl = $response.assets | Where-Object { $_.name -eq $file } | Select-Object -ExpandProperty browser_download_url

Invoke-WebRequest -Uri $downloadUrl -OutFile $file

Start-Process -FilePath $file

