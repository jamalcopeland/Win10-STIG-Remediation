<#
.SYNOPSIS
    Automates Windows 10 STIG password policy requirements.

.IMPORTANT
⚠️ MUST be run as Administrator.
This script assumes elevated rights and does NOT check for them.

.DESCRIPTION
Configures Windows password policy settings for the following Windows 10 STIG requirements:
WN10-AC-000020	The password history must be configured to 24 passwords remembered.
WN10-AC-000030	The minimum password age must be configured to at least 1 day.
WN10-AC-000035 Passwords must, at a minimum, be 14 characters

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
