# Set DNS server address
$interfaceIndex = (Get-NetAdapter | Where-Object {$_.InterfaceAlias -eq "Ethernet"}).InterfaceIndex
Set-DnsClientServerAddress -InterfaceIndex $interfaceIndex -ServerAddresses "192.168.23.5"

# Create Reverse Lookup Zone
Add-DnsServerPrimaryZone -NetworkID "192.168.23.0/24" -ReplicationScope "Forest"

# Add A records with pointers
Add-DnsServerResourceRecordA -ZoneName "ws2-2324-denis.hogent" -Name "sqlserver" -IPv4Address "192.168.23.6" -CreatePtr
Add-DnsServerResourceRecordA -ZoneName "ws2-2324-denis.hogent" -Name "sharepoint" -IPv4Address "192.168.23.7" -CreatePtr
