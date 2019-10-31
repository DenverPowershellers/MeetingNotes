function Remove-DVADUser
{
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [string]$username
    )
    $ErrorActionPreference = 'stop'

    $getUser = Get-ADUser -Identity $userName -Properties HomeDirectory
    
    # if a single account was returned proceed
    if ($getUser.count -eq 1) {
        # disable the user
        Set-ADUser -Identity $userName -Enabled:$false
        # if the user has a home directory then decommission it
        if ($getUser.HomeDirectory) {
            # if the homedirectory path is real, rename it
            if (Test-Path -Path $getUser.HomeDirectory) {
                # get the name of the directory from the share path
                $dirName = Split-Path -Path $getUser.HomeDirectory -Leaf
                # rename it
                Rename-Item -Path $getUser.HomeDirectory -NewName ($dirName + '_deprovisioned')
            }
            # clear our the user's homedirectory attributes
            Set-ADUser -Identity $userName -HomeDirectory $null -HomeDrive $null
        } 
        Write-Output $true
    } else {
        Write-Error "more than one user was found for $userName"
    }
}