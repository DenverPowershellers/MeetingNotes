class mutant {
    [string] $Name
    [string[]] $Powers
    hidden [string] $RealName

    mutant ([string]$Name, [string[]]$Powers, [string]$RealName) {
        $this.Name = $Name
        $this.Powers = $Powers
        $this.RealName = $RealName
    }

    mutant ([string]$Name, [string[]]$Powers) {
        $this.Name = $Name
        $this.Powers = $Powers
        $this.RealName = $Name
    }

    [string] UsePowers () {
        return "Using my powers!"
    }

    [string[]] GetPowers() {
        return $this.Powers
    }
}

class hero : mutant {
    static [hero[]] $Team

    hero ([string]$Name, [string[]]$Powers, [string]$RealName) : base($Name, $Powers, $RealName) {
        [hero]::Team += $this
    }

    hero ([string]$Name, [string[]]$Powers) : base($Name, $Powers) {
        [hero]::Team += $this
    }

    static [hero[]] GetTeam () {
        return [hero]::Team 
    }
}