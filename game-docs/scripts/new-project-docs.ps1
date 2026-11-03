[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$Target,

    [string]$ProjectName = "New Game",
    [string]$Genre = "Roguelite",
    [string]$CoreVerb = "move + attack",
    [string]$Milestone = "M0 立项",
    [switch]$Force
)

$ErrorActionPreference = "Stop"

$skillRoot = Split-Path -Parent $PSScriptRoot
$templateRoot = Join-Path $skillRoot "references\templates"
$Target = [System.IO.Path]::GetFullPath($Target)
$docsTarget = Join-Path $Target "docs"

if (-not (Test-Path $templateRoot)) {
    throw "Template not found: $templateRoot"
}

if (Test-Path $docsTarget) {
    $existing = Get-ChildItem $docsTarget -Force -ErrorAction SilentlyContinue
    if ($existing -and -not $Force) {
        throw "Target docs already exists and is not empty: $docsTarget. Use -Force to overwrite template files."
    }
}

New-Item -ItemType Directory -Path $docsTarget -Force | Out-Null
Copy-Item -Path (Join-Path $templateRoot "*") -Destination $docsTarget -Recurse -Force

$date = Get-Date -Format "yyyy-MM-dd"
$replacements = @{
    "{{PROJECT_NAME}}" = $ProjectName
    "{{GENRE}}" = $Genre
    "{{CORE_VERB}}" = $CoreVerb
    "{{MILESTONE}}" = $Milestone
    "{{DATE}}" = $date
}

Get-ChildItem -Path $docsTarget -Recurse -Filter *.md | ForEach-Object {
    $text = [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::UTF8)
    foreach ($key in $replacements.Keys) {
        $text = $text.Replace($key, $replacements[$key])
    }
    [System.IO.File]::WriteAllText($_.FullName, $text, [System.Text.UTF8Encoding]::new($false))
}

Write-Host "Docs scaffolded at: $docsTarget" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Fill 01-run-brief.md (one page)"
Write-Host "2. Fill 02-design-spec.md (behavior rules)"
Write-Host "3. Fill 03-acceptance.md (P0/P1 cases)"
Write-Host "4. Run 07-checklists/doc-review.md"
Write-Host "5. Hold the 6-role review, write 05-reviews/0001-*.md"
Write-Host "6. Update 00-README.md current status"
