local null_ls = require("null-ls")
local b = null_ls.builtins

local filetypeTS = {"javascript", "javascriptreact",
        "javascript.jsx", "typescript",
        "typescriptreact", "typescript.tsx"}

local sources = {
    b.formatting.prettierd.with{
      filetypes = filetypeTS,
      prefer_local = "node_modules/.bin"
    },
    b.diagnostics.eslint_d.with{
      filetypes = filetypeTS,
      prefer_local = "node_modules/.bin"
    },
    b.code_actions.eslint_d.with{
      filetypes = filetypeTS,
      prefer_local = "node_modules/.bin"
    },
}

local M = {}
M.setup = function(on_attach)
    null_ls.setup({
        -- debug = true,
        sources = sources,
        on_attach = on_attach,
    })
end

return M

