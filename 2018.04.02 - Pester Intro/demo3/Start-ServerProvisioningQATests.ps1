$domain     = 'ad.piccola.us'
$timezone   = 'Mountain Standard Time'
$adsite     = '587SL'
$services   = @('bits','puppet','eventlog')
$dnsServers = @('10.0.3.21','10.0.3.22','8.8.8.8','8.8.4.4')
$packages   = @('Microsoft Network Monitor 3.4','Microsoft Web Deploy 3.6','Puppet Development Kit')
$disks      = @(
    @{Number = 0; PartitionStyle = 'GPT'; LogicalSectorSize = '512'; ProvisioningType = 'Fixed'}
    @{Number = 1; PartitionStyle = 'Raw'; LogicalSectorSize = '0'; ProvisioningType = 'Fixed'}
)

Describe "Server Provisioning QA Tests" {
    Context "Domain checks" {
        It "should be a member of $domain" {
            (Get-WmiObject -Class win32_computersystem).domain | Should -Be $domain
        }
        it "should be in $timezone timezone" {
            (Get-WmiObject -Class win32_timezone -Property standardname).StandardName | Should -Be $timezone
        }
        it "should be in AD site $adSite" {
            (& nltest /dsgetsite | Select-Object -First 1) | Should -Be $adSite
        }
    }
    Context "Software checks" {
        $software = Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"

        It "the software Microsoft Network Monitor 3.4 should be installed" {
            ($software | Where-Object{$_.DisplayName -eq 'Microsoft Network Monitor 3.4'}).DisplayName | should -Be 'Microsoft Network Monitor 3.4'
        }
        It "the software Microsoft Web Deploy 3.6 should be installed" {
            ($software | Where-Object{$_.DisplayName -eq 'Microsoft Web Deploy 3.6'}).DisplayName | should -Be 'Microsoft Web Deploy 3.6'
        }
        It "the software Puppet Development Kit should be installed" {
            ($software | Where-Object{$_.DisplayName -eq 'Puppet Development Kit'}).DisplayName | should -Be 'Puppet Development Kit'
        }

        foreach ($package in $packages) {
            It "the software $package should be installed" {
                ($software | Where-Object{$_.DisplayName -eq $package}).DisplayName | should -Be $package
            }
        }
    }
    Context "Networking checks" {
        $activeAdapterIPConfig = Get-NetIPConfiguration | Where-Object{$_.IPv4DefaultGateway -ne $null}
        $activeAdapterDNSSettings = $activeAdapterIPConfig | Get-DnsClientServerAddress -AddressFamily IPv4

        $i = 0
        foreach ($dnsServer in $dnsServers) {
            It "it should have the DNS #$($i + 1) address of $($dnsServers[$i])" {
                $activeAdapterDNSSettings.ServerAddresses[$i] | Should -Be $dnsServers[$i]
            }
            $i++
        }               
    }
    Context "Storage checks" {
        $getDisks = Get-Disk

        It "it should have $($disks.count) disks" {
            $getDisks.count | should -Be $disks.count
        }
        foreach ($disk in $disks) {
            $thisDisk = $getDisks | Where-Object{$_.Number -eq $disk.number}

            It "Number:$($disk.number)`t PartitionStyle should be $($disk.PartitionStyle)" {
                $thisDisk.PartitionStyle | should -Be $disk.PartitionStyle
            }
            It "Number:$($disk.number)`t LogicalSectorSize should be $($disk.LogicalSectorSize)" {
                $thisDisk.LogicalSectorSize | should -Be $disk.LogicalSectorSize
            }
            It "Number:$($disk.number)`t ProvisioningType should be $($disk.ProvisioningType)" {
                $thisDisk.ProvisioningType | should -Be $disk.ProvisioningType
            }
        }
    }
    Context "Services checks" {
        foreach ($service in $services) {
            it "the service $service should be running" {
                (Get-Service -Name $service).Status | Should -Be 'Running'
            }
        }
    }
    Context "Local user checks" {
        It "the provisioning user vagrant does not exist" {
            {Get-LocalUser -Name vagrant -ErrorAction Stop} | should -Throw
        }
        It "the provisioning user svc_builder does not exist" {
            {Get-LocalUser -Name svc_builder -ErrorAction Stop} | should -Throw
        }
        It "built-in local administrator has been renamed" {
            (Get-LocalUser | Where-Object{$_.sid -like "*-500"}).name | should -Be 'administrator'
        }
        it "local administrators group should contain AD\Domain Admins (method #1)" {
            (Get-LocalGroupMember -Group 'administrators' | Select-Object -ExpandProperty name) -contains 'AD\Domain Admins' | should -be $true
        }
        it "local administrators group should contain AD\Domain Admins (method #2)" {
            (Get-LocalGroupMember -Group 'administrators' | Select-Object -ExpandProperty name) | should -Contain 'AD\Domain Admins'
        }
        it "local administrators group should not contain AD\HelpDesk #2" {
            (Get-LocalGroupMember -Group 'administrators' | Select-Object -ExpandProperty name) | should -Not -Contain 'AD\HelpDesk'
        }
    }
}