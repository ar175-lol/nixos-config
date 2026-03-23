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

    fish = {
      enable = true;
      shellAliases = {
        update = "cd /etc/nixos && nix flake update && sudo nixos-rebuild switch --flake .";
        clean = "sudo nix-collect-garbage -d && sudo nix-store --optimize";
      };
      
      interactiveShellInit = ''
        set -g fish_greeting ""
        fastfetch --logo nixos_small -s OS:Kernel:Uptime:DE:CPU:GPU:MEMORY
      '';
    };
    
    firefox = {
      enable = true;
      profiles.ar175 = {
      settings = {
        "browser.startup.homepage" = "https://nixos.org";
         "browser.toolbarbuttons.introduced.pocket-button"  = false;
         "general.useragent.locale" = "en_US";
         };
        };
     };

    vscode = {
      enable = true;
      package = pkgs.vscodium;
    
      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
          mkhl.direnv
          arrterian.nix-env-selector
        ];

        userSettings = {
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "nix.formatterPath" = "nixfmt"; 
          "editor.formatOnSave" = true;
        
          "nixd" = {
            "formatting" = {
              "command" = [ "nixfmt" ];
            };
            "options" = {
              "nixos" = {
                "expr" = "(builtins.getFlake \"/etc/nixos\").nixosConfigurations.nixos.options";
              };
            };
          };
        };
      };
    };

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

