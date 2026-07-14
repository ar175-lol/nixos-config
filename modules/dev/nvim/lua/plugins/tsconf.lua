return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  version = false,
  build = ":TSUpdate",
  event = { "LazyFile", "VeryLazy" },
  cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
  opts = {
    indent = { enable = true },
    highlight = { enable = true },
    ensure_installed = {
      "bash",
      "lua",
      "nix",
      "rust",
      "python",
    },
  },
  config = function(_, opts)
    local TS = require("nvim-treesitter")

    TS.setup(opts)
    LazyVim.treesitter.get_installed(true)

    local install = vim.tbl_filter(function(lang)
      return not LazyVim.treesitter.have(lang)
    end, opts.ensure_installed or {})
    if #install > 0 then
      LazyVim.treesitter.build(function()
        TS.install(install, { summary = true }):await(function()
          LazyVim.treesitter.get_installed(true)
        end)
      end)
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("lazyvim_treesitter", { clear = true }),
      callback = function(ev)
        local ft, lang = ev.match, vim.treesitter.language.get_lang(ev.match)
        if not LazyVim.treesitter.have(ft) then
          return
        end

        ---@param feat string
        ---@param query string
        local function enabled(feat, query)
          local f = opts[feat] or {} ---@type lazyvim.TSFeat
          return f.enable ~= false
              and not (type(f.disable) == "table" and vim.tbl_contains(f.disable, lang))
              and LazyVim.treesitter.have(ft, query)
        end

        if enabled("highlight", "highlights") then
          pcall(vim.treesitter.start, ev.buf)
        end

        if enabled("indent", "indents") then
          LazyVim.set_default("indentexpr", "v:lua.LazyVim.treesitter.indentexpr()")
        end
      end,
    })
  end,
}
