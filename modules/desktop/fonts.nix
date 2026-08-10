{mkModuleOption, ...}: {
  options.nixos.desktop.fonts = mkModuleOption {key = "fonts";};

  config.nixos.desktop.fonts = {pkgs, ...}: {
    fonts = {
      enableDefaultPackages = true;
      fontconfig = {
        enable = true;
        defaultFonts.monospace = ["JetBrainsMono Nerd Font"];
      };
      packages = with pkgs; [nerd-fonts.jetbrains-mono];
    };
  };
}
