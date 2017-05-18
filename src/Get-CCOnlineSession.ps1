function Get-CCOnlineSession {

    [CmdletBinding()]
    param ()

    try {

        Get-PSSession -ErrorAction Stop | Get-OnlinePSSession -FilterComputerName Compliance -FilterConfigurationName Microsoft.Exchange -FilterSessionName CCOnline
    }
    catch {

        Write-Warning -Message ('Unable to get active Compliance Center Online PSSession - {0}' -f $_.Exception.Message)
        return $null
    }  
}