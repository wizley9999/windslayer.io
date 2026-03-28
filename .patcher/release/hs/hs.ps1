$ErrorActionPreference = "Stop"

$PATCHER_VERSION = "__PATCHER_VERSION__"
$REPO_API        = "https://api.github.com/repos/wizley9999/windslayer-guide/releases/latest"

function Fail($msg) {
    Write-Host ""
    Write-Host "ERROR: $msg" -ForegroundColor Red

    exit 1
}

try {
    # --- Update check ---
    Write-Host "Checking for updates..."

    try {
        $response  = Invoke-RestMethod -Uri $REPO_API -UseBasicParsing -ErrorAction Stop
        $latestTag = $response.tag_name
        $latestVer = $latestTag.TrimStart('v')

        if ([int64]$latestVer -gt [int64]$PATCHER_VERSION) {
            Write-Host ""
            Write-Host "A newer version of the patcher is available." -ForegroundColor Yellow
            Write-Host "  Current version : v$PATCHER_VERSION"
            Write-Host "  Latest version  : $latestTag"
            Write-Host ""
            Write-Host "Download the latest patcher from:" -ForegroundColor Cyan
            Write-Host "  $($response.html_url)" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "Patching has been cancelled. Please use the latest version." -ForegroundColor Red

            exit 1
        }

        Write-Host "Patcher is up to date (v$PATCHER_VERSION)."
    }
    catch {
        Write-Host "Could not check for updates (no internet?). Proceeding..." -ForegroundColor Yellow
    }

    # --- Game detection ---
    function Get-ProtocolCommand {
        param (
            [Microsoft.Win32.RegistryView]$View
        )

        try {
            $baseKey = [Microsoft.Win32.RegistryKey]::OpenBaseKey(
                [Microsoft.Win32.RegistryHive]::ClassesRoot,
                $View
            )

            $subKey = $baseKey.OpenSubKey("windslayer\shell\open\command")

            if ($subKey -ne $null) {
                return $subKey.GetValue("")
            }
        }
        catch { }

        return $null
    }

    Write-Host "Searching for WindSlayer..."

    $command = Get-ProtocolCommand -View Registry64

    if (-not $command) {
        $command = Get-ProtocolCommand -View Registry32
    }

    if (-not $command) {
        Fail "windslayer protocol not found in registry."
    }

    Write-Host "Protocol found."

    if ($command -match '"([^"]+)"') {
        $exePath = $Matches[1]
    }
    else {
        $exePath = ($command -split ' ')[0].Trim('"')
    }

    if (-not (Test-Path $exePath)) {
        Fail "Executable not found: $exePath"
    }

    Write-Host "Executable: $exePath"

    $baseDir = Split-Path $exePath
    $hsDir   = Join-Path $baseDir "hs"

    if (-not (Test-Path $hsDir)) {
        Fail "hs folder not found: $hsDir"
    }

    Write-Host "hs folder: $hsDir"

    $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

    $FILES = @(
        "UILngKo.lng",
        "QSTLngKo.lng",
        "NPCLngKo.lng",
        "MapLngKo.lng",
        "ITMLngKo.lng",
        "windslayer.hpt",
        "windslayer.bct"
    )

    foreach ($file in $FILES) {
        $source = Join-Path $scriptDir $file
        $dest   = Join-Path $hsDir $file

        if (Test-Path $source) {
            Copy-Item $source $dest -Force
            Write-Host "Copied: $file"
        }
    }

    Write-Host ""
    Write-Host "Patch applied successfully." -ForegroundColor Green

    exit 0
}
catch {
    Fail $_.Exception.Message
}
