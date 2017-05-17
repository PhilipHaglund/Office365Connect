﻿function Connect-ExchangeOnline {

    [CmdletBinding()]
    param(

        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Credentials in Azure AD to access Office 365.'
        )]
        [System.Management.Automation.Credential()]
        [pscredential]$Credential
    )

    if ($null -ne (Get-ExchangeOnlineSession)) {

        if (Get-Command -Name 'Get-Mailbox') {

            Write-Verbose -Message 'Exchange Online PowerShell session already existis.' -Verbose
            Write-Verbose -Message 'Disconnect from the current session to start a new one.'
            return
        }
    }

    try {

        $null = New-PSSession -ConfigurationName Microsoft.Exchange `
    }
    catch {

        Write-Warning -Message ('Unable to create PSSession to Exchange Online - {0}' -f $_.Exception.Message)
        return
    }

    try {

        $null = Import-Module `
    }
    catch {

        Write-Warning -Message ('Unable to load PSSession for Exchange Online - {0}' -f $_.Exception.Message)
        return
    }
}