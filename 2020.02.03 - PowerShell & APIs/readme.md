# 2020.02.03 - PowerShell & APIs

## pushover

Pushover makes it easy to get real-time notifications on your Android, iPhone, iPad, and Desktop. API docs [here](https://pushover.net/api).

### send a message

```powershell
$uri = "https://api.pushover.net/1/messages.json"
$body = @{
  token   = "*"
  user    = "*"
  message = "Hello from PowerShell"
}
Invoke-RestMethod -Uri $uri -Method Post -Body $body
```

OUTPUT

```plaintext
status request
------ -------
     1 aGUID
```

## cyberark

CyberArk is the global leader in privileged access management, a critical layer of IT security to protect data, infrastructure and assets across the enterprise, in the cloud and throughout the DevOps pipeline. API docs [here](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/API%20Commands.htm).

### get an auth token

[auth docs](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/CyberArkAuthentication-Logon.htm)

```powershell
$uri = "https://$cyberArkServer/PasswordVault/WebServices/auth/Cyberark/CyberArkAuthenticationService.svc/Logon"
$body = @{
  username                = "*"
  password                = "*"
  useRadiusAuthentication = "false"
} | ConvertTo-Json
$authResult = Invoke-RestMethod -Uri $uri -Method Post -Body $body -ContentType "application/json"
Write-Output $authResult
```

OUPUT

```plaintext
CyberArkLogonResult
-------------------
aSecret
```

### get an account

[get docs](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Get%20Account%20Details%20(up%20to%20v9.10).htm)

```powershell
$authHeader = @{
    "Authorization" = $authResult.CyberArkLogonResult
    "Content-Type"  = "application/json"
}
$safe = 'aSafe'
$serverHostname = 'aServer.aSLD.aTLD'
$uri = "https://$cyberArkServer/PasswordVault/WebServices/PIMServices.svc/Accounts?Keywords=$serverHostname`&Safe=$safe"
$searchResult = Invoke-RestMethod -Uri $uri -Method Get -Headers $authHeader
```

OUTPUT
```powershell
$searchResult
Count accounts
----- --------
    1 {@{AccountID=123_4567; InternalProperties=System.Object[]; Properties=System.Object[]}}
```

OUTPUT
```powershell
$searchResult.accounts.properties
Key        Value
---        -----
Safe       aSafe
Folder     Root
Name       Operating System-WindowsServerLocalAccounts-Managed-aServer-administrator
UserName   administrator
DeviceType Operating System
PolicyID   WinServerLocal_TST
Address    aServer.aSLD.aTLD
```

## puppet

Make infrastructure delivery and management reliable, fast, and drama-free. Puppet Enterprise delivers continuous enforcement of security and compliance policies...

### get an auth token

[auth docs](https://puppet.com/docs/pe/2017.3/rbac_api_v1_token.html#token-endpoints-api-v1)

```powershell
$puppetMaster = 'puppet.contoso.com'
$body = @{
  login       = '*'
  password    = '*'
  lifetime    = '1d'
  description = "Token used for testing puppet tasks"
  client      = ""
  label       = "personal workstation token"
} | ConvertTo-Json

$uri = "https://$puppetMaster`:4433/rbac-api/v1/auth/token"
$result  = Invoke-RestMethod -Uri $uri -Method Post -Body $body -ContentType 'application/json'
Write-Output $result
```

OUTPUT

```plaintext
token
-----
aSecret
```

### get tasks

[auth headers](https://puppet.com/docs/pe/2017.3/rbac_token_auth_intro.html#use_a_token_with_the_pe_api_endpoints)

[orchestrator api doc](https://puppet.com/docs/pe/2019.3/orchestrator_api_forming_requests.html)

[orchestrator\tasks api doc](https://puppet.com/docs/pe/2019.3/orchestrator_api_tasks_endpoint.html)

```powershell
$headers = @{
    'X-Authentication' = $result.token
}
$uri = "https://$master`:8143/orchestrator/v1/tasks"
$body = @{
    'environment' = $environment
}
Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -Body $body
```

## NetIQ/DRA

Directory and Resource Administrator delivers secure and efficient privileged-identity administration of Microsoft Active Directory (AD).

### get a computer object in AD

[impossible to find docs, pg. 29](https://www.netiq.com/documentation/directory-and-resource-administrator-9/pdfdoc/DRARESTServicesTechnicalReference/DRARESTServicesTechnicalReference.pdf)

```powershell
$uri = "https://$draServer`:$draServerPort/dra/domains/$windomain/computers/get"
$body = @{
  computerIdentifier = 'aServer'
} | ConvertTo-Json
Invoke-RestMethod -Uri $uri -Method Post -Body $body -Credential $credential -ContentType 'application/json'
```

### create a computer object in AD

[impossible to find docs, pg. 27](https://www.netiq.com/documentation/directory-and-resource-administrator-9/pdfdoc/DRARESTServicesTechnicalReference/DRARESTServicesTechnicalReference.pdf)

```powershell
$uri = "https://$draServer`:$draServerPort/dra/domains/$windomain/computers/post"
$body = @{
  computer = @{
    name               = 'aServer'
    friendlyParentPath = 'aDomain/aOU/anotherOU'
    isDisabled         = $false
  }
} | ConvertTo-Json
Invoke-RestMethod -Uri $uri -Method Post -Body $body -Credential $credential -ContentType 'application/json'
```

## thecatapi

A public service API all about Cats, free to use when making your fancy new App, Website or Service. [API docs](https://docs.thecatapi.com/).

### get the breeds

[auth docs](https://docs.thecatapi.com/authentication)

[breeds docs](https://docs.thecatapi.com/api-reference/breeds/breeds-list)

```powershell
$uri = 'https://api.thecatapi.com/v1/breeds'
$headers = @{
    'x-api-key' = '*'
}
$result = Invoke-RestMethod -Headers $headers -Uri $uri -Method Get
```

OUTPUT

```plaintext
$result.count
67
$result[20]
weight            : @{imperial=7 - 15; metric=3 - 7}
id                : chau
name              : Chausie
temperament       : Affectionate, Intelligent, Playful, Social
origin            : Egypt
country_codes     : EG
description       : For those owners who desire a feline capable of evoking the great outdoors, the strikingly beautiful Chausie retains a bit of the wild in its appearance but has the house manners of our friendly, familiar moggies. Very playful, this cat needs a large amount of space to be able to fully embrace its hunting instincts.
life_span         : 12 - 14
alt_names         : Nile Cat
wikipedia_url     : https://en.wikipedia.org/wiki/Chausie
...
..
.
```
