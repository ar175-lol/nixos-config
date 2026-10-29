{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  options.modules.system.programs = {
    plasma.enable = mkEnableOption "the KDE Plasma";
    niri.enable = mkEnableOption "the niri compositor";
    greeter.enable = mkEnableOption "the display manager";
    noctalia.enable = mkEnableOption "the desktop shell";

    tmux.enable = mkEnableOption "tmux";
    neovim.enable = mkEnableOption "Neovim";

    opencode.enable = mkEnableOption "opencode";

    localsend.enable = mkEnableOption "LocalSend";

    kdenlive.enable = mkEnableOption "Kdenlive";
    libreoffice.enable = mkEnableOption "LibreOffice";

    flatpak.enable = mkEnableOption "Flatpak";
    steam.enable = mkEnableOption "Steam";

    virtualisation.enable = mkEnableOption "hardware virtualisation (kvm)";
    adb.enable = mkEnableOption "Android debugging bridge";
    printing.enable = mkEnableOption "printing and scanning";
  };
}
