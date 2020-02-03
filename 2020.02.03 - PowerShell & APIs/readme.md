# 2020.02.03 - PowerShell & APIs

## pushover

Pushover makes it easy to get real-time notifications on your Android, iPhone, iPad, and Desktop. API docs [here](https://pushover.net/api).

### Send a message

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

### Get an auth token

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

### Get an account

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

# puppet

