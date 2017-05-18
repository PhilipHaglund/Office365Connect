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
        [string]$FilterConfigurationName,

        [ValidateNotNullOrEmpty()]
        [string]$FilterSessionName = '.'
    )

    process {

        if ($Session.ComputerName -match $FilterComputerName -and $Session.ConfigurationName -eq $FilterConfigurationName -and $Session.Name -match $FilterSessionName) {
            $Session
        }
    }
}