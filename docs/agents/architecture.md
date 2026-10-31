# Architecture

## Evaluation flow

```text
flake.nix                              hand-maintained; outputs = import ./outputs.nix inputs
└── outputs.nix                        flake-parts.mkFlake
    ├── imports modules/.../neovim/_package.nix
    ├── imports modules/.../noctalia/_package.nix
    ├── imports ./hosts                    root-level wiring for every host
    │   └── hosts/default.nix              imports hosts/*/host.nix
    └── import-tree ./modules/tree
        └── modules/tree/module.nix        declares the `hosts` option and builds hosts
```

`modules/tree/module.nix` is the center of the architecture. It declares a
flake-parts option named `hosts` (not a NixOS option) and turns every enabled
entry into `flake.nixosConfigurations.<name>`:

```nix
root = self.outPath;
modulePath = root + "/modules";
rolesPath = modulePath + "/core/roles";

commonTrees = [
  (modulePath + "/options")
  (modulePath + "/core/common")
  (modulePath + "/core/profiles")
  (modulePath + "/hardware")
];

mkHost = host:
  inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs self;};

    modules = lib.flatten [
      (map (tree: inputs.import-tree tree) commonTrees)
      (map (role: inputs.import-tree (rolesPath + "/${role}")) host.roles)
      host.extraModules
      host.features

      {
        networking.hostName = host.hostName;
        system.stateVersion = host.stateVersion;
      }

      (builtins.attrValues (
        lib.mapAttrs' (name: spec: lib.nameValuePair name (userModule name spec)) host.users
      ))
    ];
  };
```

Consequences:

- Every host gets `options`, `core/common`, `core/profiles`, and `hardware`.
  These trees are imported for every machine, so adding a program or option does
  not require editing a host or an import list.
- Only the role directories named in `host.roles` are imported for that host.
- `host.extraModules` and `host.features` are per-host.
- `hostName` and `stateVersion` are set inline; everything else comes from modules.
- `specialArgs = {inherit inputs self;}` makes `inputs` and the flake itself
  available in every NixOS module.
- `lib.filterAttrs (_: host: host.enable)` means `hosts.<name>.enable = false`
  produces no `nixosConfiguration` at all.

`flake.nix` declares the flake inputs and delegates to `outputs.nix`, the real
entry point. Neither file defines hosts; hosts live under `hosts/` and are built
by `modules/tree`.

## Directory layout

```text
flake.nix                 hand-maintained inputs; delegates to outputs.nix
outputs.nix               flake-parts entry point; systems, formatter, explicit _package imports
flake.lock

hosts/
  default.nix             manually imports each host's host.nix
  apollo/host.nix         host declaration for the workstation
  apollo/fs.nix           btrfs/EFI layout for apollo; pulled in via extraModules
  iso/host.nix            host declaration for the installer
  iso/live.nix            ISO-only config (Calamares, network overrides); via extraModules

homes/
  <user>/home.nix         Home Manager entry point for one account
  <user>/programs/        that account's program configuration
  <user>/themes/          that account's visual configuration

modules/
  tree/
    module.nix            flake-parts `hosts` option and mkHost
  options/
    module.nix            imports the main option files
    device.nix            modules.device.*   hardware capabilities
    profiles.nix          modules.profiles.* software bundles
    programs.nix          modules.system.programs.*
    system.nix            modules.system.* (loader, doas, fonts, zram, ...)
  core/
    common/               always imported for every host
      system/             common OS configuration
        home-manager.nix  home-manager integration and common arguments
        nix/              nix settings, Lix, and wrapper overlays
        os/               boot, loader, doas, debloat, fonts, locale, networking
        programs/name.nix           program implementation
        programs/name/              implementation plus assets/shared files
        programs/name/_foo.nix      shared Nix code/data; skipped by import-tree
    roles/                imported only for a host that lists the role
    profiles/             always imported; their config is gated by profile options
  hardware/               always imported; config gated by device/system/program options
```

## What import-tree imports

import-tree recursively imports every `.nix` file under a tree, except paths
containing a `_`-prefixed file or directory. Non-Nix files (TOML, PNG, etc.) are
ignored. This is why:

- `_settings.nix`, `_policies.nix`, and `_package.nix` are not auto-imported.
- `neovim/_settings.nix` is imported explicitly by the module that needs it.
- `neovim/_package.nix` and `noctalia/_package.nix` are explicitly imported by
  `outputs.nix` because they are flake-level modules, not NixOS modules.
- `noctalia/config.toml` and `noctalia/assets/` are safely beside the module.

`module.nix` has no special meaning to Nix or import-tree. It is a naming convention
for the main file of a directory. Any `.nix` file in a tree is imported.

## Import topology

Keep imports downward and local. Cross-tree wiring is centralized:

- `outputs.nix` imports `./hosts` and the `modules` trees.
- `hosts/default.nix` imports each `hosts/<name>/host.nix`.
- A host file imports only files in its own directory (`./fs.nix`, `./live.nix`).
  It does not reach into `modules/` or `homes/`.
- Files inside a module tree are auto-imported by import-tree; they do not import
  siblings with relative paths.
- Root-relative references use `self.outPath + "/..."`. flake-parts provides
  `self`; `mkHost` forwards it to NixOS, and
  `core/common/system/home-manager.nix` forwards it to Home Manager. There is no
  custom `flakeRoot` argument.

## Host model

`hosts.<name>` is a flake-parts submodule with these fields:

| Field | Meaning |
|---|---|
| `enable` | Build this host at all. Filtered in `mkHost`. |
| `hostName` | Becomes `networking.hostName`. |
| `stateVersion` | Becomes `system.stateVersion`. Do not change casually. |
| `roles` | List of directory names under `modules/core/roles/`. Every `.nix` in each named directory is imported for this host. |
| `users` | Attrset keyed by account name. Each entry creates both a system account and a Home Manager generation. `homeModules` defaults to `homes/<name>/home.nix` when that file exists. |
| `features` | A `deferredModule` inserted into the system. Use it for enable flags and direct NixOS config for this host. |
| `extraModules` | A list of modules imported only by this host. Used for `fs.nix` and installer modules. |

Example (the real `apollo` host, shortened):

```nix
_: {
  hosts.apollo = {
    enable = true;
    hostName = "apollo";
    stateVersion = "26.05";

    users = {
      ar175 = {
        description = "ar175";
        shell = "zsh";
        hashedPassword = "…";
        extraGroups = ["wheel" "video" "audio" "input" "adbusers"];
      };
      mom = {
        description = "mom";
        shell = "fish";
        hashedPassword = "…";
        extraGroups = ["video" "audio" "input"];
      };
    };

    roles = ["graphical" "workstation" "laptop"];

    features = {
      modules = {
        device = {
          hasSound = true;
          hasBluetooth = true;
          cpu.type = "intel";
          gpu = {
            intel.enable = true;
            nvidia = {
              enable = true;
              prime = {
                enable = true;
                intelBusId = "PCI:0:2:0";
                nvidiaBusId = "PCI:1:0:0";
              };
            };
          };
        };

        system = {
          programs.plasma.enable = true;
          programs.steam.enable = true;
          programs.flatpak.enable = true;
          loader.enable = true;
          fonts.enable = true;
        };

        profiles.workstation.enable = true;
      };
    };

    extraModules = [./fs.nix];
  };
}
```

`features` is a module value, so its content is regular NixOS config. The current
hosts write under `modules.*` because all custom options are rooted at `modules`.
It can also set stock NixOS options directly, and it can be written as a function
(`{lib, pkgs, ...}: { ... }`) if it needs module arguments.

### Users

`userModule` in `modules/tree/module.nix` expands each user as follows:

```nix
userModule = name: spec: {pkgs, ...}: {
  users.users.${name} = {
    isNormalUser = true;
    useDefaultShell = true;
    inherit (spec) description extraGroups hashedPassword;
    home = spec.homeDirectory;
    shell = pkgs.${spec.shell};
  };

  home-manager.users.${name} = {osConfig, ...}: {
    imports = spec.homeModules;
    home.username = spec.username;
    home.homeDirectory = spec.homeDirectory;
    home.stateVersion = osConfig.system.stateVersion;
  };
};
```

Defaults: `username = name`, `homeDirectory = "/home/${name}"`, `description = ""`,
`shell = "bash"`, `extraGroups = []`, `hashedPassword = null`, and `homeModules`
defaults to `homes/<name>/home.nix` when that file exists.
`shell` is a package attribute name, so `"zsh"` becomes `pkgs.zsh`.

The Home Manager entry point is found by convention. Set `homeModules` explicitly
only to override it. Keep Home Manager configuration under `homes/<name>/`; NixOS
modules must not inject it through `home-manager.sharedModules`.
Some modules still hardcode `users.users.ar175`; see [Pitfalls](pitfalls.md).

## The three axes

1. `modules.device.*` — hardware capability: sound, Bluetooth, CPU vendor, GPUs.
   Implementations are in `modules/hardware/`.
2. `roles` — what the machine *is*. A role directory is imported wholesale for the
   host. Role code is unconditional; a graphical machine simply gets a session.
3. `modules.profiles.*` and `modules.system.programs.*` — NixOS software. Profiles are
   always imported but gated by their enable option, and they turn programs on with
   `lib.mkDefault`. A host can therefore disable one program while keeping the
   profile.

Profile and role modules use `lib.mkDefault`, so a host's normal-priority assignment
wins. For example, a host can set `modules.system.programs.opencode.enable = false`
while keeping the `workstation` profile enabled, without `mkForce`.

`modules/hardware/` is organizational, not strictly device-gated: `adb.nix` and
`virtualisation.nix` live there but are gated by program options
(`modules.system.programs.adb` and `modules.system.programs.virtualisation`).

## Current hosts

| Host | Roles | Profiles | Notable choices |
|---|---|---|---|
| `apollo` | `graphical`, `workstation`, `laptop` | `workstation` | Intel CPU, Intel + NVIDIA PRIME, sound, Bluetooth, Limine, fonts, Plasma, Steam, Flatpak, btrfs subvolumes in `fs.nix` |
| `iso` | `graphical` | none | Noctalia greeter off, Neovim on, installation-CD module + `live.nix` (Calamares, dhcpcd, xanmod, polkit) |

Both use `stateVersion = "26.05"`. There is currently no `gaming` profile or
program option; Steam and Flatpak are enabled directly in `hosts/apollo/host.nix`.
