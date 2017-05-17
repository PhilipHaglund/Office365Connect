function Get-SfBOnlineSession {

    [CmdletBinding()]
    param ()

    try {
    
        Get-PSSession -ErrorAction Stop | Get-OnlinePSSession -FilterComputerName 'online.lync.com' -FilterConfigurationName 'Microsoft.PowerShell'
    }
    catch {
    
        Write-Warning -Message ('Unable to get active Skype for Business Online PSSession - {0}' -f $_.Exception.Message)
        return $null
    }
}