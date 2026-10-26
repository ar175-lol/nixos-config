{
  config,
  pkgs,
  ...
}: {
  programs.nh = {
    enable = true;
    flake = "${config.home.homeDirectory}/nixos-config";
  };

  home.packages = [
    pkgs.nix-output-monitor
    pkgs.nvd
  ];
}
