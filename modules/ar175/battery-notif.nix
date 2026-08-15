{inputs, ...}: {
  flake-file.inputs.battery-notifier.url = "github:ar175-lol/battery-notifier";

  users.ar175.home.gui = {...}: {
    imports = [inputs.battery-notifier.homeModules.default];

    services.battery-notifier = {
      enable = true;
      pollIntervalSecs = 15;
      lowThreshold = 10;
      warnThreshold = 25;
    };
  };
}
