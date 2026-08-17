_: {
  nixOnDroid.modules.base = {
    home-manager.config = {
      programs.ssh.enable = true;
      services.ssh-agent.enable = true;
    };
  };
}