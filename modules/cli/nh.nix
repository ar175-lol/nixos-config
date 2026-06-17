_: {
  nixos.home = {pkgs, ...}: {
    programs.nh = {
      enable = true;
      flake = "/home/ar175/nix-test-v2";
      clean = {
        enable = true;
        extraArgs = "--no-direnv";
      };
    };
    home.packages = with pkgs; [
      nix-output-monitor
      nvd
    ];
  };
}
