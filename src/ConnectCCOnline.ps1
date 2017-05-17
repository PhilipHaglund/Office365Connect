function ConnectCCOnline {
    [CmdletBinding()]
    param ()

    if ($null -ne (Get-CCOnlineSession)) {
        if (Get-Command -Name 'Get-ComplianceSearch') {
            Write-Verbose -Message 'Compliance Center PowerShell session already existis.' -Verbose
            return
        }
    }
    try {
        $null = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri 'https://ps.compliance.protection.outlook.com/powershell-liveid/' -Credential $Script:AzureADCredentials -Authentication Basic -AllowRedirection -ErrorAction Stop -WarningAction SilentlyContinue
    }
    catch {
        Write-Warning -Message ('Unable to create PSSession to Compliance Center - {0}' -f $_.Exception.Message)
        return
    }
    try {        
        $null = Import-Module (Import-PSSession -Session (Get-CCOnlineSession) -DisableNameChecking -AllowClobber -ErrorAction Stop -WarningAction SilentlyContinue) -DisableNameChecking -Global -ErrorAction Stop -WarningAction SilentlyContinue
    }
    catch {
        Write-Warning -Message ('Unable to load PSSession for Compliance Center - {0}' -f $_.Exception.Message)
        return
    }
}