_: {
  nixos.desktop = _: {
    services = {
      xserver.displayManager.lightdm.enable = true;

      displayManager = {
        autoLogin = {
          enable = true;
          user = "ar175";
        };
      };
    };
  };
}
