<#
.SYNOPSIS
    Import Claude Code and VS Code config to current machine
.DESCRIPTION
    Imports configuration from shared/ or machines/<hostname>/
.PARAMETER RepoPath
    Path to claude-config-sync repository
.PARAMETER Source
    Source to import from: 'shared' or specific hostname
.PARAMETER DryRun
    Preview changes without applying
#>

param(
    [string]$RepoPath = (Split-Path -Parent $PSScriptRoot),
    [string]$Source = "shared",
    [switch]$DryRun
)

$Hostname = $env:COMPUTERNAME

Write-Host "`n========================================"
Write-Host "  Config Import - $Hostname"
Write-Host "  Source: $Source"
if ($DryRun) { Write-Host "  [DRY RUN MODE]" }
Write-Host "========================================`n"

# Determine source path
if ($Source -eq "shared") {
    $SourcePath = Join-Path $RepoPath "shared"
} else {
    $SourcePath = Join-Path $RepoPath "machines\$Source"
}

if (-not (Test-Path $SourcePath)) {
    Write-Host "[ERROR] Source not found: $SourcePath"
    exit 1
}

# Target paths
$ClaudeConfigPath = "$env:USERPROFILE\.claude"
$VSCodeUserPath = "$env:APPDATA\Code\User"

# Import Claude config
$ClaudeSource = Join-Path $SourcePath "claude"
if (Test-Path $ClaudeSource) {
    Write-Host "[INFO] Importing Claude config..."

    if (-not $DryRun) {
        if (-not (Test-Path $ClaudeConfigPath)) {
            New-Item -ItemType Directory -Path $ClaudeConfigPath -Force | Out-Null
        }
    }

    Get-ChildItem -Path $ClaudeSource -File | ForEach-Object {
        $DestFile = Join-Path $ClaudeConfigPath $_.Name
        if ($DryRun) {
            Write-Host "[DRY] Would copy: $($_.Name) -> $DestFile"
        } else {
            # Backup existing
            if (Test-Path $DestFile) {
                Copy-Item $DestFile "$DestFile.backup" -Force
            }
            Copy-Item $_.FullName -Destination $DestFile -Force
            Write-Host "[OK] Imported: $($_.Name)"
        }
    }
} else {
    Write-Host "[INFO] No Claude config in source"
}

# Import VS Code settings
$VSCodeSource = Join-Path $SourcePath "vscode"
if (Test-Path $VSCodeSource) {
    Write-Host "`n[INFO] Importing VS Code config..."

    # Settings
    $SettingsSource = Join-Path $VSCodeSource "settings.json"
    if (Test-Path $SettingsSource) {
        $SettingsDest = Join-Path $VSCodeUserPath "settings.json"
        if ($DryRun) {
            Write-Host "[DRY] Would copy: settings.json -> $SettingsDest"
        } else {
            if (Test-Path $SettingsDest) {
                Copy-Item $SettingsDest "$SettingsDest.backup" -Force
                Write-Host "[OK] Backed up existing settings"
            }
            Copy-Item $SettingsSource -Destination $SettingsDest -Force
            Write-Host "[OK] Imported: settings.json"
        }
    }

    # Keybindings
    $KeybindingsSource = Join-Path $VSCodeSource "keybindings.json"
    if (Test-Path $KeybindingsSource) {
        $KeybindingsDest = Join-Path $VSCodeUserPath "keybindings.json"
        if ($DryRun) {
            Write-Host "[DRY] Would copy: keybindings.json -> $KeybindingsDest"
        } else {
            if (Test-Path $KeybindingsDest) {
                Copy-Item $KeybindingsDest "$KeybindingsDest.backup" -Force
            }
            Copy-Item $KeybindingsSource -Destination $KeybindingsDest -Force
            Write-Host "[OK] Imported: keybindings.json"
        }
    }

    # Snippets
    $SnippetsSource = Join-Path $VSCodeSource "snippets"
    if (Test-Path $SnippetsSource) {
        $SnippetsDest = Join-Path $VSCodeUserPath "snippets"
        if ($DryRun) {
            Write-Host "[DRY] Would copy: snippets/ -> $SnippetsDest"
        } else {
            if (-not (Test-Path $SnippetsDest)) {
                New-Item -ItemType Directory -Path $SnippetsDest -Force | Out-Null
            }
            Copy-Item "$SnippetsSource\*" -Destination $SnippetsDest -Recurse -Force
            Write-Host "[OK] Imported: snippets/"
        }
    }
} else {
    Write-Host "[INFO] No VS Code config in source"
}

# Install extensions
$ExtensionsFile = Join-Path $SourcePath "extensions.txt"
if (Test-Path $ExtensionsFile) {
    Write-Host "`n[INFO] Installing extensions..."
    $Extensions = Get-Content $ExtensionsFile | Where-Object { $_ -match '\S' }

    foreach ($Ext in $Extensions) {
        if ($DryRun) {
            Write-Host "[DRY] Would install: $Ext"
        } else {
            code --install-extension $Ext --force 2>&1 | Out-Null
            Write-Host "[OK] Installed: $Ext"
        }
    }
}

Write-Host "`n========================================"
Write-Host "  Import Complete!"
Write-Host "========================================`n"

if (-not $DryRun) {
    Write-Host "Restart VS Code to apply changes"
}
