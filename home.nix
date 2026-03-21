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
        update = "sudo nixos-rebuild switch --flake . --update-input nixpkgs && nix-collect-garbage -d && git add . && git commit -m 'run a update: $(date +%D_%H:%M)' && git push";
        sudo-dolphin = "dolphin --sudo";
        clean = "sudo nix-collect-garbage -d && sudo nix-store --optimize";
      };
      # Greeting
      interactiveShellInit = ''
        set -g fish_greeting ""
        fastfetch --logo nixos_small -s OS:Kernel:Uptime:DE:CPU:GPU:MEMORY
      '';
    };

    git = {
      enable = true;
      userName = "ar175-lol";
      userEmail = "ghailmbv@proton.me";
    };

    home-manager.enable = true;
  };
}

