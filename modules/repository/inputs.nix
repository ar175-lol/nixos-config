# I don't think I should keep it...
# TODO: think about it
{
  inputs,
  lib,
  ...
}: {
  flake-file = {
    inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      flake-file.url = "github:denful/flake-file";
      flake-parts.url = "github:hercules-ci/flake-parts";
      import-tree.url = "github:vic/import-tree";

      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      catppuccin.url = "github:catppuccin/nix";

      firefox-addons = {
        url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      ncalayer = {
        url = "github:ar175-lol/ncalayer-nix";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nixcord.url = "github:FlameFlag/nixcord";

      noctalia = {
        url = "github:noctalia-dev/noctalia/cachix";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nvf = {
        url = "github:NotAShelf/nvf";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      prism-launcher = {
        url = "github:ar175-lol/PrismLauncher-Cracked";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      sddm-astronaut-theme = {
        url = "github:ar175-lol/sddm-astronaut-theme";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      wrapper-modules = {
        url = "github:BirdeeHub/nix-wrapper-modules";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      zen-browser = {
        url = "github:0xc000022070/zen-browser-flake";
        inputs = {
          home-manager.follows = "home-manager";
          nixpkgs.follows = "nixpkgs";
        };
      };
    };

    do-not-edit = lib.concatLines (map (line: "# ${line}") (lib.splitString "\n" ''
      Heya! This flake.nix is auto-generated.
      https://flake-file.denful.dev/''));
  };

  imports = [inputs.flake-file.flakeModules.default];
}
