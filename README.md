# NixOS configuration

>[!WARNING]
> 
> This is a single-user, hardware-specific configuration! Use at your own risk.

## Installation guide
Just get the NixOS ISO, do the basics (formatting disks, mounting root to `/mnt`, and boot to `/mnt/boot`). 

```bash
git clone https://github.com/ar175-lol/nixos-config.git) /mnt/etc/nixos
cd /mnt/etc/nixos
nixos-generate-config --root /mnt

sudo nixos-install --root /mnt --flake .#victus --experimental-features "nix-command flakes"
```

> [!CAUTION]
> Replace my hardware.nix with your hardware-configuration.nix! 
> Otherwise your boot is **cooked**.

No screenshots, because I am **lazy**. 
