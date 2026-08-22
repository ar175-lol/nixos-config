_: {
  users.ar175.home.base = {
    pkgs,
    config,
    ...
  }: {
    programs.nh = {
      enable = true;
      flake = "${config.home.homeDirectory}/nixos-config";
    };
    home.packages = with pkgs; [
      nix-output-monitor
      nvd
    ];
  };
}
