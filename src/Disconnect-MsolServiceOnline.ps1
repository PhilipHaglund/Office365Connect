function Disconnect-MsolServiceOnline {

    [CmdletBinding()]
    param ()

    try {

        if (Get-Module -Name 'MSOnline') {

            Remove-Module -Name 'MSOnline' -ErrorAction Stop -WarningAction SilentlyContinue
            Write-Verbose -Message 'MsolService Module is now closed.' -Verbose
        }
    }
    catch {

        Write-Warning -Message ('Unable to remove MsolService Module - {0}' -f $_.Exception.Message)
        return
    }    
}