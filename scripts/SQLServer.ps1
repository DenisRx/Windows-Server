function CreateVm {
    param (
        [string]$VmName,
        [string]$OsType,
        [int]$CpuCount,
        [int]$MemoryCount,
        [int]$DiskSize,
        [string]$DiskPath,
        [string]$IsoPath
    )

    # Create the virtual machine
    VBoxManage createvm --name $VmName --ostype $OsType --register

    # Set CPU and Memory
    VBoxManage modifyvm $VmName --cpus $CpuCount --memory $MemoryCount

    #########################
    # TODO:
    # - Configure network
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
    VBoxManage unattended install $VmName --iso=$IsoPath --user=denis --password pass1234 --locale="en_US" --country="FR" --time-zone=CET --hostname="${VmName}.ws2-2324-denis.hogent" --image-index=1 --install-additions
}

function StartVm {
    param ([string]$VmName)
    
    VBoxManage startvm $VmName --type headless
}

$VmName = "SQLServer"
$OsType = "Windows2022_64"
$DiskPath = "C:\Users\rouxd\VirtualBox VMs\${VmName}\${VmName}.vdi"
$WSIsoPath = "C:\Users\rouxd\OneDrive\Bureau\Windows-Server\images\en-us_windows_server_2022_x64.iso"

CreateVm "SQLServer" $OsType 2 (4 * 1024) (64 * 1024) $DiskPath $WSIsoPath
StartVm $VmName