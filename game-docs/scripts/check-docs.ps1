[CmdletBinding()]
param(
    [string]$DocsPath = ".\docs",
    [switch]$AllowPlaceholders
)

$ErrorActionPreference = "Stop"
$DocsPath = [System.IO.Path]::GetFullPath($DocsPath)
$errors = New-Object System.Collections.Generic.List[string]

if (-not (Test-Path $DocsPath)) {
    Write-Host "Docs path not found: $DocsPath" -ForegroundColor Red
    exit 1
}

$required = @(
    "00-README.md",
    "01-run-brief.md",
    "02-design-spec.md",
    "03-acceptance.md",
    "04-adr",
    "05-reviews",
    "07-checklists"
)

foreach ($item in $required) {
    if (-not (Test-Path (Join-Path $DocsPath $item))) {
        $errors.Add("Missing required entry: $item")
    }
}

$docs = Get-ChildItem -Path $DocsPath -Recurse -Filter *.md
foreach ($file in $docs) {
    $text = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)

    if (-not $AllowPlaceholders -and $text.Contains("{{")) {
        $errors.Add("Unreplaced placeholder in: $($file.FullName)")
    }

    $matches = [regex]::Matches($text, '\[[^\]]+\]\(([^)]+)\)')
    foreach ($match in $matches) {
        $rawTarget = $match.Groups[1].Value
        $target = $rawTarget.Split('#')[0]
        if ([string]::IsNullOrWhiteSpace($target)) { continue }
        if ($target -match '^(https?://|mailto:)') { continue }

        $resolved = Join-Path $file.DirectoryName $target
        if (-not (Test-Path $resolved)) {
            $errors.Add("Broken link: $($file.FullName) -> $rawTarget")
        }
    }
}

$rootDocs = Get-ChildItem -Path $DocsPath -File -Filter *.md
foreach ($file in $rootDocs) {
    if ($file.Name -notmatch '^\d{2}-') {
        $errors.Add("Unnumbered root doc: $($file.Name) (expected NN-name.md)")
    }
}

if ($errors.Count -gt 0) {
    Write-Host "Docs check failed with $($errors.Count) issue(s):" -ForegroundColor Red
    foreach ($errorItem in $errors) {
        Write-Host " - $errorItem" -ForegroundColor Red
    }
    exit 1
}

Write-Host "Docs check passed: $DocsPath" -ForegroundColor Green
