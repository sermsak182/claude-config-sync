<#
.SYNOPSIS
    Export Claude Code and VS Code config from current machine
.DESCRIPTION
    Exports configuration to machines/<hostname>/ folder
.PARAMETER RepoPath
    Path to claude-config-sync repository
#>

param(
    [string]$RepoPath = (Split-Path -Parent $PSScriptRoot)
)

$Hostname = $env:COMPUTERNAME
$MachinePath = Join-Path $RepoPath "machines\$Hostname"

Write-Host "`n========================================"
Write-Host "  Config Export - $Hostname"
Write-Host "========================================`n"

# Create machine folder if not exists
if (-not (Test-Path $MachinePath)) {
    New-Item -ItemType Directory -Path $MachinePath -Force | Out-Null
    Write-Host "[OK] Created folder: machines\$Hostname"
}

# Export paths
$ClaudeConfigPath = "$env:USERPROFILE\.claude"
$VSCodeSettingsPath = "$env:APPDATA\Code\User\settings.json"
$VSCodeKeybindingsPath = "$env:APPDATA\Code\User\keybindings.json"
$VSCodeSnippetsPath = "$env:APPDATA\Code\User\snippets"

# Export Claude config
Write-Host "[INFO] Exporting Claude config..."
$ClaudeDestPath = Join-Path $MachinePath "claude"
if (Test-Path $ClaudeConfigPath) {
    if (-not (Test-Path $ClaudeDestPath)) {
        New-Item -ItemType Directory -Path $ClaudeDestPath -Force | Out-Null
    }

    # Copy CLAUDE.md files (project instructions)
    Get-ChildItem -Path $ClaudeConfigPath -Filter "*.md" -ErrorAction SilentlyContinue | ForEach-Object {
        Copy-Item $_.FullName -Destination $ClaudeDestPath -Force
        Write-Host "[OK] Exported: $($_.Name)"
    }

    # Copy settings.json (if exists and not containing secrets)
    $ClaudeSettings = Join-Path $ClaudeConfigPath "settings.json"
    if (Test-Path $ClaudeSettings) {
        $SettingsContent = Get-Content $ClaudeSettings -Raw
        # Check for API keys
        if ($SettingsContent -notmatch 'api[_-]?key|secret|token|password') {
            Copy-Item $ClaudeSettings -Destination $ClaudeDestPath -Force
            Write-Host "[OK] Exported: settings.json"
        } else {
            Write-Host "[SKIP] settings.json contains sensitive data"
        }
    }
} else {
    Write-Host "[INFO] No Claude config found at $ClaudeConfigPath"
}

# Export VS Code settings
Write-Host "`n[INFO] Exporting VS Code config..."
$VSCodeDestPath = Join-Path $MachinePath "vscode"
if (-not (Test-Path $VSCodeDestPath)) {
    New-Item -ItemType Directory -Path $VSCodeDestPath -Force | Out-Null
}

if (Test-Path $VSCodeSettingsPath) {
    Copy-Item $VSCodeSettingsPath -Destination $VSCodeDestPath -Force
    Write-Host "[OK] Exported: settings.json"
}

if (Test-Path $VSCodeKeybindingsPath) {
    Copy-Item $VSCodeKeybindingsPath -Destination $VSCodeDestPath -Force
    Write-Host "[OK] Exported: keybindings.json"
}

if (Test-Path $VSCodeSnippetsPath) {
    $SnippetsDest = Join-Path $VSCodeDestPath "snippets"
    if (-not (Test-Path $SnippetsDest)) {
        New-Item -ItemType Directory -Path $SnippetsDest -Force | Out-Null
    }
    Copy-Item "$VSCodeSnippetsPath\*" -Destination $SnippetsDest -Recurse -Force
    Write-Host "[OK] Exported: snippets/"
}

# Export extensions list
Write-Host "`n[INFO] Exporting extensions list..."
$ExtensionsFile = Join-Path $MachinePath "extensions.txt"
code --list-extensions | Out-File -FilePath $ExtensionsFile -Encoding UTF8
$ExtCount = (Get-Content $ExtensionsFile).Count
Write-Host "[OK] Exported: extensions.txt ($ExtCount extensions)"

# Create machine info file
$InfoFile = Join-Path $MachinePath "machine-info.json"
$MachineInfo = @{
    hostname = $Hostname
    os = "Windows"
    exported_at = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
} | ConvertTo-Json -Depth 2
$MachineInfo | Out-File -FilePath $InfoFile -Encoding UTF8
Write-Host "[OK] Exported: machine-info.json"

Write-Host "`n========================================"
Write-Host "  Export Complete!"
Write-Host "========================================`n"
Write-Host "Location: machines\$Hostname\"
Write-Host "Next: Run 'git add . && git commit && git push'"
