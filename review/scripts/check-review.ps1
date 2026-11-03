[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$ReviewPath,
    [switch]$AllowPending
)

$ErrorActionPreference = "Stop"
$ReviewPath = [System.IO.Path]::GetFullPath($ReviewPath)
$errors = New-Object System.Collections.Generic.List[string]

if (-not (Test-Path $ReviewPath)) {
    Write-Host "Review path not found: $ReviewPath" -ForegroundColor Red
    exit 1
}

$item = Get-Item $ReviewPath
if ($item.PSIsContainer) {
    $files = Get-ChildItem -Path $ReviewPath -Recurse -Filter *.md |
        Where-Object {
            $_.Name -notmatch '^README\.md$' -and
            $_.DirectoryName -notmatch '\\archive(\\|$)'
        }
} else {
    $files = @($item)
}

if (@($files).Count -eq 0) {
    Write-Host "Review check passed: 0 active review file(s)."
    exit 0
}

$allowed = @("通过", "有条件通过", "否决", "Superseded", "Archived")
if ($AllowPending) {
    $allowed += "待定"
}

foreach ($file in $files) {
    $text = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $name = $file.Name

    foreach ($required in @("评审编号", "日期", "结论", "## 1. 决策", "## 2. 角色意见", "## 3. 条件与行动项", "## 4. 证据")) {
        if (-not $text.Contains($required)) {
            $errors.Add("Missing '$required' in: $name")
        }
    }

    $match = [regex]::Match($text, '(?m)^>\s*结论：\*\*(.+?)\*\*')
    if (-not $match.Success) {
        $errors.Add("Missing conclusion line in: $name")
        continue
    }

    $conclusion = $match.Groups[1].Value.Trim()
    if ($allowed -notcontains $conclusion) {
        $errors.Add("Invalid conclusion '$conclusion' in: $name")
    }

    if ($conclusion -eq "有条件通过" -and $text -notmatch '(?m)^\|\s*AI-\d+') {
        $errors.Add("Conditional pass without AI-* action row in: $name")
    }
}

if ($errors.Count -gt 0) {
    Write-Host "Review check failed with $($errors.Count) issue(s):" -ForegroundColor Red
    foreach ($errorItem in $errors) {
        Write-Host " - $errorItem" -ForegroundColor Red
    }
    exit 1
}

Write-Host "Review check passed: $(@($files).Count) review file(s)." -ForegroundColor Green
exit 0
