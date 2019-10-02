class User {
    [ValidateLength(0,18)]
    [string] $SamAccountName
    [mailaddress] $Email

    [ValidatePattern('((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}')]
    [string] $Phone

    [string] $FirstName
    [string] $LastName
}

# Property names need to match CSV headers
# Single failure will err entire import 
[user[]]$users = Import-Csv -Path .\userdata.csv

# Loop over each cast to isolate problem records
[user[]]$Users = foreach ($Record in $(Import-Csv -Path .\userdata.csv)) {
    try {
        [user]$Record
    }
    catch [System.Management.Automation.PSInvalidCastException] {
        Write-Warning "Ran into a problem with $($Record.SamAccountName)"
    }
}