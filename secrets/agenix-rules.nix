# Recipients for the encrypted secrets in this directory.
# This file is only read by the agenix CLI; it is not imported by the flake.
let
  ar175 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBqoxVGnRwZSNB08453kRs4VZEBkLZkKMauZErQUERX9 ar175-lol@github.com";
  apollo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEgqKiRZq6GHnNFGaOz9R4zABE1UFLF6HjwfO1fKZjjQ apollo agenix host key";
in {
  # mom has no SSH key on apollo yet, so ar175 can edit both secrets and the
  # host key decrypts them at boot. Add mom's public key and run `agenix -r`
  # when she has one.
  "ar175-password.age".publicKeys = [ar175 apollo];
  "mom-password.age".publicKeys = [ar175 apollo];
}
