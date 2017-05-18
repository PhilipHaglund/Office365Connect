function Disconnect-MsolServiceOnline {

    [CmdletBinding(
        SupportsShouldProcess = $true
    )]
    param (
        [switch]$CoockiesOnly
    )
    
    try {

        $Cookies = ([Environment]::GetFolderPath('Cookies')) | Get-ChildItem -Recurse | Select-String -Pattern 'MicrosoftOnline' | Group-Object -Property Path
        foreach ($c in $Cookies.Name) {
    
            if ($PSCmdlet.ShouldProcess(('Removing coockie {0} for MSOnline saved credentials' -f $c.Name),'Remove-Item')) {
                Remove-Item -Path $c -ErrorAction SilentlyContinue
            }
        }

        if ($PSBoundParameters.ContainsKey('CoockiesOnly')) {
            return
        }
    }
    catch {
        
        Write-Verbose -Message 'Unable to remove MicrosoftOnline cookies.'
    }

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