{...}: {
  flake.nixosModules.usersConfiguration = {pkgs, ...}: {
    users.users.ar175 = {
      isNormalUser = true;
      hashedPassword = "$6$nxk4tJSRBd8udBQm$rKcgUIaowcy8TKnMwTAcLcrjGyBL.qs4b75dxRUT4GSB75txej3rEZ6R40Bg6Adh6vq3cHhOLtxPJljhzUvIy1";
      shell = pkgs.zsh;
      description = "ar175";
      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
        "audio"
        "libvirtd"
        "input"
        "adbusers"
      ];
    };
    security.sudo.wheelNeedsPassword = false;
    programs.zsh.enable = true;
  };
}
