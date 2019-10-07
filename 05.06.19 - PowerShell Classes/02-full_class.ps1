# Hidden, overloads, signatures, return
class mutant {
    [string] $Name
    [string[]] $Powers

    # Hidden properties can still be exposed. 
    # More to designate something which is for internal use and shouldn't be messed with.
    hidden [string] $RealName

    mutant ([string]$Name, [string[]]$Powers, [string]$RealName) {
        # $this variable refers to the current instance of a class
        $this.Name = $Name
        $this.Powers = $Powers
        $this.RealName = $RealName
    }

    # Overloading methods is a form of polymorphism
    mutant ([string]$Name, [string[]]$Powers) {
        $this.Name = $Name
        $this.Powers = $Powers
        $this.RealName = $Name
    }

    [string] UsePowers () {
        # "You'll never see this"
        return "Using my powers!"
    }

    [string[]] GetPowers() {
        return $this.Powers
    }
}