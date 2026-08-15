_: {
  nixos.modules.base = _: {
    programs.nixvim = {
      plugins.blink-cmp = {
        enable = true;

        settings = {
          keymap = {
            preset = "default";

            "<CR>" = [
              "accept"
              "fallback"
            ];
            "<Tab>" = [
              "select_next"
              "fallback"
            ];
            "<S-Tab>" = [
              "select_prev"
              "fallback"
            ];
          };

          appearance.nerd_font_variant = "mono";

          sources = {
            default = [
              "lsp"
              "path"
              "snippets"
              "buffer"
            ];
            per_filetype = {
              nix = [
                "lsp"
                "path"
                "snippets"
              ];
              markdown = [
                "snippets"
                "path"
                "buffer"
                "lsp"
              ];
            };
          };

          snippets = {
            expand.__raw = "function(snippet, _) vim.snippet.expand(snippet) end";

            active.__raw = "function() return vim.snippet.active() end";

            jump.__raw = "function(direction) vim.snippet.jump(direction) end";
          };

          completion = {
            documentation.auto_show = true;

            menu.draw.columns.__raw = ''
              {
                { "kind_icon" },
                { "label", "label_description", gap = 1 },
                { "source_name" },
                { "kind" },
              }
            '';
          };

          fuzzy.implementation = "prefer_rust_with_warning";
        };
      };

      plugins.friendly-snippets.enable = true;
    };
  };
}
