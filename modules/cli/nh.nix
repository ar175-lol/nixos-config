_: {
  homeManager.ar175 = {pkgs, ...}: {
    programs.nh = {
      enable = true;
      flake = "/home/ar175/nixos-config";
      clean = {
        enable = true;
      };
    };
    home.packages = with pkgs; [
      nix-output-monitor
      nvd
    ];
  };
}
