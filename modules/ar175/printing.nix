_: {
  users.ar175.nixos.pc = {pkgs, ...}: {
    hardware.sane = {
      enable = true;
      extraBackends = [pkgs.sane-airscan];
    };

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish = {
        enable = true;
        addresses = true;
      };
    };

    services.printing.enable = true;

    users.users.ar175.extraGroups = ["scanner" "lp"];
  };
}
