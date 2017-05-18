function Connect-ExchangeOnline {

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

    if ($null -ne (Get-ExchangeOnlineSession)) {

        if (Get-Command -Name 'Get-Mailbox' -ErrorAction SilentlyContinue) {

            Write-Verbose -Message 'Exchange Online PowerShell session already existis.' -Verbose
            Write-Verbose -Message 'Disconnect from the current session to start a new one.'
            return
        }
        else
        {
            Write-Warning -Message 'Exchange Online is not available on the target Office 365 tenant'
            return
        }
    }

    try {

        $null = New-PSSession -ConfigurationName Microsoft.Exchange `                -Name 'ExchangeOnline' `                -ConnectionUri 'https://outlook.office365.com/powershell-liveid/' `                -Credential $Credential `                -Authentication Basic `                -AllowRedirection `                -ErrorAction Stop `                -WarningAction SilentlyContinue `
                -Verbose:$false
    }
    catch {

        Write-Warning -Message ('Unable to create PSSession to Exchange Online - {0}' -f $_.Exception.Message)
        return
    }

    try {

        $null = Import-Module `                (Import-PSSession -Session (Get-ExchangeOnlineSession) -DisableNameChecking -AllowClobber -ErrorAction Stop -WarningAction SilentlyContinue -Verbose:$false) `                -DisableNameChecking `                -Global `                -ErrorAction Stop `                -WarningAction SilentlyContinue `
                -Verbose:$false
    }
    catch {

        Write-Warning -Message ('Unable to load PSSession for Exchange Online - {0}' -f $_.Exception.Message)
        return
    }
}