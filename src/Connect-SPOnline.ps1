function Connect-SPOnline {

    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Enter a valid Sharepoint Online Domain. Example: "Contoso"'
        )]
        [Alias('Domain','DomainHost','Customer')]
        [string]$SharepointDomain,

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true,
            HelpMessage = 'Credentials in Azure AD to access Office 365.'
        )]
        [System.Management.Automation.Credential()]
        [PSCredential]$Credential
    )

    $Module = Get-Module -Name 'Microsoft.Online.SharePoint.PowerShell' -ListAvailable

    if ($null -eq $Module) {

        Write-Warning -Message "Requires the module 'Microsoft.Online.SharePoint.PowerShell' for connection to Sharepoint Online"
        Write-Verbose -Message 'Download from: https://www.microsoft.com/en-us/download/details.aspx?id=35588' -Verbose
        return
    }
    else {

        try {

            Import-Module -Name 'Microsoft.Online.SharePoint.PowerShell' -DisableNameChecking -ErrorAction Stop -WarningAction SilentlyContinue -Verbose:$false
        }
        catch {

            Write-Warning -Message ('Unable to Import-Module "Microsoft.Online.SharePoint.PowerShell" - {0}' -f $_.Exception.Message)
            return
        }

        try {
              
            $null = Connect-SPOService -Url ('https://{0}-admin.sharepoint.com' -f ($SharepointDomain)) `                    -Credential $Credential `                    -ErrorAction Stop `                    -WarningAction SilentlyContinue `
                    -Verbose:$false
        }
        catch {

            Write-Warning -Message ('Unable to Connect to Sharepoint Online Session - {0}' -f $_.Exception.Message)
            return
        }
    }
}