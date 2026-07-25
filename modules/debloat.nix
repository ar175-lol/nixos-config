# Doing some shit here I guess...
_: {
  nixos.desktop = {lib, ...}: {
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
    services = {
      journald.extraConfig = ''
        SystemMaxUse=200M
        SystemMaxFileSize=50M
      '';
      speechd.enable = false;
      timesyncd.enable = false;
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
