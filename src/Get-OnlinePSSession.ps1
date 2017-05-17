function Get-OnlinePSSession {

    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true,
            HelpMessage = 'PSSessions'
        )]
        [Management.Automation.Runspaces.PSSession[]]$Session,

        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Provide a ComputerName for a PSSession for filter usage.'
        )]
        [ValidateNotNullOrEmpty()]
        [string]$FilterComputerName,

        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Provide a ConfiguratioName for a PSSession for filter usage.'
        )]
        [ValidateNotNullOrEmpty()]
        [string]$FilterConfigurationName
    )

    process {

        if ($Session.ComputerName -match $FilterComputerName -and $Session.ConfigurationName -eq $FilterConfigurationName) {
            $Session
        }
    }
}