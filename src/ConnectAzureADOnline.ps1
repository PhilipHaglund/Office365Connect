function Connect-AzureADOnline {
    [CmdletBinding()]
    param ()

    $module = Get-Module -Name AzureAD -ListAvailable
    if ($null -eq $module) {
        Write-Warning -Message "Requires the module 'AzureAD' to Connect to AzureAD"
        Write-Verbose -Message 'Download from: https://www.powershellgallery.com/packages/AzureAD/ or cmdlet "Install-Module -Name AzureAD"' -Verbose
        return
    }
    else {
        try {
            Import-Module -Name 'AzureAD' -DisableNameChecking -ErrorAction Stop -WarningAction SilentlyContinue
        }
        catch {
            Write-Warning -Message ('Unable to Import-Module "AzureAD" - {0}' -f $_.Exception.Message)
            return
        }

        try {            
            $null = Connect-AzureAD -Credential $Script:AzureADCredentials -ErrorAction Stop -WarningAction SilentlyContinue
        }
        catch {
            Write-Warning -Message ('Unable to connect to AzureAD - {0}' -f $_.Exception.Message)
            return
        }
    }
}