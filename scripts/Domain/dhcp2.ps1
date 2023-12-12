# Authorize DHCP Server in AD DS
Add-DhcpServerInDC -DnsName "Domain.WS2-2324-denis.hogent" -IPAddress 192.168.23.5

Add-DhcpServerv4Scope -Name "dhcp.ws2-2324-denis.hogent" -StartRange 192.168.23.51 -EndRange 192.168.23.100 -SubnetMask 255.255.255.0 -LeaseDuration 8.00:00:00

Set-DhcpServerv4OptionValue -DnsDomain "WS2-2324-denis.hogent" -DnsServer 192.168.23.5 -Router 192.168.23.2

# Finish DHCP configuration
Set-ItemProperty -Path "HKLM:\Software\Microsoft\ServerManager\Roles\12" -Name ConfigurationState -Value 2

# Activate DHCP scope
Set-DhcpServerv4Scope -ScopeId 192.168.23.0 -State Active

Start-Service DHCPserver