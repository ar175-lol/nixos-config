_: {
  nixos.modules.base = _: {
    programs.nixvim.plugins = {
      mini-ai.enable = true;
      mini-pairs.enable = true;
      mini-surround.enable = true;

      mini-icons = {
        enable = true;
        mockDevIcons = true;
      };
    };
  };
}
