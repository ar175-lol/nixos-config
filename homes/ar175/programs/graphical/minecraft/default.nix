{
  inputs,
  pkgs,
  ...
}: {
  programs.prismlauncher = {
    enable = true;
    package = inputs.prism-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
}
