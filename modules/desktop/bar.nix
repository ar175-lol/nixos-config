{lib, ...}: {
  homeManager.ar175 = {inputs, ...}: {
    imports = [inputs.rustbar.homeModules.default];

    programs.rustbar.enable = true;

    systemd.user.services.rustbar = {
      Service.RuntimeMaxSec = lib.mkForce "2h";
    };
  };
  nixos.desktop = {lib, ...}: {
    nix.settings = {
      substituters = lib.mkAfter ["https://rust-cache.cachix.org"];
      trusted-public-keys = lib.mkAfter ["rust-cache.cachix.org-1:/2RZFpe8MfT9zsY2YkhgYyY3bFVoEOmhpS9PZ+oKjgM="];
    };
  };
}
