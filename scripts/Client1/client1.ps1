$username = "denis"
$password = ConvertTo-SecureString "pass1234" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

Add-Computer -ComputerName "Client1" -DomainName "WS2-2324-denis.hogent" -Credential $credential
