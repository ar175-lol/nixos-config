_: {
  nixos.victus = {
    virtualisation.containers.registries.search = ["docker.io"];

    virtualisation.podman.enable = true;
  };
}
