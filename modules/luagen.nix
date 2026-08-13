{lib, ...}: let
  inherit (lib.generators) toLua mkLuaInline;
  luaExpr = value: toLua {} value;

  genOption = o:
    if o ? append
    then "vim.opt.${o.name}:append(${luaExpr o.value})"
    else "vim.opt.${o.name} = ${luaExpr o.value}";

  genGlobal = name: value: "vim.g.${name} = ${luaExpr value}";

  genKeymap = k: let
    opts = (k.opts or {}) // lib.optionalAttrs (k ? desc) {inherit (k) desc;};
  in "vim.keymap.set(${luaExpr k.mode}, ${luaExpr k.lhs}, ${luaExpr k.rhs}, ${luaExpr opts})";

  genAutocmd = a: "vim.api.nvim_create_autocmd(${luaExpr a.event}, ${luaExpr (lib.removeAttrs a ["event"])})";

  genCall = c: "vim.${c.fn}(${lib.concatMapStringsSep ", " luaExpr c.args})";

  genPlugin = p: "require(${luaExpr p.module}).${p.call or "setup"}(${luaExpr (p.config or {})})";

  genLspAttach = keymaps: ''
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local map = function(mode, keys, fn)
          vim.keymap.set(mode, keys, function() vim.lsp.buf[fn]() end, { buffer = args.buf, desc = "LSP: " .. fn })
        end
        ${lib.concatMapStringsSep "\n" (k: "map(${luaExpr (k.mode or "n")}, ${luaExpr k.key}, ${luaExpr k.fn})") keymaps}
      end,
    })
  '';

  genFormatOnSave = names: ''
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function(args)
        vim.lsp.buf.format({
          bufnr = args.buf,
          async = false,
          filter = function(client)
            local capable = { ${lib.concatMapStringsSep ", " luaExpr names} }
            for _, name in ipairs(capable) do
              if client.name == name then
                return true
              end
            end
            return false
          end,
        })
      end,
    })
  '';
in {
  _module.args.luaGen = {
    inherit
      toLua
      mkLuaInline
      luaExpr
      genOption
      genGlobal
      genKeymap
      genAutocmd
      genCall
      genPlugin
      genLspAttach
      genFormatOnSave
      ;
  };
}
