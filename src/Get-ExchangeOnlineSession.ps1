function Get-ExchangeOnlineSession {

    [CmdletBinding()]
    param ()

    try {
    
        Get-PSSession -ErrorAction Stop | Get-OnlinePSSession -FilterComputerName outlook.office365.com -FilterConfigurationName Microsoft.Exchange -FilterSessionName 'ExchangeOnline'
    }
    catch {
    
        Write-Warning -Message ('Unable to get active Exchange Online PSSession - {0}' -f $_.Exception.Message)
        return $null
    }
}