$group = Get-ADGroupMember -Identity CitrixCloud-RDS-Servers | foreach { $_.name }
$username = Read-Host -Prompt "Enter the username you're hunting for"
$username = $username.ToLower()
foreach ( $srv in $group ) {
    Write-Host "Scanning " $srv "..."
    $disks = Invoke-Command $srv { get-disk }
    foreach ($disk in $disks){
        $location = $disk.Location
 #       
        if($location.ToLower().Contains($username)){
            write-host -ForegroundColor Green "Found profile on Server " $srv "..."
            write-host -ForegroundColor Green $location
        }
    }
    
   
 #  Invoke-Command $srv { 
 #      get-disk | Where-Object { $_.Location.ToLower().Contains($username) }
 #      }
    }
