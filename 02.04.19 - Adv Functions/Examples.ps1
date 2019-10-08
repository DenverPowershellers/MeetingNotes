#region Simple functions

function Write-Hello {
    param (
        $Name
    )

    "Hello, $Name!"
}

function Write-Hello {
    param (
        $Name,
        $Age
    )

    "Hello, $Name! Who is $Age!"
}

# Array
function Write-Hello {
    param (
        $Names
    )

    foreach ($Name in $Names) {
        "Hello, $Name!"
    }
}

# Type constraints
function Write-Hello {
    param (
        [string]
        $Name,

        [int]
        $Age
    )

    "Hello, $Name! Who is $Age!"
}

function Test-BadType {
    param (
        [hashtable]
        $MyHash
    )
}

# Default value
function Write-Hello {
    param (
        [string]
        $Name = 'Jon'
    )

    "Hello, $Name!"
}

#endregion

# Find output types
Get-Command |
    Where-Object OutputType -like '*System.String*' |
    Select-Object Name, OutputType

#region Output streams / Common Parameters

function Write-OutputStreams {
    [CmdletBinding()]
    param (
        $Message
    )

    Write-Output -InputObject $Message
    Write-Error -Message $Message
    Write-Warning -Message $Message

    Write-Verbose -Message $Message

    $a = "Four"
    Write-Debug -Message $DebugPreference
    $a

    Write-Information -MessageData $Message
}

Get-Variable | Where-Object Name -like "*Preference"

Write-OutputStreams -Message "Don't cross the streams!"
Write-OutputStreams -Message "Extra detail about what the function is doing." -Verbose -WarningAction SilentlyContinue -ErrorAction SilentlyContinue | Out-Null
Write-OutputStreams -Message 'Overwrites $DebugPreference from SilentlyContinue to Inquire' -Debug -WA SilentlyContinue -EA SilentlyContinue | Out-Null
Write-OutputStreams -Message "Sam stopped by." -InformationAction Continue

#endregion

#region Mandatory / HelpMessage / Position

function Get-PcInfo {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
            HelpMessage = 'Enter a computer name',
            Position = 0)]
        [string]
        $ComputerName,

        [Parameter()]
        [string]
        $Credential
    )

    "ComputerName is {0}" -f $ComputerName
    "Credential is {0}" -f $Credential
}

#endregion

#region Parameter Sets

function Get-ParameterSets {
    [CmdletBinding(DefaultParameterSetName = 'Server')]
    [OutputType([string], ParameterSetName = 'Server')]
    [OutputType([int], ParameterSetName = 'Database')]
    param (
        [Parameter(ParameterSetName = 'Server')]
        [Parameter(ParameterSetName = 'Database')]
        [string]
        $Server,

        [Parameter(ParameterSetName = 'Database')]
        [string]
        $Database,

        [Parameter()]
        [pscredential]
        $Credential
    )

    "Parameter Set: {0}" -f $PSCmdlet.ParameterSetName

}

#endregion

#region Pipeline input / Alias

[ValueFromPipeline]
[ValueFromPipelineByPropertyName]
[pscustomobject]@{Name = 'dbserver1'}
[pscustomobject]@{ComputerName = 'dbserver1'}

[Alias('Name')]

#endregion

#region Parameter Validation

# List all type accelerators
$TAType = [psobject].Assembly.GetType("System.Management.Automation.TypeAccelerators")
$TAType::Add('accelerators', $TAType)

[accelerators]::Get

# ValidatePattern
function Set-PhoneNumber {
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidatePattern('^(\+0?1\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$')]
        [string]
        $PhoneNumber
    )
}

# ValidateScript
function Set-PhoneNumber {
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateScript( {
                ($_ -replace "[^0-9]", "").length -eq 10
            } )]
        [string]
        $PhoneNumber
    )
}

function Set-FilePath {
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateScript( {
                Test-Path -Path $_
            } )]
        [string]
        $Path
    )
}

# ValidateDrive
function Test-ValidateDrive {
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateDrive('C', 'D')]
        $Path
    )
}

#endregion

#region Comment-based help

<#
    .SYNOPSIS

    .DESCRIPTION

    .PARAMETER <Parameter name>

    .EXAMPLE

    .INPUTS

    .OUTPUTS

    .NOTES
#>

#endregion