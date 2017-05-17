﻿function Connect-CCOnline {

    [CmdletBinding()]
    param(

        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Credentials in Azure AD to access Office 365.'
        )]
        [System.Management.Automation.Credential()]
        [pscredential]$Credential
    )

    if ($null -ne (Get-CCOnlineSession)) {

        if (Get-Command -Name 'Get-ComplianceSearch') {

            Write-Verbose -Message 'Compliance Center PowerShell session already existis.' -Verbose
            Write-Verbose -Message 'Disconnect from the current session to start a new one.'
            return
        }
    }

    try {

        $null = New-PSSession -ConfigurationName 'Microsoft.Exchange' `
                -AllowRedirection:$true `
                -WarningAction SilentlyContinue
    }
    catch {

        Write-Warning -Message ('Unable to create PSSession to Compliance Center - {0}' -f $_.Exception.Message)
        return
    }

    try {

        $null = Import-Module `
                -DisableNameChecking `
                -Global `
                -ErrorAction Stop `
    }
    catch {

        Write-Warning -Message ('Unable to load PSSession for Compliance Center - {0}' -f $_.Exception.Message)
        return
    }
}