local u = require("utils")

local M = {}
M.setup = function(on_attach, capabilities)
    local lspconfig = require("lspconfig")
    local ts_utils = require("nvim-lsp-ts-utils")

    lspconfig["tsserver"].setup({
        root_dir = lspconfig.util.root_pattern("package.json"),

        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            -- disable tsserver formatting
            client.resolved_capabilities.document_formatting = false

            ts_utils.setup({})
            ts_utils.setup_client(client)

            u.buf_map(bufnr, "n", "<leader>go", ":TSLspOrganize<CR>")
            u.buf_map(bufnr, "n", "<leader>gR", ":TSLspRenameFile<CR>")
            u.buf_map(bufnr, "n", "<leader>gI", ":TSLspImportAll<CR>")
        end,
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities,
    })
end

return M
