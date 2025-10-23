<#
.SYNOPSIS
    This PowerShell script ensures that camera access from the lock screen is disabled.

.NOTES
    Author          : Jamal Copeland
    LinkedIn        : linkedin.com/in/jamalcopeland/
    GitHub          : github.com/jamalcopeland
    Date Created    : 2025-10-23
    Last Modified   : 2025-10-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000005

.TESTED ON
    Date(s) Tested  : 2025-10-23
    Tested By       : Jamal Copeland
    Systems Tested  : Windows 10

.USAGE
    PS C:\> .\Disable-Camera.ps1 
#>

# Define the registry path
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"

# Create the path if it doesn't exist
If (!(Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Create or update the policy value
Set-ItemProperty -Path $RegPath -Name "NoLockScreenCamera" -Value 1 -Type DWord

Write-Host "✅ Lock screen camera access disabled successfully!"
