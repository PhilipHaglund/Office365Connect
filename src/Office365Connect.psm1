# Implement your module commands in this script.
$VerbNoun = '*-*'
$Functions = Get-ChildItem -Path $PSScriptRoot -Filter $VerbNoun
foreach ($f in $Functions)
{
    Write-Verbose -Message ("Importing function {0}." -f $f.FullName)
    . $f.FullName
}

# Export only the functions using PowerShell standard verb-noun naming.
Export-ModuleMember -Function $VerbNoun
