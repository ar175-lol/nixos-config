_: {
  homeManager.ar175 = {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;

      settings =
        fromTOML
        (builtins.readFile ./assets/starship.toml);
    };
  };
}
