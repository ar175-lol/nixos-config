{
  self,
  inputs,
  lib,
  ...
}: {
  flake-file.inputs.wrapper-modules = {
    url = "github:BirdeeHub/nix-wrapper-modules";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  users.ar175.nixos.pc = {
    pkgs,
    config,
    ...
  }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri.override {
        hostName = config.networking.hostName;
      };
    };

    environment.systemPackages = [pkgs.nautilus];
  };

  perSystem = {
    config,
    pkgs,
    ...
  }: {
    options.myNiri = {
      settings = lib.mkOption {
        type = lib.types.attrsOf lib.types.anything;
        default = {};
      };
      debug = lib.mkOption {
        type = lib.types.attrsOf lib.types.anything;
        default = {};
      };
    };

    config.packages.myNiri = pkgs.callPackage ({hostName ? ""}:
      inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        settings =
          config.myNiri.settings
          // lib.optionalAttrs (hostName == "victus") {
            debug = config.myNiri.debug;
          };
      }) {};
  };
}
