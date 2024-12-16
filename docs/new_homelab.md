
# New homelab

My homelab hardware was getting old so this black friday I wanted to order some new parts. 

My requirements were 
  - Smallish formfactor.
  - Fit minimum of 4 HDD:s.
  - Be able to run containers and virtual machines for home automation, dns, backups and reverse proxy 24/7.
  - Be able to run network labs when needed.
  - A chassies that fit a ATX powersupply.
  - A option to in the future install a GPU for LLMs.
  - Reasonable power usage.

This is what i came up with:

Type|Item
:----|:----
**CPU** | [Intel Core i5-13500 2.5 GHz 14-Core Processor](https://pcpartpicker.com/product/mtmmP6/intel-core-i5-13500-25-ghz-14-core-processor-bx8071513500)
**CPU Cooler** | [Noctua NH-L9i-17xx chromax.black 33.84 CFM CPU Cooler](https://pcpartpicker.com/product/nJqPxr/noctua-nh-l9i-17xx-chromaxblack-3384-cfm-cpu-cooler-nh-l9i-17xx-chromaxblack)
**Motherboard** | [Asus ROG STRIX B760-I GAMING WIFI Mini ITX LGA1700 Motherboard](https://pcpartpicker.com/product/YxLFf7/asus-rog-strix-b760-i-gaming-wifi-mini-itx-lga1700-motherboard-rog-strix-b760-i-gaming-wifi)
**Memory** | [Crucial Pro 96 GB (2 x 48 GB) DDR5-5600 CL46 Memory](https://pcpartpicker.com/product/BLdG3C/crucial-pro-96-gb-2-x-48-gb-ddr5-5600-cl46-memory-cp2k48g56c46u5)
**Storage** | [Western Digital Blue 1 TB 2.5" Solid State Drive](https://pcpartpicker.com/product/GTCD4D/western-digital-blue-1tb-25-solid-state-drive-wds100t2b0a)
**Storage** | [Western Digital Blue 1 TB 2.5" Solid State Drive](https://pcpartpicker.com/product/GTCD4D/western-digital-blue-1tb-25-solid-state-drive-wds100t2b0a)
**Storage** | [Kingston KC3000 1.024 TB M.2-2280 PCIe 4.0 X4 NVME Solid State Drive](https://pcpartpicker.com/product/ccFbt6/kingston-kc3000-1024-tb-m2-2280-nvme-solid-state-drive-skc3000s1024g)
**Storage** | [Kingston KC3000 1.024 TB M.2-2280 PCIe 4.0 X4 NVME Solid State Drive](https://pcpartpicker.com/product/ccFbt6/kingston-kc3000-1024-tb-m2-2280-nvme-solid-state-drive-skc3000s1024g)
**Storage** | [Seagate IronWolf NAS 4 TB 3.5" 5900 RPM Internal Hard Drive](https://pcpartpicker.com/product/6MX2FT/seagate-ironwolf-4tb-35-5900rpm-internal-hard-drive-st4000vn008)
**Storage** | [Seagate IronWolf NAS 4 TB 3.5" 5900 RPM Internal Hard Drive](https://pcpartpicker.com/product/6MX2FT/seagate-ironwolf-4tb-35-5900rpm-internal-hard-drive-st4000vn008)
**Case** | [Fractal Design Node 304 Mini ITX Tower Case](https://pcpartpicker.com/product/BWFPxr/fractal-design-case-fdcanode304bl)
**Power Supply** | [Asus ROG Strix 650 W 80+ Gold Certified Fully Modular ATX Power Supply](https://pcpartpicker.com/product/DRVG3C/asus-rog-strix-650-w-80-gold-certified-fully-modular-atx-power-supply-rog-strix-650g)

[PCPartPicker Part List](https://pcpartpicker.com/list/ZfTXPJ)


The build was a breaze but I regret not getting a smaller PSU. The Node 304 fit the ATX PSU without an issue but a SFX PSU would probably make the cable managment easier and easier to fit a fullsize GPU in the future.


# Installation preperations
Generate SSH keys with commands below. You will be prompted to set a password, do so for the proxmox key but not for the homelab key.

``` bash
ssh-keygen -t ed25519 -C root@proxmox-02 -f ~/.ssh/proxmox 
ssh-keygen -t ed25519 -C robin@home.ragren.com -f ~/.ssh/homelab  
```
Copy the proxmox public key to trusted hosts of the proxmox server using ssh-copy-id.
``` bash
ssh-copy-id -i ~/.ssh/proxmox root@10.0.10.10   
```
Edit SSH config to use the generated key and specify which user to use.

``` bash
nano ~/.ssh/config
...
Host 10.0.10.10
  IdentityFile ~/.ssh/proxmox
  User root
Host 10.0.10.*
  IdentityFile ~/.ssh/homelab
  User robin
...
```

# Proxmox Installation
I used a previously set up Ventoy usb to which i added the latest proxmox ISO
- https://www.ventoy.net/en/doc_start.html
- https://www.proxmox.com/en/downloads

Boot from the USB and follow the installation guide. I choose to create a ZFS Raid1 mirror using two NVME harddrives for Proxmox and VMs.

After the installation completed i ran the Proxmox VE Helperscript https://community-scripts.github.io/ProxmoxVE/scripts?id=post-pve-install

I also installed bpytop and powertop to monitor temperatures and try to lower power consumption.
![alt text](images/image.png) 
![alt text](images/image-1.png)