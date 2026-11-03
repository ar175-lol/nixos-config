# Secrets (agenix)

Account password hashes are encrypted with [agenix] and stored as `.age` files
under `secrets/`. Only ciphertext belongs in git. The NixOS module is imported
once in `modules/tree/default.nix`; per-host declarations live in the host's own
directory.

## What is encrypted

| Secret | Encrypted file | Consumer |
|---|---|---|
| `ar175` password | `secrets/ar175-password.age` | `hosts/apollo/secrets.nix` -> `users.users.ar175.hashedPasswordFile` |
| `mom` password | `secrets/mom-password.age` | `hosts/apollo/secrets.nix` -> `users.users.mom.hashedPasswordFile` |

Each file contains only the salted `$6$...` crypt hash that used to be inline in
`hosts/apollo/host.nix`. The plaintext password is never stored in the repo.

## Boot and activation behavior

On every boot or `nixos-rebuild switch`, agenix:

1. creates a new tmpfs generation under `/run/agenix.d`
2. decrypts each `secrets/*.age` file with `/var/lib/age/agenix_ed25519`
3. symlinks `/run/agenix/<name>` to the decrypted file

It does **not** re-encrypt anything at boot. The `.age` files in the repo stay
encrypted; cleartext exists only in tmpfs and disappears on reboot.

This repo uses the default `users.mutableUsers = true`. NixOS therefore reads
`hashedPasswordFile` only when creating an account for the first time; existing
accounts keep their current passwords. On a fresh install the `users` activation
script depends on `agenixInstall`, so the password file is decrypted before the
account is created.

If the host key is missing or unreadable, agenix cannot decrypt the files. Back
it up before reinstalling or moving the system.

## Recipients

`secrets/agenix-rules.nix` lists who may decrypt each file. It is read by the
agenix CLI only and is not imported by the flake.

The current recipients are:

- `ar175`'s SSH key at `~/.ssh/id_ed25519.pub`
- the `apollo` host key at `/var/lib/age/agenix_ed25519.pub`

The host key is what lets the system decrypt both password files at boot.
`mom` does not have an SSH key on `apollo` yet, so `ar175` manages both secrets
for now. When `mom` has a key, add it to `secrets/agenix-rules.nix`, then rekey.

## Host key

`hosts/apollo/secrets.nix` sets:

```nix
age.identityPaths = ["/var/lib/age/agenix_ed25519"];
```

That private key is deliberately outside the repository and is not managed by
Nix. It must exist before the first activation of a system that declares these
secrets. On a fresh install, create it once:

```bash
doas mkdir -p /var/lib/age
doas ssh-keygen -t ed25519 -N '' -C 'apollo agenix host key' \
  -f /var/lib/age/agenix_ed25519
doas chmod 600 /var/lib/age/agenix_ed25519
doas cat /var/lib/age/agenix_ed25519.pub
```

Put the new public key in `secrets/agenix-rules.nix` and rekey. Back up the
private key somewhere safe: if it is lost, the existing `.age` files cannot be
decrypted until they are re-encrypted to a new key.

## Editing a secret

On `apollo`, the `agenix` CLI is installed through `environment.systemPackages`
in `hosts/apollo/secrets.nix`. On another machine, replace `agenix` below with
`nix run github:ryantm/agenix --`.

Run from `secrets/` so agenix finds `agenix-rules.nix`:

```bash
cd ~/nixos-config/secrets
agenix -e ar175-password.age
agenix -e mom-password.age
```

`$EDITOR` opens a temporary decrypted copy; agenix removes it after the editor
exits. To replace a value without opening an editor:

```bash
printf '%s\n' 'NEW_HASH' | agenix -e ar175-password.age
```

Generate a new hash with:

```bash
nix run nixpkgs#mkpasswd -- -m sha-512
```

## Rekeying after changing recipients

```bash
cd ~/nixos-config/secrets
agenix -r
agenix -c
```

`-r` re-encrypts every file to the current recipient list. `-c` verifies the
recipients in each file against `agenix-rules.nix` without decrypting it. The
rules use SSH keys because `-c` cannot check native `age1...` recipients.

## Never commit plaintext

The `.age` files are encrypted and safe to commit. Do not commit:

- decrypted output, including anything produced with `age -d`
- private keys such as `/var/lib/age/agenix_ed25519` or `~/.ssh/id_*`
- plaintext password hashes outside the encrypted files

`.gitignore` covers common decrypted filenames under `secrets/`, but do not rely
on it. Check `git status` before adding. If a decrypted secret or private key is
ever committed, rotate it and rekey; deleting the commit is not enough.

## Verifying

```bash
nix flake check --show-trace --fallback --no-build
nix build .#nixosConfigurations.apollo.config.system.build.toplevel --dry-run
```

After activation, confirm the decrypted files exist:

```bash
doas ls -l /run/agenix/ar175-password /run/agenix/mom-password
```

[agenix]: https://github.com/ryantm/agenix
