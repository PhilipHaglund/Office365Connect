function Get-AzureADCredential {

    [CmdletBinding()]
    param (
        # Maximum amount of Azure Credential tries.
        [uint16]$MaxTry = 3
    )
        
    try {

        if ($null -eq $AzureADCredentials) {

            $Counter = 0
            do {

                $AzureADCredentials = Get-Credential -Message 'UserPrincipalName in Azure AD to access Office 365.'                
                if ($Counter -gt 0 -and $Counter -le $MaxTry) {
                    Write-Verbose -Message 'Credentials does not match a valid UserPrincipalName in AzureAD, please provide a corrent UserPrincipalName.' -Verbose
                    Write-Verbose -Message ('Try {0} of {1}' -f $Counter,$MaxTry) -Verbose
                }
                elseif ($Counter -ge $MaxTry) {

                    Write-Error -Message 'Credentials does not match a UserPrincipalName in AzureAD' -Exception 'System.Management.Automation.SetValueException' -Category InvalidResult -ErrorAction Stop
                    break
                }

                $Counter++
            }
            # Regular expression for a valid UserPrincipalName.
            while ($AzureADCredentials.UserName -notmatch `
            "[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")


        }
    }
    catch {

        Write-Verbose -Message ('Problem with Credentials - {0}' -f $_.Exception.Message)
        return $false
    }
}