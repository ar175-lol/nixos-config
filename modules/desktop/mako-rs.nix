_: {
  nixos.home = {inputs, ...}: {
    imports = [inputs.mako-rs.homeModules.default];

    programs.mako-rs = {
      enable = true;
    };
  };
}
