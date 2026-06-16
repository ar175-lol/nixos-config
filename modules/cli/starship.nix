_: {
  nixos.home = _: {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;

      settings =
        fromTOML
        (builtins.readFile ./assets/starship.toml);
    };
  };
}
