_: {
  users.kirk.nixos.base = {pkgs, ...}: {
    users.users.kirk = {
      shell = pkgs.fish;
      hashedPassword = "$6$kbiOzcmbb755xoLr$eGNZKNOFh9P0.knRyQj72eT2HxLgx9VROYeyjgQXSP0hx1RXcMx9Fvmde0ubFOQrOt3HS3eDM8EOcG1JoPXwm0";
      description = "kirk";
      extraGroups = ["wheel" "video" "audio" "input" "adbusers"];
    };

    programs.fish.enable = true;
  };

  users.kirk.home.base = {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
      '';
    };
  };
}
