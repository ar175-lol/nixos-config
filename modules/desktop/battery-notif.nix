{
  inputs,
  lib,
  ...
}: {
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

  nixos.desktop = _: {
    nix.settings = {
      substituters = lib.mkAfter ["https://rust-cache.cachix.org"];
      trusted-public-keys = lib.mkAfter ["rust-cache.cachix.org-1:/2RZFpe8MfT9zsY2YkhgYyY3bFVoEOmhpS9PZ+oKjgM="];
    };
  };
}
