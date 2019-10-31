$Sut = "$PSScriptRoot\..\Test-VMwareTemplates.ps1"

Describe "Test-VMwareTemplates.ps1" {
    Mock Start-Sleep {}
    function Connect-VIServer {}
    Mock Connect-VIServer {}
    function Disconnect-VIServer {}
    Mock Disconnect-VIServer {}
    function Wait-Tools {}
    Mock Wait-Tools {}
    function Start-VM {}
    Mock Start-VM {}
    function Stop-VMGuest {}
    Mock Stop-VMGuest {}
    function Invoke-VMScript {}
    Mock Invoke-VMScript {}
    function Set-Template {}
    Mock Set-Template {}
    function Get-Template {}
    Mock Get-Template {}
    function Get-VM {}
    Mock Get-VM {}
    function Set-VM {}
    Mock Set-VM {} 

    $testCred = New-MockObject -Type 'System.Management.Automation.PSCredential'

    Context "Processes Get-Template counts correctly" {
        Mock Get-Template {
            [pscustomobject]@{
                Name  = 'sea1-node-1'
                count = 0
            }
        }
        It "Should throw when no template is found." {
            {&$Sut -templateNames 'sea1-node-1' -vcenterCredential $testCred -guestCredential $testCred} | Should -Throw "No template was found for sea1-node-1."
        }
        Mock Get-Template {
            [pscustomobject]@{
                count = 1
            }
        }
        It "Should not throw when one template is found." {
            {&$Sut -templateNames 'sea1-node-1' -vcenterCredential $testCred -guestCredential $testCred} | Should -Not -Throw
        }
        Mock Get-Template {
            [pscustomobject]@{
                Name  = 'sea1-node-1'
                count = 2
            }
        }
        It "Should throw when more than one template is found." {
            {&$Sut -templateNames 'sea1-node-1' -vcenterCredential $testCred -guestCredential $testCred} | Should -Throw "More than one vm was returned for sea1-node-1. (Count = 2x)"
        }
    }
    
    Context "Processes Stop-VMGuest waits correctly" {
        Mock Get-Template {
            [pscustomobject]@{
                count = 1
            }
        }
        Mock Get-VM {
            [pscustomobject]@{
                PowerState = 'PoweredOn'
                Name       = 'sea1-node-1'
            }
        }
        Mock Set-VM {}
        It "Should throw when VM never returns PoweredOff state" {
            {&$Sut -templateNames 'sea1-node-1' -vcenterCredential $testCred -guestCredential $testCred} | Should -Throw "VM sea1-node-1 PowerState never changed to PoweredOff, 5 of 5 loops occured."
        }
        Assert-MockCalled -CommandName Set-VM -Times 0
    }
}