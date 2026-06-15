{...}: {
  nixos.home = {
    pkgs,
    inputs,
    ...
  }: let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in {
    imports = [inputs.spicetify-nix.homeManagerModules.spicetify];

    programs.spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblockify
      ];
      enabledCustomApps = with spicePkgs.apps; [
        marketplace
      ];
      colorScheme = "Base";
    };
  };
}
