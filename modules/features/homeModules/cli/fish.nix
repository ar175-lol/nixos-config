{self, ...}: {
  flake.homeModules.myFish = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.myStarship pkgs.fastfetch];
    programs.fish = {
      enable = true;

      shellAbbrs = {
        update = "git add . && sudo nixos-rebuild switch --flake .#victus";
        upgrade = "git add . && nix flake update && sudo nixos-rebuild switch --flake .#victus";
        ncg = "sudo nix-collect-garbage -d";
      };

      interactiveShellInit = ''
        starship init fish | source
        set fish_greeting
        fastfetch
      '';
    };
  };
}
