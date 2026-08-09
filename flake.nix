# Heya! This flake.nix is auto-generated.
# The source of truth for its content is merged from across the modules/ tree.
# Each input is declared in the module where it's actually used.
# https://flake-file.denful.dev/
{
  outputs = inputs: import ./outputs.nix inputs;
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    battery-notifier.url = "github:ar175-lol/battery-notifier";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-file.url = "github:denful/flake-file";
    home-manager.url = "github:nix-community/home-manager";
    import-tree.url = "github:vic/import-tree";
    mako-rs.url = "github:ar175-lol/mako-rs";
    nixcord.url = "github:FlameFlag/nixcord";
    prism-launcher.url = "github:ar175-lol/prism-launcher-flake";
    rustbar.url = "github:ar175-lol/oxidizedbar";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };
}
