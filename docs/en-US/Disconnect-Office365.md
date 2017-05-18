---
Function Name: Connect-Office365
Download Help Link: https://github.com/PhilipHaglund/Office365Connect/blob/master/docs/en-US/Disconnect-Office365.md
Help Version: 1.0.0
Locale: en-US
---

# Disconnect-Office365

## SYNOPSIS
Disconnect from one or more Office 365 services using Powershell.

## SYNTAX

```
Disconnect-Office365 [[-Service] <String[]>] [-WhatIf] [-Confirm]
```

## DESCRIPTION
Disconnect from one or more Office 365 services using Powershell.
Some services requires the installation of separate PowerShell modules or binaires:
AzureAD requires a separate module - https://www.powershellgallery.com/packages/AzureAD/ or cmdlet "Install-Module -Name AzureAD"
MsolService requraes a seprate module - http://go.microsoft.com/fwlink/?linkid=236297
Sharepoint Online requires a separate module - https://www.microsoft.com/en-us/download/details.aspx?id=35588
Skype for Business Online requires a separate module - https://www.microsoft.com/en-us/download/details.aspx?id=39366
Exchange Online, Exchange Online Protection, Complince Center does not require seperate binaries.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Disconnect-Office365
```

VERBOSE: Disconnecting from all Office 365 Services.

This command disconnects from all Office 365 service sessions that are available and running.

### -------------------------- EXAMPLE 2 --------------------------
```
Disconnect-Office365 -Service ComplianceCenter, ExchangeOnline, AzureAD
```

VERBOSE: Disconnecting from AzureAD.
VERBOSE: Azure AD Session is now closed.
VERBOSE: Disconnecting from Compliance Center.
VERBOSE: The Compliance Center Online PSSession is now closed.
VERBOSE: Disconnecting from Exchange Online.
VERBOSE: The Exchange Online PSSession is now closed.

This command disconnects from AzureAD, Compliance Center and Exchange Online service sessions that are available and running.

## PARAMETERS

### -Service
Provide one or more Office 365 services to disconnect from.
Valid values are:
'AllServices', 'AzureAD', 'ComplianceCenter', 'ExchangeOnline', 'ExchangeOnlineProtection', 'MSOnline', 'SharepointOnline' ,'SkypeforBusinessOnline'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: @('AllServices')
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

