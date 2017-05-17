function ConnectSPOnline {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Enter a valid Sharepoint Online Domain. Example: "Contoso"'
        )]
        [Alias('Domain','DomainHost','Customer')]
        [string]$SharepointDomain
    )

    $Module = Get-Module -Name 'Microsoft.Online.SharePoint.PowerShell' -ListAvailable
    if ($null -eq $Module) {
        Write-Warning -Message "Requires the module 'Microsoft.Online.SharePoint.PowerShell' for connection to Sharepoint Online"
        Write-Verbose -Message 'Download from: https://www.microsoft.com/en-us/download/details.aspx?id=35588' -Verbose
        return
    }
    else {
        try {
            Import-Module -Name 'Microsoft.Online.SharePoint.PowerShell' -DisableNameChecking -ErrorAction Stop -WarningAction SilentlyContinue
        }
        catch {
            Write-Warning -Message ('Unable to Import-Module "Microsoft.Online.SharePoint.PowerShell" - {0}' -f $_.Exception.Message)
            return
        }

        try {            
            Connect-SPOService -Url ('https://{0}-admin.sharepoint.com' -f ($SharepointDomain)) -Credential $Script:AzureADCredentials -ErrorAction Stop -WarningAction SilentlyContinue
        }
        catch {
            Write-Warning -Message ('Unable to Connect to Sharepoint Online Session - {0}' -f $_.Exception.Message)
            return
        }
    }
}