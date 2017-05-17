function Get-AzureADCredential {
    
    [OutputType([bool], [PSCredential])]
    [CmdletBinding()]
    param (
        # Maximum amount of Azure Credential tries.
        [uint16]$MaxTry = 3
    )
    
    $Regex = "[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"

    try {

        $Counter = 1
        do {
        
            $AzureADCredential = Get-Credential -Message 'UserPrincipalName in Azure AD to access Office 365.'
            
            if ($AzureADCredential -match $Regex) {
                
                Write-Verbose -Message 'Credential match'
                return $AzureADCredential
            }
            if ($Counter -lt $MaxTry) {
        
                Write-Verbose -Message 'Credentials does not match a valid UserPrincipalName in AzureAD, please provide a corrent UserPrincipalName.' -Verbose
                Write-Verbose -Message ('Try {0} of {1}' -f $Counter, $MaxTry) -Verbose
            }
            elseif ($Counter -ge $MaxTry) {
                
                Write-Verbose -Message ('Try {0} of {1}' -f $Counter, $MaxTry) -Verbose
                Write-Error -Message 'Credentials does not match a UserPrincipalName in AzureAD' -Exception 'System.Management.Automation.SetValueException' -Category InvalidResult -ErrorAction Stop
                break
            }

            $Counter++
        }
        # Regular expression for a valid UserPrincipalName.
        while ($AzureADCredential.UserName -notmatch $Regex)
        #"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
    }
    catch {

        Write-Verbose -Message ('Problem with Credentials - {0}' -f $_.Exception.Message)
        return $false
    }
}