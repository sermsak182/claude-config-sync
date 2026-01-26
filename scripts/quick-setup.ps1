<#
.SYNOPSIS
    Quick setup script - Clone and import in one command
.DESCRIPTION
    Run this on a new machine to get started quickly
#>

param(
    [string]$Source = "shared",
    [switch]$ExportAfter
)

$RepoUrl = "https://github.com/sermsak182/claude-config-sync.git"
$RepoName = "claude-config-sync"
$InstallPath = "$env:USERPROFILE\$RepoName"

Write-Host "`n========================================"
Write-Host "  Quick Setup - Claude Config Sync"
Write-Host "========================================`n"

# Clone if not exists
if (Test-Path $InstallPath) {
    Write-Host "[INFO] Repository exists, pulling latest..."
    Push-Location $InstallPath
    git pull
    Pop-Location
} else {
    Write-Host "[INFO] Cloning repository..."
    git clone $RepoUrl $InstallPath
}

# Import
Write-Host "`n[INFO] Importing config from: $Source"
& "$InstallPath\scripts\import.ps1" -Source $Source

# Export if requested
if ($ExportAfter) {
    Write-Host "`n[INFO] Exporting current machine config..."
    & "$InstallPath\scripts\export.ps1"

    Push-Location $InstallPath
    git add .
    $Hostname = $env:COMPUTERNAME
    git commit -m "feat: add $Hostname config"
    git push
    Pop-Location
}

Write-Host "`n========================================"
Write-Host "  Setup Complete!"
Write-Host "========================================`n"
Write-Host "Location: $InstallPath"
Write-Host "Restart VS Code to apply changes"
