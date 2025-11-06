<#
.SYNOPSIS
    Automates Windows 10 STIG remediation disabling legacy protocols.

.IMPORTANT
⚠️ MUST be run as Administrator.
This script assumes elevated rights and does NOT check for them.

.DESCRIPTION
Disables old legacy protocols within Windows Features.
WN10-00-000115: The Telnet Client must not be installed on the system.
WN10-00-000160: The Server Message Block (SMB) v1 protocol must be disabled on the system.
WN10-00-000155: PowerShell 2.0 must be disabled on the system.

.NOTES
    Author          : Jamal Copeland
    LinkedIn        : linkedin.com/in/jamalcopeland/
    GitHub          : github.com/jamalcopeland
    Date Created    : 2025-11-06
    Last Modified   : 2025-11-06
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000115, WN10-00-000160, WN10-00-000155

.TESTED ON
    Date(s) Tested  : 2025-10-23
    Tested By       : Jamal Copeland
    Systems Tested  : Windows 10

.USAGE
    PS C:\> .\DisableLegacyProtocols.ps1
#>

<#
.SYNOPSIS
    STIG Remediation Demo Script - With Forced Restart
.DESCRIPTION
    Perfect for demonstrations - fixes everything and restarts automatically
#>

Write-Host "=== STIG REMEDIATION DEMO ===" -ForegroundColor Cyan
Write-Host "Starting automated security fixes..." -ForegroundColor Yellow

# Track if we made any changes
$MadeChanges = $false

# 1. TELNET CLIENT
Write-Host "`n[1/3] Checking Telnet Client..." -ForegroundColor Yellow
$Telnet = Get-WindowsOptionalFeature -Online -FeatureName "TelnetClient" -ErrorAction SilentlyContinue
if ($Telnet.State -eq "Enabled") {
    Disable-WindowsOptionalFeature -Online -FeatureName "TelnetClient" -NoRestart
    Write-Host "  ✓ Telnet Client REMOVED" -ForegroundColor Green
    $MadeChanges = $true
} else {
    Write-Host "  ✓ Telnet already gone" -ForegroundColor Green
}

# 2. SMBv1
Write-Host "`n[2/3] Checking SMBv1..." -ForegroundColor Yellow
$SMBv1Client = Get-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol-Client" -ErrorAction SilentlyContinue
$SMBv1Server = Get-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol-Server" -ErrorAction SilentlyContinue

if ($SMBv1Client.State -eq "Enabled" -or $SMBv1Server.State -eq "Enabled") {
    Disable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol-Client" -NoRestart
    Disable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol-Server" -NoRestart
    Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force
    Write-Host "  ✓ SMBv1 DISABLED" -ForegroundColor Green
    $MadeChanges = $true
} else {
    Write-Host "  ✓ SMBv1 already disabled" -ForegroundColor Green
}

# 3. POWERSHELL 2.0
Write-Host "`n[3/3] Checking PowerShell 2.0..." -ForegroundColor Yellow
$PSv2Engine = Get-WindowsOptionalFeature -Online -FeatureName "MicrosoftWindowsPowerShellV2" -ErrorAction SilentlyContinue
$PSv2Root = Get-WindowsOptionalFeature -Online -FeatureName "MicrosoftWindowsPowerShellV2Root" -ErrorAction SilentlyContinue

if ($PSv2Engine.State -eq "Enabled" -or $PSv2Root.State -eq "Enabled") {
    Disable-WindowsOptionalFeature -Online -FeatureName "MicrosoftWindowsPowerShellV2" -NoRestart
    Disable-WindowsOptionalFeature -Online -FeatureName "MicrosoftWindowsPowerShellV2Root" -NoRestart
    Write-Host "  ✓ PowerShell 2.0 DISABLED" -ForegroundColor Green
    $MadeChanges = $true
} else {
    Write-Host "  ✓ PowerShell 2.0 already disabled" -ForegroundColor Green
}

# FORCED RESTART FOR CLEAN DEMO
if ($MadeChanges) {
    Write-Host "`n🔄 RESTARTING SYSTEM FOR CLEAN DEMO..." -ForegroundColor Magenta
    Write-Host "This ensures all changes are fully applied!" -ForegroundColor Yellow
    Write-Host "Computer will restart in 10 seconds..." -ForegroundColor Red
    Write-Host "Press Ctrl+C to cancel" -ForegroundColor Red
    
    # Countdown timer
    10..1 | ForEach-Object {
        Write-Host "Restarting in $_ seconds..." -ForegroundColor Yellow
        Start-Sleep -Seconds 1
    }
    
    Write-Host "RESTARTING NOW!" -ForegroundColor Red
    Restart-Computer -Force
    
} else {
    Write-Host "`n✅ No changes needed - system already compliant!" -ForegroundColor Green
    pause
}
