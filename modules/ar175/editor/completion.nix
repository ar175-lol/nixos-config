{
  nixos.modules.base = {lib, ...}: {
    programs.nvf.settings.vim.autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;

      setupOpts = {
        appearance.nerd_font_variant = "mono";

        sources.per_filetype = {
          nix = ["lsp" "path" "snippets"];
          markdown = ["snippets" "path" "buffer" "lsp"];
        };

        completion.menu.draw.columns = lib.generators.mkLuaInline ''
          {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "source_name" },
            { "kind" },
          }
        '';
      };
    };
  };
}
