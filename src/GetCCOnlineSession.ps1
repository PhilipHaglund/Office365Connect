function GetCCOnlineSession {
    [CmdletBinding()]
    param ()

    try {
        $session = Get-PSSession -ErrorAction Stop | Where-Object -FilterScript {$_.ComputerName -match 'Compliance' -and $_.ConfigurationName -eq 'Microsoft.Exchange'}
    }
    catch {
        Write-Warning -Message ('Unable to get active Compliance Center Online PSSession - {0}' -f $_.Exception.Message)
        return $null
    }
    
    return $session
}