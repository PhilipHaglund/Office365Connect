function Disconnect-AzureADOnline {

    [CmdletBinding()]
    param ()
    
    try {

        Disconnect-AzureAD -ErrorAction Stop
        Remove-Module -Name AzureAD -Force -ErrorAction Stop
        Write-Verbose -Message 'Azure AD Session is now closed.' -Verbose
    }
    catch {

        Write-Warning -Message ('Unable to remove AzureAD Session - {0}' -f $_.Exception.Message)
        return
    }    
}