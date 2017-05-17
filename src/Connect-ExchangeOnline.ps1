function Connect-ExchangeOnline {

    [CmdletBinding()]
    param(        
        [System.Management.Automation.Credential()]
        [pscredential]$Credential = [pscredential]::Empty  
    )

    if ($null -ne (Get-ExchangeOnlineSession)) {

        if (Get-Command -Name 'Get-Mailbox') {

            Write-Verbose -Message 'Exchange Online PowerShell session already existis.' -Verbose
            Write-Verbose -Message 'Disconnect from the current session to start a new one.'
            return
        }
    }

    try {

        $null = New-PSSession -ConfigurationName Microsoft.Exchange `                -ConnectionUri 'https://outlook.office365.com/powershell-liveid/' `                -Credential $Credential `                -Authentication Basic `                -AllowRedirection `                -ErrorAction Stop `                -WarningAction SilentlyContinue
    }
    catch {

        Write-Warning -Message ('Unable to create PSSession to Exchange Online - {0}' -f $_.Exception.Message)
        return
    }

    try {

        $null = Import-Module `                (Import-PSSession -Session (Get-ExchangeOnlineSession) -DisableNameChecking -AllowClobber -ErrorAction Stop -WarningAction SilentlyContinue) `                -DisableNameChecking `                -Global `                -ErrorAction Stop `                -WarningAction SilentlyContinue
    }
    catch {

        Write-Warning -Message ('Unable to load PSSession for Exchange Online - {0}' -f $_.Exception.Message)
        return
    }
}