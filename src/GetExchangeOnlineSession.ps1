function GetExchangeOnlineSession {
    [CmdletBinding()]
    param ()

    try {
        $session = Get-PSSession -ErrorAction Stop | Where-Object -FilterScript {
            $_.ComputerName -match 'outlook.office365.com' -and $_.ConfigurationName -eq 'Microsoft.Exchange'
        }
    }
    catch {
        Write-Warning -Message ('Unable to get active Exchange Online PSSession - {0}' -f $_.Exception.Message)
        return $null
    }

    return $session
}