# Create Forward Lookup Zone
Add-DnsServerPrimaryZone -Name "Primary-WS2-2324-denis.hogent-DNS" -ReplicationScope "Forest" -PassThru

# Get the network adapter interface index and set the new static IP address
$interfaceIndex = (Get-NetAdapter | Where-Object {$_.InterfaceAlias -eq "Ethernet"}).InterfaceIndex
New-NetIPAddress -InterfaceIndex $interfaceIndex -IPAddress "192.168.23.5" -PrefixLength 24 -DefaultGateway "192.168.23.1"

# Set DNS server address
Set-DnsClientServerAddress -InterfaceIndex $interfaceIndex -ServerAddresses "127.0.0.1"

# Create Reverse Lookup Zone
Add-DnsServerPrimaryZone -NetworkID "192.168.23.0/24" -ReplicationScope "Forest"

# Add A records with pointers
Add-DnsServerResourceRecordA -ZoneName "ws2-2324-denis.hogent" -Name "sqlserver" -IPv4Address "192.168.23.6" -CreatePtr
Add-DnsServerResourceRecordA -ZoneName "ws2-2324-denis.hogent" -Name "sharepoint" -IPv4Address "192.168.23.7" -CreatePtr
