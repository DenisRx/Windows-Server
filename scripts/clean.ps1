VBoxManage unregistervm "CA-AD" --delete
VBoxManage unregistervm "DHCP-DNS" --delete
VBoxManage unregistervm "SharePoint-DNS" --delete
VBoxManage unregistervm "SQLServer" --delete

Remove-Item "C:\Users\rouxd\VirtualBox VMs\CA-AD" -Recurse
Remove-Item "C:\Users\rouxd\VirtualBox VMs\DHCP-DNS" -Recurse
Remove-Item "C:\Users\rouxd\VirtualBox VMs\SharePoint-DNS" -Recurse
Remove-Item "C:\Users\rouxd\VirtualBox VMs\SQLServer" -Recurse
