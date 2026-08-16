{inputs, ...}: {
  users.nixos.home.base = {
    imports = [
      inputs.rustbar.homeModules.default
      inputs.mako-rs.homeModules.default
    ];

    home = {
      username = "nixos";
      homeDirectory = "/home/nixos";
    };

    programs.rustbar.enable = true;
  };
}