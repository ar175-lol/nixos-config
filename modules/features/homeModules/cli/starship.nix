_: {
  flake.homeModules.myStarship = {...}: {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;

      settings =
        fromTOML
        (builtins.readFile ../../../../assets/starship.toml);
    };
  };
}
