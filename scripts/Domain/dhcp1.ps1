# Install DHCP Server role
Install-WindowsFeature -Name DHCP -IncludeManagementTools

# Configure DHCP Administrators and DHCP Users
Add-DhcpServerSecurityGroup
