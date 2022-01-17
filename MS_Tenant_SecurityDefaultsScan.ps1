# Powershell script to audit all tenants for security defaults. 
#
# This script scans all delegate tenants associated with a MSOL user accounts for MFA status. 
# Client sites where all user accounts return Enabled or Enforced for "StrongAuthenticationRequirements.State"
# most likely have "Security Defaults" enabled. We have not found a better funtion to query the 
# "Security Defaults" status otherwise. 
#
#      V0.1 - simply logging the main function. Need to store results Get-MsolPartnerContract in variable, build loop to inspect per TenantID
#             and return Tenant-based summary of results. 




Get-MsolPartnerContract | % { Get-MsolUser -TenantId $_.TenantID } | select UserPrincipalName, @{n="Status"; e={$_.StrongAuthenticationRequirements.state}}

