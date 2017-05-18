---
external help file: Office365Connect-help.xml
online version: https://github.com/PhilipHaglund/Office365Connect/
https://gonjer.com/
schema: 2.0.0
---

# Connect-Office365

## SYNOPSIS
Connect to one or more Office 365 services using Powershell.

## SYNTAX

```
Connect-Office365 [[-Service] <String[]>] [-WhatIf] [-Confirm]
```

## DESCRIPTION
Connect to one or more Office 365 services using Powershell and a Azure AD account.
Some services requires the installation of separate PowerShell modules or binaries:
AzureAD requires a separate module - https://www.powershellgallery.com/packages/AzureAD/ or cmdlet "Install-Module -Name AzureAD"
MsolService requires a separate module - http://go.microsoft.com/fwlink/?linkid=236297
Sharepoint Online requires a separate module - https://www.microsoft.com/en-us/download/details.aspx?id=35588
Skype for Business Online requires a separate module - https://www.microsoft.com/en-us/download/details.aspx?id=39366
Exchange Online, Exchange Online Protection, Complince Center does not require seperate binaries.

DYNAMIC PARAMETERS
-SharepointDomain \<String\>
    Parameter available when the Service parameter contains AllService or SharepointOnline.
    The SharepointDomain parameter is necessary when connecting to Sharepoint Online sessions ('https://{0}-admin.sharepoint.com' -f $SharepointDomain).
    Example for SharepointDomain can be 'Contoso'.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Connect-Office365
```

VERBOSE: Conncting to AzureAD.
VERBOSE: Conncting to MSolService.

This command connects to AzureAD and MsolService service sessions using the credentials provided when prompted.
AzureAD and MsolService are the default parameter values for the parameter Services.

### -------------------------- EXAMPLE 2 --------------------------
```
Connect-Office365 -Service ComplianceCenter, ExchangeOnline, AzureAD
```

VERBOSE: Conncting to AzureAD.
VERBOSE: Conncting to Compliance Center.
VERBOSE: Conncting to Exchange Online.

This command connects to AzureAD, ComplianceCenter and ExchageOnline service sessions using the credentials provided when prompted.

### -------------------------- EXAMPLE 3 --------------------------
```
Connect-Office365 -Service AzureAD, SharepointOnline
```

cmdlet Connect-Office365 at command pipeline position 1
Supply values for the following parameters:
(Type !?
for Help.)
SharepointDomain: Contoso

VERBOSE: Conncting to AzureAD.
VERBOSE: Conncting to Sharepoint Online.

This command connect to AzureAD and SharepointOnline.
SharepointOnline session requires a specified URI when connecting.
In this example, Contoso, is provided at the mandatory prompt parameter, SharepointDomain.

### -------------------------- EXAMPLE 4 --------------------------
```
Connect-Office365 -Service AllServices -SharepointDomain Contoso
```

VERBOSE: Connecting to all Office 365 Services.

This command connects to all Office 365 service sessions using the credentials provided when prompted.
The parameter SharepointDomain is explicit provided to avoid the mandatory parameter prompt.

## PARAMETERS

### -Service
Provide one or more Office 365 services to connect to.
Valid values are:
'AllServices', 'AzureAD', 'ComplianceCenter', 'ExchangeOnline', 'ExchangeOnlineProtection', 'MSOnline', 'SharepointOnline' ,'SkypeforBusinessOnline'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: @('AzureAD','MSOnline')
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/PhilipHaglund/Office365Connect/
https://gonjer.com/](https://github.com/PhilipHaglund/Office365Connect/
https://gonjer.com/)

