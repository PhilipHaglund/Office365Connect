function DisconnectSfBOnline {
    [CmdletBinding()]
    param ()

    try {
        if ($null -ne ($SbfoSession = Get-SfBOnlineSession)) {
            Remove-PSSession -Session ($SbfoSession) -ErrorAction Stop
            Remove-Module -Name 'SkypeOnlineConnector' -Force -ErrorAction Stop
            Write-Verbose -Message 'The Skype for Business Online PSSession is now closed.' -Verbose
        }
    }
    catch {
        Write-Warning -Message ('Unable to remove PSSession for Skype for Business Online - {0}' -f $_.Exception.Message)
        return
    }
}