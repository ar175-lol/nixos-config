{inputs, ...}: {
  flake-file.inputs.mako-rs.url = "github:ar175-lol/mako-rs";

  users.ar175.home.gui = {...}: {
    imports = [inputs.mako-rs.homeModules.default];

    programs.mako-rs.enable = true;
  };
}
