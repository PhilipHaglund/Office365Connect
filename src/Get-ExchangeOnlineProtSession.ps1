function Get-ExchangeOnlineProtSession {

    [CmdletBinding()]
    param ()

    try {
    
        Get-PSSession -ErrorAction Stop | Get-OnlinePSSession -FilterComputerName 'protection' -FilterConfigurationName 'Microsoft.Exchange' -FilterSessionName 'ExchangeOnlineProt'
    }
    catch {
    
        Write-Warning -Message ('Unable to get active Exchange Online Protection PSSession - {0}' -f $_.Exception.Message)
        return $null
    }
}