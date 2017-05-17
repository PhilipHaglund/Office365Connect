﻿function Connect-CCOnline {

    [CmdletBinding()]
    param(        
        [System.Management.Automation.Credential()]
        [pscredential]$Credential = [pscredential]::Empty  
    )

    if ($null -ne (Get-CCOnlineSession)) {

        if (Get-Command -Name 'Get-ComplianceSearch') {

            Write-Verbose -Message 'Compliance Center PowerShell session already existis.' -Verbose
            Write-Verbose -Message 'Disconnect from the current session to start a new one.'
            return
        }
    }

    try {

        $null = New-PSSession -ConfigurationName 'Microsoft.Exchange' `                -ConnectionUri 'https://ps.compliance.protection.outlook.com/powershell-liveid/' `                -Credential $Credential `                -Authentication Basic `
                -AllowRedirection:$true `                -ErrorAction Stop `
                -WarningAction SilentlyContinue
    }
    catch {

        Write-Warning -Message ('Unable to create PSSession to Compliance Center - {0}' -f $_.Exception.Message)
        return
    }

    try {

        $null = Import-Module `                (Import-PSSession -Session (Get-CCOnlineSession) -DisableNameChecking -AllowClobber -ErrorAction Stop -WarningAction SilentlyContinue) `
                -DisableNameChecking `
                -Global `
                -ErrorAction Stop `                -WarningAction SilentlyContinue
    }
    catch {

        Write-Warning -Message ('Unable to load PSSession for Compliance Center - {0}' -f $_.Exception.Message)
        return
    }
}