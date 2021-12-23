local u = require("utils")

local ts_utils_settings = {
    -- debug = true,
    import_all_scan_buffers = 100,
    debug = false,
    disable_commands = false,
    enable_import_on_completion = true,
    import_all_timeout = 5000, -- ms
    -- eslint
    eslint_enable_code_actions = true,
    eslint_enable_disable_comments = true,
    eslint_bin = "eslint_d",
    eslint_config_fallback = nil,
    eslint_enable_diagnostics = true,
    -- formatting
    enable_formatting = true,
    formatter = "prettier",
    formatter_config_fallback = nil,
    -- parentheses completion
    complete_parens = true,
    signature_help_in_parens = false,

    -- update imports on file move
    update_imports_on_move = true,
    require_confirmation_on_move = false,
    watch_dir = nil,
    -- filter out dumb module warning
    filter_out_diagnostics_by_code = { 80001 },
}

local M = {}
M.setup = function(on_attach, capabilities)
    local lspconfig = require("lspconfig")
    local ts_utils = require("nvim-lsp-ts-utils")

    lspconfig["tsserver"].setup({
        root_dir = lspconfig.util.root_pattern("package.json"),
        init_options = ts_utils.init_options,
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            -- disable tsserver formatting
            client.resolved_capabilities.document_formatting = false


            ts_utils.setup(ts_utils_settings)
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
