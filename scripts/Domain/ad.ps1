# Get the network adapter interface index and set the new static IP address
$interfaceIndex = (Get-NetAdapter | Where-Object {$_.InterfaceAlias -eq "Ethernet"}).InterfaceIndex
New-NetIPAddress -InterfaceIndex $interfaceIndex -IPAddress "192.168.23.5" -PrefixLength 24 -DefaultGateway "192.168.23.2"

# Install AD-DS
Install-WindowsFeature -name AD-Domain-Services -IncludeManagementTools

# Add a new forest
# Set domain and forest levels to Windows Server 2016 (WinThreshold or 7)
$securePassword = ConvertTo-SecureString "Pass1234!" -AsPlainText -Force
Install-ADDSForest -DomainName "WS2-2324-denis.hogent" -SafeModeAdministratorPassword $securePassword -DomainMode WinThreshold -ForestMode WinThreshold -InstallDNS -NoRebootOnCompletion -Force

Restart-Computer
