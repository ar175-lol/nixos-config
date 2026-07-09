return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nixd = {
          settings = {
            nixd = {
              nixpkgs = {
                expr = "import <nixpkgs> { }",
              },

              formatting = {
                command = { "alejandra" },
              },

              options = {
                nixos = {
                  expr = '(builtins.getFlake "/home/ar175/nixos-config").nixosConfigurations.victus.options',
                },

                home_manager = {
                  expr =
                  '(builtins.getFlake "/home/ar175/nixos-config").nixosConfigurations.victus.options.home-manager.users.type.getSubOptions []',
                },

                flake_parts = {
                  expr = '(builtins.getFlake "/home/ar175/nixos-config").debug.options',
                },

                flake_parts_per_system = {
                  expr = '(builtins.getFlake "/home/ar175/nixos-config").currentSystem.options',
                },
              },
            },
          },
        },

        rust_analyzer = {},

        lua_ls = {
          mason = false,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      },
    },
  },
}
