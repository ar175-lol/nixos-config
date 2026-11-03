{
  config,
  inputs,
  pkgs,
  ...
}: {
  # This key is generated on apollo and deliberately lives outside the repo.
  # See docs/secrets.md before changing it.
  age.identityPaths = ["/var/lib/age/agenix_ed25519"];

  age.secrets = {
    ar175-password.file = ../../secrets/ar175-password.age;
    mom-password.file = ../../secrets/mom-password.age;
  };

  environment.systemPackages = [inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default];

  users.users.ar175.hashedPasswordFile = config.age.secrets.ar175-password.path;
  users.users.mom.hashedPasswordFile = config.age.secrets.mom-password.path;
}
