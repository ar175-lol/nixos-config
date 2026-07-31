{
  description = "Why are you reading this?";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    git-hooks.url = "github:cachix/git-hooks.nix";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord.url = "github:FlameFlag/nixcord";

    mako-rs.url = "github:ar175-lol/mako-rs";
    battery-notifier.url = "github:ar175-lol/battery-notifier";
    rustbar.url = "github:ar175-lol/rustbar";

    prism-launcher.url = "github:ar175-lol/prism-launcher-flake";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports = [
        (inputs.import-tree ./modules)
      ];
      debug = true;
    };
}
