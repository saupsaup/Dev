[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)] [string] $ProjectDir,
    [Parameter(Mandatory = $true)] [string] $UploadUrl,
    [string] $FieldName = 'file',
    [ValidateSet('multipart','raw')] [string] $Mode = 'multipart',
    [switch] $TriggerLoad,
    [switch] $ShowResponse
)

$ErrorActionPreference = 'Stop'

$pckg = Join-Path -Path $ProjectDir -ChildPath '200.pckg'
if (!(Test-Path -LiteralPath $pckg)) { throw "pckg not found: $pckg" }

# 200.pckg môže byť čistá cesta ALEBO text: Package 'M:\...\Something.TTR'
$raw = (Get-Content -Raw -LiteralPath $pckg).Trim()
if ($raw -match "'([^']+\.TTR)'" -or $raw -match '"([^"]+\.TTR)"') {
    $ttr = $Matches[1]
} else {
    $ttr = $raw.Trim('"', "'")
}
if (!(Test-Path -LiteralPath $ttr)) { throw "TTR not found: $ttr" }

function Assert-HttpOk([int]$exitCode, [string]$httpCode, [string]$stage) {
    if ($exitCode -ne 0 -or ($httpCode -notmatch '^(200|201|202|204)$')) {
        throw "$stage failed (HTTP $httpCode, exit $exitCode)"
    }
}

# log pre debug (headers/body)
$logDir = Join-Path $ProjectDir ".vscode"
if (!(Test-Path $logDir)) { New-Item -ItemType Directory -Path $logDir | Out-Null }
$uploadLog = Join-Path $logDir "upload_last.txt"
$triggerLog = Join-Path $logDir "trigger_last.txt"

$http = ''
if ($Mode -eq 'multipart') {
    # curl: -L follow redirects, -H "Expect:" vypne 100-continue, -i ukáže headers ak ShowResponse
    $args = @('-sS','-L','-w','HTTP_CODE=%{http_code}','-H','Expect:','-F', "$FieldName=@$ttr;type=application/octet-stream", $UploadUrl)
    if ($ShowResponse) { $args = @('-sS','-L','-i','-w','HTTP_CODE=%{http_code}','-H','Expect:','-F', "$FieldName=@$ttr;type=application/octet-stream", $UploadUrl) }
    else { $args = @('-sS','-L','-o','NUL','-w','HTTP_CODE=%{http_code}','-H','Expect:','-F', "$FieldName=@$ttr;type=application/octet-stream", $UploadUrl) }

    $resp = & curl.exe @args 2>&1
    Set-Content -LiteralPath $uploadLog -Value $resp
    if ($ShowResponse) { Write-Host ($resp | Out-String) }

    if ($resp -match 'HTTP_CODE=(\d+)') { $http = $Matches[1] } else { $http = '?' }
    $curlExit = $LASTEXITCODE
    Assert-HttpOk $curlExit $http 'Upload'
} else {
    $r = Invoke-WebRequest -Uri $UploadUrl -Method Post -InFile $ttr -ContentType 'application/octet-stream' -UseBasicParsing
    $http = [string]$r.StatusCode
    Assert-HttpOk 0 $http 'Upload'
}

Write-Host "Upload OK ($Mode): $ttr (HTTP $http)"

if ($TriggerLoad) {
    # Simulácia tlačidla „aSys.ini = 40 spusti load“ (application/x-www-form-urlencoded)
    $resp2 = & curl.exe -sS -L -i -w 'HTTP_CODE=%{http_code}' --data-urlencode '__T68A626DB_USINT_u=40' $UploadUrl 2>&1
    Set-Content -LiteralPath $triggerLog -Value $resp2
    Write-Host "Trigger response:"
    Write-Host ($resp2 | Out-String)

    $hc = '?'
    if ($resp2 -match 'HTTP_CODE=(\d+)') { $hc = $Matches[1] }
    $curlExit2 = $LASTEXITCODE
    Assert-HttpOk $curlExit2 $hc 'Trigger'
    Write-Host "Trigger OK (HTTP $hc)"
}
