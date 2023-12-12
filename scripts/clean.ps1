VBoxManage unregistervm "Domain" --delete
VBoxManage unregistervm "SharePoint" --delete
VBoxManage unregistervm "SQLServer-DNS" --delete
VBoxManage unregistervm "Client1" --delete

Remove-Item "C:\Users\rouxd\VirtualBox VMs\Domain" -Recurse
Remove-Item "C:\Users\rouxd\VirtualBox VMs\SharePoint" -Recurse
Remove-Item "C:\Users\rouxd\VirtualBox VMs\SQLServer-DNS" -Recurse
Remove-Item "C:\Users\rouxd\VirtualBox VMs\Client1" -Recurse
