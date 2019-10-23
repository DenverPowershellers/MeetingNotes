class address {
    [int] $Number
    [string] $Street
    [string] $City
    [string] $State

    address ([int] $Number, [string] $Street, [string] $City, [string] $State) {
        $this.Number = $Number
        $this.Street = $Street
        $this.City = $City
        $this.State = $State
    }
}

class person {
    [string] $FirstName = 'Joe'
    [string] $LastName = 'Shmoe'
    [DateTime] $DateOfBirth = '01/01/1900'
    [address] $Address

    person ([string] $FirstName, [string] $LastName, [string] $DateOfBirth) {
        $this.FirstName = $FirstName
        $this.LastName = $LastName
        $this.DateOfBirth = $DateOfBirth
    }

    person () { }

    setAddress ([int] $Number, [string] $Street, [string] $City, [string] $State) {
        $this.Address = [address]::new($Number, $Street, $City, $State)
    }

}

function New-Person {
    [CmdletBinding()]
    param (
        [string]
        $FirstName,

        [string]
        $LastName,

        [DateTime]
        $DateOfBirth
    )

    [person]::new($FirstName, $LastName, $DateOfBirth)
}

#Export-ModuleMember -Function New-Person