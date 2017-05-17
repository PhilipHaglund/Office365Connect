function DisconnectCCOnline {
    [CmdletBinding()]
    param ()

    try {
        if ($null -ne ($ccsession = Get-CCOnlineSession)) {
            Remove-PSSession -Session ($ccsession) -ErrorAction Stop
            Write-Verbose -Message 'The Compliance Center Online PSSession is now closed.' -Verbose
        }        
    }
    catch {
        Write-Warning -Message ('Unable to remove PSSession for Compliance Center - {0}' -f $_.Exception.Message)
        return
    }          
}