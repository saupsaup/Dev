[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)] [string] $ProjectDir,
    [Parameter(Mandatory = $true)] [string] $MosaicBin,
    [Parameter(Mandatory = $true)] [string] $Target,
    [switch] $AutoRun
)

$ErrorActionPreference = 'Stop'

# 1) Nájdeme TTR cestu – ideálne z 200.pckg (obsahuje presnú cestu), inak najnovší *.ttr
$pckg = Join-Path -Path $ProjectDir -ChildPath '200.pckg'
$ttr = $null
if (Test-Path -LiteralPath $pckg) {
    $raw = (Get-Content -Raw -LiteralPath $pckg).Trim()
    if ($raw -match "'([^']+\.TTR)'" -or $raw -match '"([^"]+\.TTR)"') {
        $ttr = $Matches[1]
    } else {
        $ttr = $raw.Trim('"', "'")
    }
}
if (-not $ttr -or -not (Test-Path -LiteralPath $ttr)) {
    $cand = Get-ChildItem -Path $ProjectDir -Include *.ttr -Recurse -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 1
    if ($cand) { $ttr = $cand.FullName }
}
if (-not $ttr -or -not (Test-Path -LiteralPath $ttr)) {
    throw "TTR package not found (checked 200.pckg and *.ttr)"
}

# 2) Cesty k VSC2m/Mosaic
$exe = Join-Path -Path $MosaicBin -ChildPath 'VSC2m.exe'
if (!(Test-Path -LiteralPath $exe)) { throw "VSC2m not found: $exe" }

Write-Host "Uploading via VSC2m:"
Write-Host "  Target : $Target"
Write-Host "  Package: $ttr"
Write-Host "  Exe    : $exe"

# 3) Upload priamo cez VSC2m
#    Príkazová skladba: VSC2m.exe <target> upload-ttr "<path-to-ttr>" [--autorun]
$arguments = @($Target, 'upload-ttr', $ttr)
if ($AutoRun) { $arguments += '--autorun' }

& $exe @arguments
$exit = $LASTEXITCODE
if ($exit -ne 0) { throw "VSC2m upload failed (exit $exit)" }

Write-Host "Upload via VSC2m OK."
