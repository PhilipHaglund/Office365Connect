function Disconnect-SPOnline {

    [CmdletBinding()]
    param ()

    try {

        $null = Disconnect-SPOService -ErrorAction Stop
        Remove-Module -Name 'Microsoft.Online.SharePoint.PowerShell' -Force -ErrorAction Stop
        Write-Verbose -Message 'The Sharepoint Online Session is now closed.' -Verbose
    }
    catch {

        if ($_.Exception.Message -notmatch 'There is no service currently connected') {

            Write-Warning -Message ('Unable to disconnect Sharepoint Online Session - {0}' -f $_.Exception.Message)
            return
        }
    }
}