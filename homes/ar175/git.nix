{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "ar175-lol";
        email = "ghailmbv@proton.me";
        signingkey = "~/.ssh/id_ed25519.pub";
      };
      gpg.format = "ssh";
      commit.gpgsign = true;
    };
  };
}
