# Set the DNS IP address
Set-DnsClientServerAddress -InterfaceAlias 'Ethernet' -ServerAddresses 192.168.23.5

$username = "denis"
$password = ConvertTo-SecureString "pass1234" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

# Add client computer to the domain
Add-Computer -ComputerName "Client1" -DomainName "WS2-2324-denis.hogent" -Credential $credential
