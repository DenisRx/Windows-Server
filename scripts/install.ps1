function CreateVm {
    param (
        [string]$VmName,
        [string]$OsType,
        [int]$CpuCount,
        [int]$MemoryCount,
        [int]$DiskSize,
        [string]$DiskPath,
        [string]$IsoPath,
        [int]$imageIndex
    )

    # Create the virtual machine
    VBoxManage createvm --name $VmName --ostype $OsType --register

    # Set CPU and Memory
    VBoxManage modifyvm $VmName --cpus $CpuCount --memory $MemoryCount

    # Set NAT network
    VBoxManage modifyvm $VmName --nic1 natnetwork --nat-network1 NATNetwork1

    #########################
    # TODO:
    # - Add shared folder
    #########################

    # Create disk and set the size
    VBoxManage createmedium disk --filename $DiskPath --size $DiskSize --format VDI

    # Create storage control for disk
    VBoxManage storagectl $VmName --name "SATA Controller" --add sata --controller IntelAhci

    # Attach disk to the virtual machine
    VBoxManage storageattach $VmName --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $DiskPath

    # Create storage control for ISO file
    VBoxManage storagectl $VmName --name "IDE Controller" --add ide --controller PIIX4

    # Attach ISO to virtual machine
    VBoxManage storageattach $VmName --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium $IsoPath

    # Define boot order
    VBoxManage modifyvm $VmName --boot1 dvd --boot2 disk --boot3 none --boot4 none

    # Unattended installation of Windows server
    VBoxManage unattended install $VmName --iso=$IsoPath --user=denis --password pass1234 --locale="en_US" --country="FR" --time-zone=CET --hostname="${VmName}.ws2-2324-denis.hogent" --image-index=$imageIndex --install-additions
}

function StartVm {
    param ([string]$VmName)
    
    VBoxManage startvm $VmName --type headless
}

# OS configurations
$WSOsType = "Windows2022_64"
$W10OsType = "Windows10_64"
$WSIsoPath = "C:\Users\rouxd\OneDrive\Bureau\Windows-Server\images\en-us_windows_server_2022_x64.iso"
$W10IsoPath = "C:\Users\rouxd\OneDrive\Bureau\Windows-Server\images\en-us_windows_10_x64.iso"

# Create NAT Network
VBoxManage natnetwork add --netname NATNetwork1 --network "192.168.23.0/24" --enable

# Create VMs
CreateVm "CA-AD" $WSOsType 1 (2 * 1024) (10 * 1024) "C:\Users\rouxd\VirtualBox VMs\CA-AD\CA-AD.vdi" $WSIsoPath 1
CreateVm "DHCP-DNS" $WSOsType 1 (2 * 1024) (10 * 1024) "C:\Users\rouxd\VirtualBox VMs\DHCP-DNS\DHCP-DNS.vdi" $WSIsoPath 1
CreateVm "SharePoint-DNS" $WSOsType 2 (4 * 1024) (45 * 1024) "C:\Users\rouxd\VirtualBox VMs\SharePoint-DNS\SharePoint-DNS.vdi" $WSIsoPath 2
CreateVm "SQLServer" $WSOsType 2 (4 * 1024) (64 * 1024) "C:\Users\rouxd\VirtualBox VMs\SQLServer\SQLServer.vdi" $WSIsoPath 1
CreateVm "Client" $W10OsType 2 (4 * 1024) (35 * 1024) "C:\Users\rouxd\VirtualBox VMs\Client\Client.vdi" $W10IsoPath 1

# Start VMs
StartVm CA-AD
StartVm DHCP-DNS
StartVm SharePoint-DNS
StartVm SQLServer
StartVm Client