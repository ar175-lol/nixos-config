# Heya! This flake.nix is auto-generated.
# The source of truth for its content is merged from across the modules/ tree.
# Each input is declared in the module where it's actually used.
# https://flake-file.denful.dev/
{
  outputs = inputs: import ./outputs.nix inputs;

  inputs = {
    battery-notifier = {
      url = "github:ar175-lol/battery-notifier";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko.url = "github:nix-community/disko";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-file.url = "github:denful/flake-file";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree.url = "github:vic/import-tree";
    mako-rs.url = "github:ar175-lol/mako-rs";
    ncalayer = {
      url = "github:ar175-lol/ncalayer-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nixcord.url = "github:FlameFlag/nixcord";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    prism-launcher.url = "github:ar175-lol/prism-launcher-flake";
    rustbar = {
      url = "github:ar175-lol/oxidizedbar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    wrapper-modules = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };
}
