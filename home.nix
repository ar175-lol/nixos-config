{ pkgs, ...}:

{
  home = {
        username = "ar175";
        homeDirectory = "/home/ar175";
        stateVersion = "26.05";
        packages = with pkgs; [
            fastfetch
        ];
    };

  programs = {
    # Fish
    fish = {
      enable = true;
      shellAliases = {
        update = "cd /etc/nixos && nix flake update && sudo nixos-rebuild switch --flake .";
        clean = "sudo nix-collect-garbage -d && sudo nix-store --optimize";
      };
      # Greeting
      interactiveShellInit = ''
        set -g fish_greeting ""
        fastfetch --logo nixos_small -s OS:Kernel:Uptime:DE:CPU:GPU:MEMORY
      '';
    };
    #firefox = {
    #enable = true;
    #  profiles.ar175 = {
    # settings = {
    #   "browser.startup.homepage" = "https://nixos.org";
    #    "browser.toolbarbuttons.introduced.pocket-button"  = false;
    #    "general.useragent.locale" = "en_US";
    #    };
    #   };
    #};

    git = {
      enable = true;
      settings = {
        user = {
          name = "ar175-lol";
          email = "ghailmbv@proton.me";
        };
      };
    };
  };
  programs.home-manager.enable = true;
}

