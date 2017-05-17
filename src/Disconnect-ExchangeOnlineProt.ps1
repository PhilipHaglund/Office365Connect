function Disconnect-ExchangeOnlineProt {

    [CmdletBinding()]
    param ()

    try {
        
        $EXOProtnline = Get-ExchangeOnlineProtSession

        if ($null -ne $EXOProtnline) {

            Remove-PSSession -Session ($EXOProtnline) -ErrorAction Stop
            Write-Verbose -Message 'The Exchange Online Protection PSSession is now closed.' -Verbose
        }
    }
    catch {

        Write-Warning -Message ('Unable to remove PSSession for Exchange Online Protection - {0}' -f $_.Exception.Message)
        return
    }       
}