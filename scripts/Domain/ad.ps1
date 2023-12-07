# Install AD-DS
Install-WindowsFeature -name AD-Domain-Services -IncludeManagementTools

# Add a new forest
# Set domain and forest levels to Windows Server 2016 (WinThreshold or 7)
$securePassword = ConvertTo-SecureString "Pass1234!" -AsPlainText -Force
Install-ADDSForest -DomainName "WS2-2324-denis.hogent" -SafeModeAdministratorPassword $securePassword -DomainMode WinThreshold -ForestMode WinThreshold -InstallDNS -NoRebootOnCompletion -Force

Restart-Computer
