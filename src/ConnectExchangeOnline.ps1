function ConnectExchangeOnline {
    [CmdletBinding()]
    param ()

    if ($null -ne (Get-ExchangeOnlineSession)) {        
        if (Get-Command -Name 'Get-Mailbox') {
            Write-Verbose -Message 'Exchange Online PowerShell session already existis.' -Verbose
            return
        }
    }
    try {
        $null = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri 'https://outlook.office365.com/powershell-liveid/' -Credential $Script:AzureADCredentials -Authentication Basic -AllowRedirection -WarningAction SilentlyContinue -ErrorAction Stop
    }
    catch {
        Write-Warning -Message ('Unable to create PSSession to Exchange Online - {0}' -f $_.Exception.Message)
        return
    }
    try {
        $null = Import-Module (Import-PSSession -Session (Get-ExchangeOnlineSession) -DisableNameChecking -AllowClobber -ErrorAction Stop -WarningAction SilentlyContinue) -DisableNameChecking -Global -ErrorAction Stop -WarningAction SilentlyContinue
    }
    catch {
        Write-Warning -Message ('Unable to load PSSession for Exchange Online - {0}' -f $_.Exception.Message)
        return
    }
}