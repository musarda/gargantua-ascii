# Opens Gargantua in a fixed-size app window with no address bar.
$ErrorActionPreference = 'Stop'

# Window size (4:5, Instagram portrait)
$w = 540
$h = 675

Add-Type -AssemblyName System.Windows.Forms
$area = [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea
# Shift left from center (pixels) - increase to move further left, 0 for dead center
$shiftLeft = 290
$x = [int]($area.X + ($area.Width - $w) / 2 - $shiftLeft)
if ($x -lt $area.X) { $x = $area.X }
$y = [int]($area.Y + ($area.Height - $h) / 2)

$browser = @(
    "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
    "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
    "$env:LOCALAPPDATA\Google\Chrome\Application\chrome.exe",
    "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe",
    "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe"
) | Where-Object { $_ -and (Test-Path -LiteralPath $_) } | Select-Object -First 1

if (-not $browser) {
    Write-Host "Chrome or Edge not found. You can open gargantua.html in any browser manually." -ForegroundColor Yellow
    exit 1
}

$html = Join-Path $PSScriptRoot "gargantua.html"
$page = ([System.Uri]$html).AbsoluteUri

# Separate profile: wiped on every launch so the browser doesn't remember the old window position.
# Safety: only this single folder under LOCALAPPDATA is deleted; if LOCALAPPDATA is missing, nothing is deleted.
if (-not $env:LOCALAPPDATA -or -not (Test-Path -LiteralPath $env:LOCALAPPDATA)) {
    Write-Host "LOCALAPPDATA not found, aborting." -ForegroundColor Yellow
    exit 1
}
$profileDir = Join-Path $env:LOCALAPPDATA "gargantua-profile"
if (Test-Path -LiteralPath $profileDir) {
    Remove-Item -LiteralPath $profileDir -Recurse -Force -ErrorAction SilentlyContinue
}

Start-Process -FilePath $browser -ArgumentList @(
    "--app=$page",
    "--window-size=$w,$h",
    "--window-position=$x,$y",
    "--user-data-dir=`"$profileDir`"",
    "--no-first-run",
    "--no-default-browser-check"
)
