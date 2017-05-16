function GetAzureADCredential {
    [CmdletBinding()]
    param ()
        
    try {
        if ($Script:AzureADCredentials -eq $false) {
            $Counter = 0
            do {
                $Script:AzureADCredentials = Get-Credential -Message 'UserPrincipalName in Azure AD to access Office 365.'                
                if ($Counter -gt 0 -and $Counter -lt 3) {
                    Write-Verbose -Message 'Credentials does not match a valid UserPrincipalName in AzureAD, please provide a corrent UserPrincipalName.' -Verbose
                }
                elseif ($Counter -gt 2) {
                    Write-Error -Message 'Credentials does not match a UserPrincipalName in AzureAD' -Exception 'System.Management.Automation.SetValueException' -Category InvalidResult -ErrorAction Stop
                    break
                }
                $Counter++
            }
            while ($Script:AzureADCredentials.UserName -notmatch "[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")            
        }
    }
    catch {
        return
    }

    return
}