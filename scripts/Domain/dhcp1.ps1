# Install DHCP Server role
Install-WindowsFeature -Name DHCP -IncludeManagementTools

# Configure DHCP Administrators and DHCP Users
Add-DhcpServerSecurityGroup

# Add the user to Enterprise Admins domain group
Add-ADGroupMember -Identity "Enterprise Admins" -Members "denis"
