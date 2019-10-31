. ..\Remove-DVADUser.ps1

Describe "Remove-DVADUser" {
    function Get-ADUser {}
    function Set-Aduser {}
    context "fails as it should" {
        Mock Get-ADUser {
            [PSCustomObject]@{
                count = 2
            }
        }
        It "should error when user count is not equal to 1" {
            {Remove-DVADUser -username 'bob'} | Should -Throw
        }
    }
    context "succeeds as it should" {
        Mock Get-ADUser {
            [PSCustomObject]@{
                count         = 1
                HomeDirectory = '\\fs\site1\shares\hds\bsmith'
            }
        }
        Mock Set-ADUser
        Mock Test-Path { $true }
        Mock Rename-Item
        it "build the correct deprovisioned directory name" {
            $null = Remove-DVADUser -username 'bob'
            Assert-MockCalled -CommandName 'Set-ADUser' -Times 2 -Exactly -Scope It
            Assert-MockCalled -CommandName 'Rename-Item' -Times 1 -Exactly -Scope It -ParameterFilter {$NewName -eq 'bs_deprovisioned'}
        }
        It "returns true when all goes well" {
            Remove-DVADUser -username 'bob' | Should -Be $true
        }
    }
}