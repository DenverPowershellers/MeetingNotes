#region
$SystemInfo = @{
    $env:COMPUTERNAME = @{
        Domain    = 'demo.com'
        OS        = 'Windows 10'
        IPAddress = '192.168.0.10'
        RAM       = '8GB'
    }
    WebServer1        = @{
        Domain    = 'demo.com'
        OS        = 'Ubuntu 14.04'
        IPAddress = '192.168.0.5'
        RAM       = '8GB'
    }
    DbServer1         = @{
        Domain    = 'demo.com'
        OS        = 'Ubuntu 16.04'
        IPAddress = '192.168.0.6'
        RAM       = '16GB'
    }
    FileServer1       = @{
        Domain    = 'demo.com'
        OS        = 'Windows Server 2016 Standard'
        IPAddress = '192.168.0.7'
        RAM       = '8GB'
    }
}

function Get-DemoSysInfo {
    foreach ($System in $SystemInfo.GetEnumerator()) {
        $props = [ordered]@{'Name' = $System.Key} + $System.Value
        New-Object PSCustomObject -Property $props
    }
}

function Set-DemoSysInfo {
    process {
        $SystemInfo[$_.Name] = @{
            Domain    = $_.Domain
            OS        = $_.OS
            IPAddress = $_.IPAddress
            RAM       = $_.RAM
        }
    }
}
#endregion

function Get-DemoComputerInfo {
    param (
        $ComputerName
    )

    Get-DemoSysInfo | Where-Object Name -like "$ComputerName"
}