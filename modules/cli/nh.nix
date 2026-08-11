_: {
  homeManager.ar175 = {
    pkgs,
    config,
    ...
  }: {
    programs.nh = {
      enable = true;
      flake = "${config.home.homeDirectory}/nixos-config";
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
