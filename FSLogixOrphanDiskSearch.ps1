#This script will search the sessions hosts that are part of the "$SHGroupName" AD Group for attached FSLogix drives.
#if you see the disk attached to a machine where the user does not have an existing session, then FSLogix has 
#likely lost it's handle on the disk and it may need to be manually detached through diskmgr. 
#rebooting the affected session host is the ideal solution to orphaned disks, but that may not always be possible during 
#production.

$SHGroupName = "CitrixCloud-RDS-Servers"   #specify the AD group that your target session hosts belong to. 

#Load up variables
$group = Get-ADGroupMember -Identity $SHGroupName | foreach { $_.name }
$username = Read-Host -Prompt "Enter the username you're hunting for"
$username = $username.ToLower() #Might be able to just include this in line 11?
$creds = Get-Credential -Message "Login with account authorized for WinRM..." #usually an admin account

#step through each server, list all drives, search drive location for path that includes $username
foreach ( $srv in $group ) {
    Write-Host "Scanning " $srv "..."
    $disks = Invoke-Command $srv { get-disk } -Credential ($creds)
    foreach ($disk in $disks){
        $location = $disk.Location
        if($location.ToLower().Contains($username)){  #if found....
            write-host -ForegroundColor Green "Found profile on Server " $srv "..."
            write-host -ForegroundColor Green $location
        }
    }
}
