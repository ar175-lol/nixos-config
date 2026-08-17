_: {
  flake-file.inputs = {
    nixpkgs-phone.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager-phone = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-phone";
    };
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs = {
        nixpkgs.follows = "nixpkgs-phone";
        home-manager.follows = "home-manager-phone";
      };
    };
  };
}
