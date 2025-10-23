<#
.SYNOPSIS
    Automates Windows 10 STIG password policy requirements.

.IMPORTANT
⚠️ MUST be run as Administrator.
This script assumes elevated rights and does NOT check for them.

.NOTES
    Author          : Jamal Copeland
    LinkedIn        : linkedin.com/in/jamalcopeland/
    GitHub          : github.com/jamalcopeland
    Date Created    : 2025-10-23
    Last Modified   : 2025-10-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000020, WN10-AC-000030, WN10-AC-000035

.TESTED ON
    Date(s) Tested  : 2025-10-23
    Tested By       : Jamal Copeland
    Systems Tested  : Windows 10

.USAGE
    PS C:\> .\PasswordPolicy.ps1 
#>

# Configure STIG Password Policies

# Set password history to 24 (blocks reuse of last 24 passwords)
net accounts /uniquepw:24

# Set Minimum Password Age to 1 day
net accounts /minpwage:1

# Set Minimum Password Length to 14 characters
net accounts /minpwlen:14

# ================================
# Output updated policy to verify
# ================================

Write-Host "`n✅ STIG password policies applied successfully!" -ForegroundColor Green
Write-Host "Current password policy settings:" -ForegroundColor Cyan
net accounts
