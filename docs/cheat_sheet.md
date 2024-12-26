# Cheat Sheet

01 - SSH Keys
----------------
Create ssh keys for github and ssh
```bash
ssh-keygen -t ed25519 -C "{{ EMAIL@EXAMPLE.COM }}" -f ~/.ssh/ssh
ssh-keygen -t ed25519 -C "{{ EMAIL@EXAMPLE.COM }}" -f ~/.ssh/github
```
Edit ssh config and add below
```bash
nano .ssh/config
```
```bash
Host github.com
  HostName github.com
  IdentityFile ~/.ssh/github

Host *
  IdentitiesOnly yes
  IdentityFile ~/.ssh/ssh
  User {{ USERNAME }}
```
02 - Github
----------------
Get github public key and add it to github account at https://github.com/settings/keys
```bash
cat .ssh/github.pub 
```
Configure git
```bash
git config --global user.name "{{ USERNAME }}"
git config --global user.email "{{ EMAIL@EXAMPLE.COM }}"
```
Clone git to current folder or specified folder
```bash
git clone {{ REPO_URL }} .
git clone {{ REPO_URL }} {{ FOLDER }}
```
   
   


03 - GNS3 Proxmox installation
----------------

If using NixOS check wich version of GNS3 that is currently available [NixOS packages GNS3](https://search.nixos.org/packages?channel=24.11&from=0&size=50&sort=relevance&type=packages&query=gns3). Install it in your prefferd way, I've added it to my homemanager packages.
```
  home = {
    packages = with pkgs; [
      ...
      gns3-gui
    ];
  };
```

Download the same version of the GNS3 server from [GNS3 Github](https://github.com/GNS3/gns3-gui/releases).

Extract the GNS3 zip so you are left with a OVA and upload it the proxmox server
```
unzip GNS3.VM.VMware.ESXI.2.2.50.zip
scp "GNS3 VM.ova" root@10.0.10.10:/tmp/
```
SSH to the proxmox server untar the GNS3 VM.ova and import the ovf
```
cd /tmp/
tar xvf 'GNS3 VM.ova'
qm importovf 102 'GNS3 VM.ovf' local-zfs
qm set 102 --cores 12 --memory 24576 --cpu cputype=host --balloon 1024
qm set 102 --net0 "virtio,bridge=vmbr0"
```
