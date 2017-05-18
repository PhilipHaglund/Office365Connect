function Disconnect-ExchangeOnline {

    [CmdletBinding()]
    param ()

    try {
        
        $EXOnline = Get-ExchangeOnlineSession

        if ($null -ne $EXOnline) {

            Remove-PSSession -Session ($EXOnline) -ErrorAction Stop
            Write-Verbose -Message 'The Exchange Online PSSession is now closed.' -Verbose
        }
    }
    catch {

        Write-Warning -Message ('Unable to remove PSSession for Exchange Online - {0}' -f $_.Exception.Message)
        return
    }       
}