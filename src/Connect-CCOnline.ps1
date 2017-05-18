function Connect-CCOnline {

    [CmdletBinding()]
    param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true,
            HelpMessage = 'Credentials in Azure AD to access Office 365.'
        )]
        [System.Management.Automation.Credential()]
        [PSCredential]$Credential
    )

    if ($null -ne (Get-CCOnlineSession)) {

        if (Get-Command -Name 'Get-ComplianceSearch') {

            Write-Verbose -Message 'Compliance Center PowerShell session already existis.' -Verbose
            Write-Verbose -Message 'Disconnect from the current session to start a new one.'
            return
        }
        else
        {
            Write-Warning -Message 'Compliance Center Online is not available on the target Office 365 tenant'
            return
        }
    }

    try {

        $null = New-PSSession -ConfigurationName 'Microsoft.Exchange' `                -Name 'CCOnline' `                -ConnectionUri 'https://ps.compliance.protection.outlook.com/powershell-liveid/' `                -Credential $Credential `                -Authentication Basic `
                -AllowRedirection:$true `                -ErrorAction Stop `
                -WarningAction SilentlyContinue `
                -Verbose:$false
    }
    catch {

        Write-Warning -Message ('Unable to create PSSession to Compliance Center - {0}' -f $_.Exception.Message)
        return
    }

    try {

        $null = Import-Module `                (Import-PSSession -Session (Get-CCOnlineSession) -DisableNameChecking -AllowClobber -ErrorAction Stop -WarningAction SilentlyContinue -Verbose:$false) `
                -DisableNameChecking `
                -Global `
                -ErrorAction Stop `                -WarningAction SilentlyContinue `                -Verbose:$false
    }
    catch {

        Write-Warning -Message ('Unable to load PSSession for Compliance Center - {0}' -f $_.Exception.Message)
        return
    }
}