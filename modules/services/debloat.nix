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
    services.journald.extraConfig = ''
      SystemMaxUse=200M
      SystemMaxFileSize=50M
    '';
    services.speechd.enable = false;
  };
}
