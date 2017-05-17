function DisconnectExchangeOnline {
    [CmdletBinding()]
    param ()

    try {
        if ($null -ne ($exonline = Get-ExchangeOnlineSession)) {
            Remove-PSSession -Session ($exonline) -ErrorAction Stop
            Write-Verbose -Message 'The Exchange Online PSSession is now closed.' -Verbose
        }
    }
    catch {
        Write-Warning -Message ('Unable to remove PSSession for Exchange Online - {0}' -f $_.Exception.Message)
        return
    }       
}