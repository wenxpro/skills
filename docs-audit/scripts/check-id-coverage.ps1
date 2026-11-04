[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$LeftPath,
    [Parameter(Mandatory = $true)]
    [string]$RightPath,
    [string]$Pattern = '\b([A-Z][A-Z0-9]*-\d+)\b'
)

$ErrorActionPreference = "Stop"

function Get-Ids([string]$Path) {
    $text = [System.IO.File]::ReadAllText($Path, [System.Text.Encoding]::UTF8)
    $ids = @{}
    foreach ($m in [regex]::Matches($text, $Pattern)) {
        $ids[$m.Groups[1].Value] = $true
    }
    return $ids
}

$left = Get-Ids $LeftPath
$right = Get-Ids $RightPath

$leftOnly = @($left.Keys | Where-Object { -not $right.ContainsKey($_) } | Sort-Object)
$rightOnly = @($right.Keys | Where-Object { -not $left.ContainsKey($_) } | Sort-Object)
$both = @($left.Keys | Where-Object { $right.ContainsKey($_) } | Sort-Object)

Write-Host "Left : $LeftPath ($($left.Count) ids)"
Write-Host "Right: $RightPath ($($right.Count) ids)"
Write-Host "Both : $($both.Count)"
Write-Host ""
Write-Host "Only in left ($($leftOnly.Count)):"
$leftOnly | ForEach-Object { Write-Host "  $_" }
Write-Host ""
Write-Host "Only in right ($($rightOnly.Count)):"
$rightOnly | ForEach-Object { Write-Host "  $_" }

if ($leftOnly.Count -gt 0 -or $rightOnly.Count -gt 0) {
    exit 1
}
exit 0
