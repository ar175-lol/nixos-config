{
  lib,
  pkgs,
  ...
}: let
  calamaresPackage = pkgs.calamares-nixos;
  calamaresExe = lib.getExe calamaresPackage;

  calamaresLauncher =
    pkgs.runCommand "calamares-launcher" {
      meta.priority = 1;
    } ''
      mkdir -p $out/bin
      cat > $out/bin/calamares <<'EOF'
      #!${pkgs.runtimeShell}
      if [ "$EUID" -ne 0 ]; then
        runtime_dir="''${XDG_RUNTIME_DIR:-/run/user/$EUID}"
        display="''${WAYLAND_DISPLAY:-}"
        if [ -n "$display" ]; then
          exec /run/wrappers/bin/pkexec /run/current-system/sw/bin/env \
            QT_QPA_PLATFORM=wayland \
            XDG_RUNTIME_DIR="$runtime_dir" \
            WAYLAND_DISPLAY="$display" \
            ${calamaresExe} "$@"
        fi
        exec /run/wrappers/bin/pkexec ${calamaresExe} "$@"
      fi
      if [ -z "''${WAYLAND_DISPLAY:-}" ]; then
        invoker_uid="''${PKEXEC_UID:-''${SUDO_UID:-}}"
        if [ -n "$invoker_uid" ]; then
          runtime_dir="/run/user/$invoker_uid"
          for sock in "$runtime_dir"/wayland-*; do
            case "$sock" in
              *.lock|*.sock) continue ;;
            esac
            if [ -S "$sock" ]; then
              export XDG_RUNTIME_DIR="$runtime_dir"
              export WAYLAND_DISPLAY="''${sock##*/}"
              export QT_QPA_PLATFORM=wayland
              break
            fi
          done
        fi
      fi
      exec ${calamaresExe} "$@"
      EOF
      chmod +x $out/bin/calamares
    '';

  calamaresDesktop =
    pkgs.runCommand "calamares-desktop" {
      meta.priority = 1;
    } ''
      install -Dm644 ${calamaresPackage}/share/applications/calamares.desktop $out/share/applications/calamares.desktop
      substituteInPlace $out/share/applications/calamares.desktop \
        --replace-fail 'Exec=sh -c "pkexec calamares"' 'Exec=calamares'
    '';
in {
  config = {
    networking = {
      networkmanager.enable = lib.mkForce false;
      dhcpcd.enable = true;
      dhcpcd.denyInterfaces = ["wlan*"];

      wireless.enable = lib.mkForce false;
    };

    boot.kernelPackages = lib.mkForce pkgs.linuxPackages_xanmod_latest;

    nixpkgs.overlays = [
      (_final: prev: {
        vim = prev.symlinkJoin {
          name = "vim-shadowed";
          paths = [prev.vim];
          meta.priority = 10;
        };
      })
    ];

    hardware = {
      enableRedistributableFirmware = true;

      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

    programs.fish.enable = true;
    programs.partition-manager.enable = true;

    security.polkit.enablePkexecWrapper = true;
    security.polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (subject.isInGroup("wheel")) {
          return polkit.Result.YES;
        }
      });
    '';

    i18n.supportedLocales = ["all"];

    home-manager.backupFileExtension = "backup";

    environment.systemPackages = with pkgs; [
      debootstrap
      arch-install-scripts
      testdisk
      ddrescue
      chntpw
      ms-sys
      firefox
      calamares-nixos
      calamaresLauncher
      calamaresDesktop
      calamares-nixos-extensions
      glibcLocales
    ];

    virtualisation.vmVariant = {
      virtualisation = {
        memorySize = 4096;
        cores = 4;
        qemu.options = [
          "-device virtio-vga-gl"
          "-display gtk,gl=on"
        ];
      };
    };
  };
}
