{lib, ...}: {
  homeManager.ar175 = {inputs, ...}: {
    imports = [inputs.rustbar.homeModules.default];

    programs.rustbar.enable = true;

    systemd.user.services.rustbar = {
      Service.RuntimeMaxSec = lib.mkForce "12h";
    };
  };
}
