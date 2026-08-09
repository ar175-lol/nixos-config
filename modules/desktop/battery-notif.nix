{inputs, ...}: {
  flake-file.inputs.battery-notifier.url = "github:ar175-lol/battery-notifier";

  homeManager.ar175 = _: {
    imports = [
      inputs.battery-notifier.homeModules.default
    ];

    services.battery-notifier = {
      enable = true;
      pollIntervalSecs = 15;
      lowThreshold = 10;
      warnThreshold = 25;
    };
  };
}
