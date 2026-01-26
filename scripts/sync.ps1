<#
.SYNOPSIS
    Sync config with GitHub
.DESCRIPTION
    Pull latest, export current config, commit and push
.PARAMETER RepoPath
    Path to claude-config-sync repository
.PARAMETER PullOnly
    Only pull latest config, don't push
.PARAMETER PushOnly
    Only push current config, don't pull
#>

param(
    [string]$RepoPath = (Split-Path -Parent $PSScriptRoot),
    [switch]$PullOnly,
    [switch]$PushOnly
)

$Hostname = $env:COMPUTERNAME

Write-Host "`n========================================"
Write-Host "  Config Sync - $Hostname"
Write-Host "========================================`n"

Push-Location $RepoPath

try {
    # Pull latest
    if (-not $PushOnly) {
        Write-Host "[INFO] Pulling latest from GitHub..."
        git pull --rebase 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "[OK] Pull complete"
        } else {
            Write-Host "[WARN] Pull had issues, check manually"
        }
    }

    if ($PullOnly) {
        Write-Host "`n[INFO] Pull-only mode, skipping export/push"
        return
    }

    # Export current config
    Write-Host "`n[INFO] Exporting current config..."
    & "$RepoPath\scripts\export.ps1" -RepoPath $RepoPath

    # Check for changes
    $Status = git status --porcelain
    if (-not $Status) {
        Write-Host "`n[INFO] No changes to sync"
        return
    }

    # Commit and push
    Write-Host "`n[INFO] Committing changes..."
    git add .
    $CommitMsg = "sync($Hostname): $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    git commit -m $CommitMsg

    Write-Host "`n[INFO] Pushing to GitHub..."
    git push

    if ($LASTEXITCODE -eq 0) {
        Write-Host "`n========================================"
        Write-Host "  Sync Complete!"
        Write-Host "========================================"
    } else {
        Write-Host "[ERROR] Push failed"
    }
}
finally {
    Pop-Location
}
