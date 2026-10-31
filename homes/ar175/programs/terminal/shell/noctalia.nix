{pkgs, ...}: let
  noctaliaSync = pkgs.writeShellApplication {
    name = "noctalia-sync";
    runtimeInputs = [pkgs.gnused pkgs.git pkgs.nh];

    text = ''
      set -euo pipefail

      repo="$HOME/nixos-config"
      settings="$HOME/.local/state/noctalia/settings.toml"
      config="$repo/modules/core/common/system/programs/noctalia/config.toml"

      sed -E \
        -e 's|@DATA@|@ASSETS@|g' \
        -e "s|$HOME/nixos-config/data|@ASSETS@|g" \
        -e "s|$HOME/nixos-config/modules/core/common/system/programs/noctalia/assets|@ASSETS@|g" \
        -e 's|/nix/store/[[:alnum:]]+-assets|@ASSETS@|g' \
        "$settings" > "$config"

      git -C "$repo" add "$repo"
      cd "$repo"
      nh os switch
    '';
  };
in {
  home.packages = [noctaliaSync];
}
