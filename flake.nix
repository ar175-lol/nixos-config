# Heya! This flake.nix is auto-generated.
# The source of truth for its content is merged from across the modules/ tree.
# Each input is declared in the module where it's actually used.
# https://flake-file.denful.dev/
{
  outputs = inputs: import ./outputs.nix inputs;

  inputs = {
    battery-notifier.url = "github:ar175-lol/battery-notifier";
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
    home-manager-phone = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-phone";
    };
    import-tree.url = "github:vic/import-tree";
    lix-module = {
      url = "git+https://git.lix.systems/lix-project/nixos-module";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mako-rs.url = "github:ar175-lol/mako-rs";
    ncalayer = {
      url = "github:ar175-lol/ncalayer-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs = {
        home-manager.follows = "home-manager-phone";
        nixpkgs.follows = "nixpkgs-phone";
      };
    };
    nixcord.url = "github:FlameFlag/nixcord";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-phone.url = "github:nixos/nixpkgs/nixos-24.05";
    nixvim.url = "github:nix-community/nixvim";
    prism-launcher.url = "github:ar175-lol/prism-launcher-flake";
    rustbar.url = "github:ar175-lol/oxidizedbar";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };
}
