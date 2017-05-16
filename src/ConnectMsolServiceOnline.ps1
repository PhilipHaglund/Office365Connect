function ConnectMsolServiceOnline {
    [CmdletBinding()]
    param ()

    $Module = Get-Module -Name 'MSOnline' -ListAvailable
    if ($null -eq $Module) {
        Write-Warning -Message "Requires the module 'MSOnline' to Connect to MsolService"
        Write-Verbose -Message 'Download from: http://go.microsoft.com/fwlink/?linkid=236297' -Verbose
        return
    }
    else {
        try {
            Import-Module -Name 'MSOnline' -DisableNameChecking -ErrorAction Stop -WarningAction SilentlyContinue
        }
        catch {
            Write-Warning -Message ('Unable to Import-Module "MSOnline" - {0}' -f $_.Exception.Message)
            return
        }

        try {
            Connect-MsolService -Credential $Script:AzureADCredentials -ErrorAction Stop -WarningAction SilentlyContinue
        }
        catch {
            Write-Warning -Message ('Unable to connect to MSOnline - {0}' -f $_.Exception.Message)
            return
        }
    }
}