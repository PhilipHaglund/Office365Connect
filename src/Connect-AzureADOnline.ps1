﻿function Connect-AzureADOnline {

    [CmdletBinding()]
    param(
        
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Credentials in Azure AD to access Office 365.'
        )]
        [System.Management.Automation.Credential()]
        [pscredential]$Credential
    )

    $Module = Get-Module -Name AzureAD -ListAvailable

    if ($null -eq $Module) {

        Write-Warning -Message "Requires the module 'AzureAD' to Connect to AzureAD"
        Write-Verbose -Message 'Download from: https://www.powershellgallery.com/packages/AzureAD/ or cmdlet "Install-Module -Name AzureAD"' -Verbose
        return
    }
    else {

        try {

            Import-Module -Name 'AzureAD' -DisableNameChecking -ErrorAction Stop -WarningAction SilentlyContinue
        }
        catch {

            Write-Warning -Message ('Unable to Import-Module "AzureAD" - {0}' -f $_.Exception.Message)
            return
        }

        try {

            $null = Connect-AzureAD -Credential $Credential -ErrorAction Stop -WarningAction SilentlyContinue
        }
        catch {

            Write-Warning -Message ('Unable to connect to AzureAD - {0}' -f $_.Exception.Message)
            return
        }
    }
}