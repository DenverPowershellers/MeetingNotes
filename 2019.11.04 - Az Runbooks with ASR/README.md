# Brief look at Azure Runbooks with Azure Site Recovery (ASR)

## What is ASR?

ASR is a DRaaS tool from Microsoft

Can be used to:

* Orchestrate replication and disaster recovery of VMs
* Perform "lift and shift" migrations of VMs

Works with VMware, Hyper-V, physical hosts, and within Azure

![](.\assets\migrate-to-premium-storage-using-azure-site-recovery-1.png)

## What are Azure Runbooks?

* Component of Azure Automation Accounts
* Automates frequent, time-consuming, and error-prone cloud management tasks
* Can be created graphically, with PowerShell, or with Python
* Can be scheduled, chained together, ran on-demand by other services, or manually

## Scenario

* ASR to failover a public facing web server
  * Only moves VMs, no supporting network infra or IPs
* Need to automate assignment of a new public IP in the failover region

## Demo

* Show ASR UI, esp. recovery plan steps
* Show VM ID
* Start failover

## Quick Automation Account tour

* Schedules
* Modules
* Variables
* Runbooks

## Demo sample Runbook

* `Get-AutomationConnection`
  * Get service principal info
* `Get-AutomationVariable`
  * Get variables stored in Automation Account

## Public IP Runbook walkthrough

* Similar to writing script files
* ASR job passes in `$RecoveryPlanContext` parameter
```json
{
    "RecoveryPlanName":"DemoRecovPlan-EastToWest",
    "FailoverType":"Unplanned",
    "FailoverDirection":"PrimaryToSecondary",
    "GroupId":"Group1",
    "VmMap":{
        "3a28506f-54a8-4a40-a13e-edf87c925f29":{
            "SubscriptionId":"bcaf33ad-be01-4a74-adc5-0e622e2e4c49",
            "ResourceGroupName":"AsrDemoFailover-rg",
            "CloudServiceName":null,
            "RoleName":"ASRwebSrv0",
            "RecoveryPointId":"fa7b70e1-f6ac-40f7-b6fd-8bbea89814ed",
            "RecoveryPointTime":"\/Date(1572017362584)\/"
        },
        "973bc9a2-fdf7-426a-9d5f-2f8f7ae61755":{
            "SubscriptionId":"bcaf33ad-be01-4a74-adc5-0e622e2e4c49",
            "ResourceGroupName":"AsrDemoFailover-rg",
            "CloudServiceName":null,
            "RoleName":"ASRsqlSrv14",
            "RecoveryPointId":"fa7b70e1-f6ac-40f7-b6fd-8bbea89814ed",
            "RecoveryPointTime":"\/Date(1572017361415)\/"
        }
    }
}
```