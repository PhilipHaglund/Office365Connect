# Office365Connect
## about_Office365Connect

# SHORT DESCRIPTION
Office365Connect is Powershell Module with two functions to connect and disconnect to all Office 365 services that offers a Powershell-way to connect.

# LONG DESCRIPTION
Connect to one or more Office 365 services using the module function `Connect-Office365`.

Some Office 365 requires a separate module for binarie to be installed:

- **AzureAD** requires a separate module - https://www.powershellgallery.com/packages/AzureAD/ or cmdlet `Install-Module -Name AzureAD`.
- **MsolService** requires a separate module - http://go.microsoft.com/fwlink/?linkid=236297.
- **Sharepoint Online** requires a separate module - https://www.microsoft.com/en-us/download/details.aspx?id=35588
- **Skype for Business Online** requires a separate module - https://www.microsoft.com/en-us/download/details.aspx?id=39366

**Exchange Online**, **Exchange Online Protection**, **Complince Center** does not require seperate binaries. These services uses the built in [PowerShell remote cmdlets](https://technet.microsoft.com/en-us/library/jj984289(v=exchg.160).aspx? "PowerShell remote cmdlets").

*Notice: The links above targeting the modules and binaries may change, please enlight me with an issue if you discover a change.*


To disconnect from one or more Office 365 services instead of closing the PowerShell session (console) is done with the function `Disconnect-Office365`.




# SEE ALSO
- [https://github.com/PhilipHaglund/Office365Connect](https://github.com/PhilipHaglund/Office365Connect "https://github.com/PhilipHaglund/Office365Connect")
- [https://www.powershellgallery.com/packages/Office365Connect](https://www.powershellgallery.com/packages/Office365Connect "https://www.powershellgallery.com/packages/Office365Connect")
