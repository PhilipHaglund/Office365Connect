function Disconnect-CCOnline {

    [CmdletBinding()]
    param ()

    try {
        
        $CCOSession = Get-CCOnlineSession

        if ($null -ne $CCOSession) {

            Remove-PSSession -Session ($CCOSession) -ErrorAction Stop
            Write-Verbose -Message 'The Compliance Center Online PSSession is now closed.' -Verbose
        }        
    }
    catch {

        Write-Warning -Message ('Unable to remove PSSession for Compliance Center - {0}' -f $_.Exception.Message)
        return
    }          
}