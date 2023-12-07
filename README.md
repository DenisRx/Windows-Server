# Windows Server

The course Windows Server II is a course from Hogent university.

This repository is composed of scripts and instructions to deploy a Windows Server environment.

The setup contains:
- Active Directory
- DNS
- DHCP
- Certificate Authority
- SQLServer
- SharePoint

## VMs configuration

Steps to follow:
- Clone the repository
- Download the ISO files and move them in the `images` folder.
    - [Windows Server 2022](https://www.microsoft.com/en-us/windows-server)
    - [Windows 10](https://www.microsoft.com/en-us/software-download/windows10)
- These files should be respectively named as follows: `en-us_windows_server_2022_x64.iso` and `en-us_windows_10_x64.iso`

On the host machine, launch the script `install.ps1`.
It will create and configure all the necessary virtual machines.

## Domain

### AD

Active Directory is a Directory Service, a service that makes it possible to access
hierarchically organized data within a computer network. The directory service
manages the data and the relationships between the data sources. Access to this
data is done according to the client-server principle.

Steps to follow:
- Open Powershell with elevated privileges
- `Set-ExecutionPolicy Unrestricted -Force`
- Restart VM to show the shared folder
- `powershell -ExecutionPolicy Bypass -File \\VBOXSVR\shared\ad.ps1`

### DNS

DNS (Domain Name System) is an internet service that translates user-friendly domain names into numeric IP addresses, enabling seamless navigation and access to online resources.

Steps to follow:
- Open Powershell with elevated privileges
- `powershell -ExecutionPolicy Bypass -File \\VBOXSVR\shared\dns.ps1`
