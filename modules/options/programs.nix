{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  options.modules.system.programs = {
    niri.enable = mkEnableOption "the niri compositor";
    greeter.enable = mkEnableOption "the Noctalia display manager";
    noctalia.enable = mkEnableOption "the Noctalia desktop shell";

    tmux.enable = mkEnableOption "tmux";
    starship.enable = mkEnableOption "the starship prompt";

    browser.enable = mkEnableOption "Zen Browser";
    neovim.enable = mkEnableOption "Neovim";

    git.enable = mkEnableOption "git, with your identity";
    direnv.enable = mkEnableOption "direnv, with nix-direnv and devenv";
    nh.enable = mkEnableOption "nh, pointed at your config";
    opencode.enable = mkEnableOption "opencode";

    discord.enable = mkEnableOption "Discord";
    telegram.enable = mkEnableOption "Telegram";
    localsend.enable = mkEnableOption "LocalSend";

    obs.enable = mkEnableOption "OBS Studio";
    kdenlive.enable = mkEnableOption "Kdenlive";
    libreoffice.enable = mkEnableOption "LibreOffice";

    gaming.enable = mkEnableOption "Steam, Bottles and qBittorrent";

    minecraft. enable = mkEnableOption "Minecraft, via Prism Launcher";

    virtualisation.enable = mkEnableOption "hardware virtualisation (kvm)";
    adb.enable = mkEnableOption "Android debugging bridge";
    printing.enable = mkEnableOption "printing and scanning";
    ncalayer.enable = mkEnableOption "ncalayer network manager";
  };
}
