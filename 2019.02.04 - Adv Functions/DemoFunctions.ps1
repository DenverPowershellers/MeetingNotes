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
<#
    .SYNOPSIS
    Get info about computers

    .DESCRIPTION
    More detail info about what this does

    .PARAMETER ComputerName
    This is the name of a computer to retreieve info on

    .EXAMPLE
    Get-DemoComputerInfo -ComputerName 'dbserver1'

    .EXAMPLE
    more stuff

    .INPUTS
    ComputerName takes a string or array of strings

    .OUTPUTS
    We output pscustomobjects

    .NOTES
#>
    [CmdletBinding(DefaultParameterSetName = 'ComputerName',
    HelpUri = 'https://google.com')]
    param (
        [Parameter(ParameterSetName = 'ComputerName',
            Position = 0,
            ValueFromPipelineByPropertyName)]
        [Alias('Name')]
        [string[]]
        $ComputerName = $env:COMPUTERNAME,

        [Parameter(ParameterSetName = 'Domain')]
        [string]
        $Domain,

        [Parameter(ParameterSetName = 'RAM')]
        [string]
        $RAM,

        [Parameter(ParameterSetName = 'OS')]
        [string]
        $OS,

        [Parameter(ParameterSetName = 'IPAddress')]
        [string]
        $IPAddress
    )

    process {
        switch ($PSCmdlet.ParameterSetName) {
            'ComputerName' {
                foreach ($Name in $ComputerName) {
                    Get-DemoSysInfo | Where-Object Name -like "$Name"
                }
            }
            'Domain' {
                Get-DemoSysInfo | Where-Object Domain -like "$Domain"
            }
            'RAM' {
                Get-DemoSysInfo | Where-Object RAM -like "$RAM"
            }
            'OS' {
                Get-DemoSysInfo | Where-Object OS -like "$OS"
            }
            'IPAddress' {
                Get-DemoSysInfo | Where-Object IPAddress -like "$IPAddress"
            }
        }
    }
}