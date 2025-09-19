[CmdletBinding()]
param([Parameter(Mandatory = $true)] [string] $UploadUrl)
$ErrorActionPreference = 'Stop'
$r = Invoke-WebRequest -UseBasicParsing -Uri $UploadUrl
foreach ($f in $r.Forms) {
  Write-Host ("FORM: " + $f.Action)
  foreach ($kv in $f.Fields.GetEnumerator()) {
    Write-Host ("  FIELD: " + $kv.Key + " = " + $kv.Value)
  }
}
