_: {
  users.nixos.nixos.base = {pkgs, ...}: {
    users.users.nixos.shell = pkgs.fish;

    programs.fish.enable = true;
  };
}
