function ConnectSfBOnline {
    [CmdletBinding()]
    param ()

    $Module = Get-Module -Name 'SkypeOnlineConnector' -ListAvailable
    if ($null -eq $Module) {
        Write-Warning -Message "Requires the module 'SkypeOnlineConnector'"
        Write-Verbose -Message 'Download from: https://www.microsoft.com/en-us/download/details.aspx?id=39366' -Verbose
        return
    }
    else {
        if ($null -ne (Get-SfBOnlineSession)) {
            Write-Verbose -Message 'Skype for Business Online PowerShell PSSession already existis.'
            return
        }
        try {
            Import-Module -Name 'SkypeOnlineConnector' -DisableNameChecking -ErrorAction Stop -WarningAction SilentlyContinue
        }
        catch {
            Write-Warning -Message ('Unable to Import-Module "LyncOnlineConnector" - {0}' -f $_.Exception.Message)
            return
        }

        try {
            $null = New-CsOnlineSession -Credential $Script:AzureADCredentials -ErrorAction Stop -WarningAction SilentlyContinue
        }
        catch {
            Write-Warning -Message ('Unable to create PSSession for Skype for Business Online - {0}' -f $_.Exception.Message)
            return
        }
        try {            
            $null = Import-PSSession -Session (Get-SfBOnlineSession) -DisableNameChecking -AllowClobber -ErrorAction Stop -WarningAction SilentlyContinue
        }
        catch {
            Write-Warning -Message ('Unable to load PSSession for Skype for Business Online - {0}' -f $_.Exception.Message)
            return
        }
    }
}