_: {
  nixos.modules.base = {lib, ...}: {
    systemd = {
      services = {
        ModemManager = {
          enable = false;
          wantedBy = lib.mkForce [];
          unitConfig.masked = "yes";
        };
        nscd = {
          enable = false;
          wantedBy = lib.mkForce [];
        };
      };

      timers = {
        "systemd-tmpfiles-clean".enable = false;
      };
      sockets = {
        "systemd-creds" = {enable = false;};
        "uuidd" = {enable = false;};
      };

      coredump.enable = false;
      settings.Manager = {DefaultTimeoutStopSec = "10s";};
    };
    #The option definition `services.journald.extraConfig' in `/nix/store/3zkj16lvs21dnz4vqdp5xxsyzjmpk5r2-source/modules/debloat.nix, via option nixos.modules.base' no longer has …
    #Use services.journald.settings.Journal instead.
    services = {
      speechd.enable = false;
      timesyncd.enable = false;
    };
    documentation = {
      enable = false;
      dev.enable = false;
      doc.enable = false;
      man.enable = true;
    };
    security.pam.loginLimits = [
      {
        domain = "*";
        type = "hard";
        item = "core";
        value = "0";
      }
      {
        domain = "*";
        type = "soft";
        item = "core";
        value = "0";
      }
    ];
  };
}
