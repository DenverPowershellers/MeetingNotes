[cmdletbinding()]
Param (
    [Parameter(Mandatory)]    
    [string[]]$templateNames
    ,
    [Parameter(Mandatory)]
    [pscredential]$vCenterCredential
    ,
    [Parameter(Mandatory)]
    [pscredential]$guestCredential
)

$ErrorActionPreference = 'stop'

foreach ($templateName in $templateNames) {
    try {
        Connect-VIServer -Server 'vcenter.ad.piccola.us' -Credential $vCenterCredential
        # get the current working template
        $template = Get-Template -Name $templateName

        switch ($template.count)
        {
            0 {
                Write-Error "No template was found for $templateName."
            }
            1 {
                # convert the template to a VM
                Set-Template -Template $template -ToVM -Confirm:$false
                # get the vm
                $vm = Get-VM -Name $templateName
                # power on the VM
                Start-VM -VM $vm
                # wait for VMware tools to become available
                Wait-Tools -VM $vm -TimeoutSeconds 300
                # sleep so the VM's networking can comeonline
                Start-Sleep -Seconds 10
                # invoke the test script
                Invoke-VMScript -VM $vm -GuestCredential $GuestCredential -ScriptType Powershell -ScriptText {dir} -ToolsWaitSecs 300 -OutVariable 'scriptOutput'
                # shutdown the VM
                Stop-VMGuest -VM $vm -Confirm:$false
                # some logic to wait for the VM to shutdown before it's converted back to a template
                $maxLoop = 5
                $loops = 0
                do {
                    if ($loops -ge $maxLoop) {
                        Write-Error "VM $($vm.name) PowerState never changed to PoweredOff, $loops of $maxLoop loops occured."
                    }
                    $getPowerState = Get-VM -Name $vm
                    Start-Sleep -Seconds 5
                    $loops++
                } while ($getPowerState.PowerState -eq 'PoweredOn')
                # convert the vm back to a template
                Set-VM -VM $vm -ToTemplate -Confirm:$false
            }
            {$PSItem -gt 1} {
                Write-Error "More than one vm was returned for $($template.name). (Count = $($template.count)x)"
            }
        }
    } catch {
        Write-Error $_.Exception.Message
    } finally {
        Disconnect-VIServer -Force -Confirm:$false
    }
}