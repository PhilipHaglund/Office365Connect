function GetSfBOnlineSession {
    [CmdletBinding()]
    param ()

    try {
        $Session = Get-PSSession -ErrorAction Stop | Where-Object -FilterScript {
            $_.ComputerName -match 'online.lync.com' -and $_.ConfigurationName -eq 'Microsoft.PowerShell'
        }
        $Session
    }
    catch {
        Write-Warning -Message ('Unable to get active Exchange Online PSSession - {0}' -f $_.Exception.Message)
        return $null
    }
}