{lib, ...}: {
  users.nixos.nixos.base = _: {
    networking = {
      networkmanager.enable = lib.mkForce false;
      dhcpcd.enable = true;
      wireless.enable = lib.mkForce false;
    };
  };
}