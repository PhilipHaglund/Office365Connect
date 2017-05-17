function Disconnect-Office365 {
    <#
        .SYNOPSIS
        Disconnect from one or more Office 365 services using Powershell.
        
        .DESCRIPTION
        Disconnect from one or more Office 365 (AzureAD) services using Powershell. Some services requires the installation of separate PowerShell modules or binaires.
        AzureAD requires a separate module - https://www.powershellgallery.com/packages/AzureAD/ or cmdlet "Install-Module -Name AzureAD"
        MsolService requraes a seprate module - http://go.microsoft.com/fwlink/?linkid=236297
        Sharepoint Online requires a separate module - https://www.microsoft.com/en-us/download/details.aspx?id=35588
        Skype for Business Online requires a separate module - https://www.microsoft.com/en-us/download/details.aspx?id=39366
        Exchange Online, Exchange Online Protection, Complince Center does not require seperate binaries.

        .EXAMPLE
        Disconnect-Office365
        

        VERBOSE: Disconnecting from all Office 365 Services.
        VERBOSE: Azure AD Session is now closed.
        VERBOSE: MsolService Module is now closed.
        VERBOSE: The Compliance Center Online PSSession is now closed.
        VERBOSE: The Exchange Online PSSession is now closed.
        VERBOSE: The Exchange Online Protection PSSession is now closed.
        VERBOSE: The Sharepoint Online Session is now closed.
        VERBOSE: The Skype for Business Online PSSession is now closed.

        This command disconnects from all Office 365 service sessions that are available and running.

        .EXAMPLE
        Disconnect-Office365 -Service ComplianceCenter, ExchangeOnline, AzureAD


        VERBOSE: Disconnecting from AzureAD.
        VERBOSE: Azure AD Session is now closed.
        VERBOSE: Disconnecting from Compliance Center.
        VERBOSE: The Compliance Center Online PSSession is now closed.
        VERBOSE: Disconnecting from Exchange Online.
        VERBOSE: The Exchange Online PSSession is now closed.

        This command disconnects from AzureAD, Compliance Center and Exchange Online service sessions that are available and running.

        .NOTES
        Created on:     2017-02-23 14:56
        Created by:     Philip Haglund
        Organization:   Gonjer.com        
        Version:        1.5.0
        Requirements:   Powershell 3.0       

        .LINK
        https://github.com/PhilipHaglund/Office365Connect/
        https://gonjer.com/
    #>
    [CmdletBinding(
        SupportsShouldProcess = $true
    )]
    param(
        # Provide one or more Office 365 services to disconnect from.
        # Valid values are:
        # 'AllServices', 'AzureAD', 'ComplianceCenter', 'ExchangeOnline', 'ExchangeOnlineProtection', 'MSOnline', 'SharepointOnline' ,'SkypeforBusinessOnline'
        [Parameter(
            ValueFromPipeline = $true            
        )]
        [ValidateSet('AllServices', 'AzureAD', 'ComplianceCenter', 'ExchangeOnline', 'ExchangeOnlineProtection', 'MSOnline', 'SharepointOnline' ,'SkypeforBusinessOnline')]
        [ValidateNotNullOrEmpty()]
        [string[]]$Service = @('AllServices')
    )
    begin {

        if (($service = $Service | Sort-Object -Unique).Count -gt 6) {
            $Service = 'AllServices'
        }
    }
    process {

        foreach ($s in $Service) {

            if ($PSCmdlet.ShouldProcess('End the PowerShell session for {0} - Office 365.' -f ('{0}' -f $s), $MyInvocation.MyCommand.Name)) {

                switch ($s) {

                    'AzureAD' {
                        Write-Verbose -Message 'Disconnecting from AzureAD.' -Verbose
                        Disconnect-AzureADOnline
                    }
                    'MSOnline' {
                        Write-Verbose -Message 'Disconnecting from MsolService.' -Verbose
                        Disconnect-MsolServiceOnline
                    }
                    'ComplianceCenter' {
                        Write-Verbose -Message 'Disconnecting from Compliance Center.' -Verbose
                        Disconnect-CCOnline
                    }
                    'ExchangeOnline' {
                        Write-Verbose -Message 'Disconnecting from Exchange Online.' -Verbose
                        Disconnect-ExchangeOnline
                    }
                    'ExchangeOnlineProtection' {
                        Write-Verbose -Message 'Disconnecting from Exchange Online Protection.' -Verbose
                        Disconnect-ExchangeOnlineProt
                    }
                    'SharepointOnline' {
                        Write-Verbose -Message 'Disconnecting from Sharepoint Online.' -Verbose
                        Disconnect-SPOnline
                    }
                    'SkypeforBusinessOnline' {
                        Write-Verbose -Message 'Disconnecting from Skype for Business Online.' -Verbose
                        Disconnect-SfBOnline
                    }
                    Default {
                        Write-Verbose -Message 'Disconnecting from all Office 365 Services.' -Verbose
                        Disconnect-AzureADOnline
                        Disconnect-MsolServiceOnline
                        Disconnect-CCOnline
                        Disconnect-ExchangeOnline
                        Disconnect-ExchangeOnlineProt
                        Disconnect-SPOnline
                        Disconnect-SfBOnline
                    }
                }
                
            }
        }
    }
    end {

        # If the saved credentials variables for some reason is not removed we remove them again.
        Set-Variable -Name AzureADCredentials -Scope Script -Value $null -ErrorAction SilentlyContinue
    }
}