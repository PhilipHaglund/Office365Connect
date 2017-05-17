function Connect-Office365 {
    <#
        .SYNOPSIS
        Connect to one or more Office 365 services using Powershell.
        
        .DESCRIPTION
        Connect to one or more Office 365 (AzureAD) services using Powershell. Some services requires the installation of separate PowerShell modules or binaries.
        AzureAD requires a separate module - https://www.powershellgallery.com/packages/AzureAD/ or cmdlet "Install-Module -Name AzureAD"
        MsolService requires a separate module - http://go.microsoft.com/fwlink/?linkid=236297
        Sharepoint Online requires a separate module - https://www.microsoft.com/en-us/download/details.aspx?id=35588
        Skype for Business Online requires a separate module - https://www.microsoft.com/en-us/download/details.aspx?id=39366
        Exchange Online, Exchange Online Protection, Complince Center does not require seperate binaries.

        DYNAMIC PARAMETERS
        -SharepointDomain <String>
            Parameter available when the Service parameter contains AllService or SharepointOnline.
            The SharepointDomain parameter is necessary when connecting to Sharepoint Online sessions ('https://{0}-admin.sharepoint.com' -f $SharepointDomain).
            Example for SharepointDomain can be 'Contoso'.

        .EXAMPLE
        Connect-Office365
        

        VERBOSE: Conncting to AzureAD.
        VERBOSE: Conncting to MSolService.

        This command connects to AzureAD and MsolService service sessions using the credentials provided when prompted.
        AzureAD and MsolService are the default parameter values for the parameter Services.

        .EXAMPLE
        Connect-Office365 -Service ComplianceCenter, ExchangeOnline, AzureAD


        VERBOSE: Conncting to AzureAD.
        VERBOSE: Conncting to Compliance Center.
        VERBOSE: Conncting to Exchange Online.

        This command connects to AzureAD, ComplianceCenter and ExchageOnline service sessions using the credentials provided when prompted.

        .EXAMPLE
        Connect-Office365 -Service AzureAD, SharepointOnline


        cmdlet Connect-Office365 at command pipeline position 1
        Supply values for the following parameters:
        (Type !? for Help.)
        SharepointDomain: Contoso

        VERBOSE: Conncting to AzureAD.
        VERBOSE: Conncting to Sharepoint Online.

        This command connect to AzureAD and SharepointOnline.
        SharepointOnline session requires a specified URI when connecting. In this example, Contoso, is provided at the mandatory prompt parameter, SharepointDomain.

        .EXAMPLE
        Connect-Office365 -Service AllServices -SharepointDomain Contoso


        VERBOSE: Connecting to all Office 365 Services.

        This command connects to all Office 365 service sessions using the credentials provided when prompted.
        The parameter SharepointDomain is explicit provided to avoid the mandatory parameter prompt.


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
        # Provide one or more Office 365 services to connect to.
        # Valid values are:
        # 'AllServices', 'AzureAD', 'ComplianceCenter', 'ExchangeOnline', 'ExchangeOnlineProtection', 'MSOnline', 'SharepointOnline' ,'SkypeforBusinessOnline'
        [Parameter(
            ValueFromPipeline = $true,
            Position = 0
        )]
        [ValidateSet('AllServices', 'AzureAD', 'ComplianceCenter', 'ExchangeOnline', 'ExchangeOnlineProtection', 'MSOnline', 'SharepointOnline' ,'SkypeforBusinessOnline')]
        [ValidateNotNullOrEmpty()]
        [string[]]$Service = @('AzureAD','MSOnline')
    )

    dynamicparam {

        if ($Service -match 'AllServices|SharepointOnline') {

            # Create a ParameterAttribute Object
            $SPAttrib = New-Object -TypeName System.Management.Automation.ParameterAttribute
            $SPAttrib.Position = 1
            $SPAttrib.Mandatory = $true            
            $SPAttrib.HelpMessage = 'Enter a valid Sharepoint Online Domain. Example: "Contoso"'
            
            # Create an AliasAttribute Object for the parameter
            $SPAlias = New-Object -TypeName System.Management.Automation.AliasAttribute -ArgumentList @('Domain','DomainHost','Customer')

            # Create an AttributeCollection Object
            $SPCollection = New-Object -TypeName System.Collections.ObjectModel.Collection[System.Attribute]
                       
            # Add the attributes to the AttributeCollection
            $SPCollection.Add($SPAttrib)
            $SPCollection.Add($SPAlias)
            
            # Add the SharepointDomain paramater to the "Runtime"
            $SPParam = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameter -ArgumentList ('SharepointDomain', [string], $SPCollection)
            
            # Expose the parameter
            $SPParamDictionary = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameterDictionary
            $SPParamDictionary.Add('SharepointDomain', $SPParam)
            return $SPParamDictionary
        }
    }
    begin {

        # Sorting all input strings from the Service parameter.
        if (($Service = $Service | Sort-Object -Unique).Count -gt 6 -or $Service -eq 'All') {
            $Service = 'AllServices'
        }
        
        if ($PSCmdlet.ShouldProcess('UserPrincipalName in Azure AD to access Office 365', 'Get-AzureADCredential')) {

            $Credential = Get-AzureADCredential

            if ($Credential -eq $false) {

                Write-Warning -Message 'Need valid credentials to connect, please provide the correct credentials.'
                exit
            }    
        }
    }
    process {

        foreach ($s in $Service) {
            $Credential.GetNetworkCredential()
            if ($PSCmdlet.ShouldProcess('Establishing a PowerShell session to {0} - Office 365.' -f ('{0}' -f $s), $MyInvocation.MyCommand.Name)) {
                
                switch ($s) {

                    'AzureAD' {
                        Write-Verbose -Message 'Conncting to AzureAD.' -Verbose
                        Connect-AzureADOnline -Credential $Credential
                    }
                    'MSOnline' {
                        Write-Verbose -Message 'Conncting to MSolService.' -Verbose
                        Connect-MsolServiceOnline -Credential $Credential
                    }
                    'ComplianceCenter' {
                        Write-Verbose -Message 'Conncting to Compliance Center.' -Verbose
                        Connect-CCOnline -Credential $Credential
                    }
                    'ExchangeOnline' {
                        Write-Verbose -Message 'Conncting to Exchange Online.' -Verbose
                        Connect-ExchangeOnline -Credential $Credential
                    }
                    'ExchangeOnlineProtection' {
                        Write-Verbose -Message 'Conncting to Exchange Online Protection.' -Verbose
                        Connect-ExchangeOnlineProt -Credential $Credential
                    }
                    'SharepointOnline' {
                        Write-Verbose -Message 'Conncting to Sharepoint Online.' -Verbose
                        Connect-SPOnline -SharepointDomain $PSBoundParameters['SharepointDomain'] -Credential $Credential
                    }
                    'SkypeforBusinessOnline' {
                        Write-Verbose -Message 'Conncting to Skype for Business Online.' -Verbose
                        Connect-SfBOnline -Credential $Credential
                    }
                    Default {
                        Write-Verbose -Message 'Connecting to all Office 365 Services.' -Verbose
                        Connect-AzureADOnline -Credential $Credential
                        Connect-MsolServiceOnline -Credential $Credential
                        Connect-CCOnline -Credential $Credential
                        Connect-ExchangeOnline -Credential $Credential
                        Connect-ExchangeOnlineProt -Credential $Credential
                        Connect-SPOnline -SharepointDomain $PSBoundParameters['SharepointDomain'] -Credential $Credential
                        Connect-SfBOnline -Credential $Credential
                    }
                }
            }
        }
    }
    end {

        Remove-Variable -Name Credential -ErrorAction SilentlyContinue
    }
}