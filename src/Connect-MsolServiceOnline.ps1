function Connect-MsolServiceOnline {

    [CmdletBinding()]
    param(        
        
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true,
            HelpMessage = 'Credentials in Azure AD to access Office 365.'
        )]
        [System.Management.Automation.Credential()]
        [PSCredential]$Credential
    )

    $Module = Get-Module -Name 'MSOnline' -ListAvailable

    if ($null -eq $Module) {

        Write-Warning -Message "Requires the module 'MSOnline' to Connect to MsolService"
        Write-Verbose -Message 'Download from: http://go.microsoft.com/fwlink/?linkid=236297' -Verbose
        return
    }
    else {

        try {

            Import-Module -Name 'MSOnline' -DisableNameChecking -ErrorAction Stop -WarningAction SilentlyContinue -Verbose:$false
        }
        catch {

            Write-Warning -Message ('Unable to Import-Module "MSOnline" - {0}' -f $_.Exception.Message)
            return
        }

        try {

            Connect-MsolService -Credential $Credential -ErrorAction Stop -WarningAction SilentlyContinue
        }
        catch {
            # If Connect-MsolService fails. First fail, try to remove Cookies. Second fail, try to restart Microsoft Online Services Sign-in Assistant
            try {

                Disconnect-MsolServiceOnline -CoockiesOnly
                Connect-MsolService -Credential $Credential -ErrorAction Stop -WarningAction SilentlyContinue
            }
            catch {
                
                try {
                    
                    $User = [Security.Principal.WindowsIdentity]::GetCurrent()
                    if ((New-Object Security.Principal.WindowsPrincipal $User).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
                    
                        Write-Verbose -Message 'Restarting "Microsoft Online Services Sign-in Assistant" to avoid saved sessions.'
                        Restart-Service -Name 'msoidsvc' -ErrorAction Stop
                        Connect-MsolService -Credential $Credential -ErrorAction Stop -WarningAction SilentlyContinue
                    }
                    else {
                        
                        Write-Warning -Message 'Unable to restart service "Microsoft Online Services Sign-in Assistant". Administrator privileges is required for this.'
                        return
                    }
                }
                catch {

                    Write-Warning -Message ('Unable to connect to MSOnline - {0}' -f $_.Exception.Message)
                    return
                }
            }
        }
    }
}