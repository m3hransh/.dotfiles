local u = require("utils")
local lsp = vim.lsp

local BORDER_OPTS = { border = "single", focusable = false, scope = "line" }

vim.diagnostic.config({ virtual_text = true, float = BORDER_OPTS })

lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, BORDER_OPTS)
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, BORDER_OPTS)

global.lsp = {
    border_opts = BORDER_OPTS,
}

local on_attach = function(client, bufnr)
    -- Commands
    u.lua_command("LspFormatting", "vim.lsp.buf.formatting()")
    u.lua_command("LspHover", "vim.lsp.buf.hover()")
    u.lua_command("LspRename", "vim.lsp.buf.rename()")
    u.lua_command("LspDiagPrev", "vim.diagnostic.goto_prev()")
    u.lua_command("LspDiagNext", "vim.diagnostic.goto_next()")
    u.lua_command("LspDiagLine", "vim.diagnostic.open_float(nil, global.lsp.BORDER_OPTS)")
    u.lua_command("LspDiagQuickfix", "vim.diagnostic.setqflist()")
    u.lua_command("LspSignatureHelp", "vim.lsp.buf.signature_help()")
    u.lua_command("LspTypeDef", "vim.lsp.buf.type_definition()")
    u.lua_command("LspDef", "vim.lsp.buf.definition()")
    u.lua_command("LspDec", "vim.lsp.buf.declaration()")
    u.lua_command("LspImp", "vim.lsp.buf.implementation()")
    u.lua_command("LspRef", "vim.lsp.buf.references()")

    -- Maps
    u.buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>")
    u.buf_map(bufnr, "n", "gk", ":LspHover<CR>")
    u.buf_map(bufnr, "n", "gi", ":LspImp<CR>")
    u.buf_map(bufnr, "n", "gr", ":LspRef<CR>")
    u.buf_map(bufnr, "n", "gd", ":LspDef<CR>")
    u.buf_map(bufnr, "n", "gD", ":LspDec<CR>")

    u.buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
    u.buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
    u.buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>")
    u.buf_map(bufnr, "n", "<Leader>q", ":LspDiagQuickfix<CR>")
    u.buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")

    if client.resolved_capabilities.document_formatting then
        u.buf_map(bufnr, "n", "<Leader>ff", ":LspFormatting<CR>")
        -- too slow
        -- vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()")
    end
    require("illuminate").on_attach(client)
end

-- I don't Understand this at the moment
local capabilities = lsp.protocol.make_client_capabilities()
--capabilities = require("cmp").update_capabilities(capabilities)

for _, server in ipairs({
  "null-ls",
}) do
   require("lsp." .. server).setup(on_attach, capabilities)
end

-- add language server installed by lspinstall
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.settings({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

local lspconfig = require("lspconfig")
local ts_utils = require("nvim-lsp-ts-utils")

local enhance_server_opts = {
  -- Provide settings that should only apply to the tsserver
  ['tsserver'] = function(opts)
    opts.settings = {
        format = {
          enable =false,
        },
      }
    opts.root_dir = lspconfig.util.root_pattern("package.json")
    opts.on_attach = function(client, bufnr)
      -- Global on_attach
      on_attach(client, bufnr)
      -- disable formatting as is provided by null-ls
      client.resolved_capabilities.document_formatting = false
      ts_utils.setup({})
      ts_utils.setup_client(client)

      u.buf_map(bufnr, "n", "<leader>go", ":TSLspOrganize<CR>")
      u.buf_map(bufnr, "n", "<leader>gR", ":TSLspRenameFile<CR>")
      u.buf_map(bufnr, "n", "<leader>gI", ":TSLspImportAll<CR>")
    end
  end,
  -- Provide settings that should only apply to the sumneko_lua
  ['sumneko_lua'] = function(opts)
    opts.settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim','global'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    }
    -- Use the global on_attach
    opts.on_attach = on_attach
  end,
}

-- register a handler that will be called for all installed servers.
lsp_installer.on_server_ready(function(server)
  local opts = {}

  if enhance_server_opts[server.name] then
    -- Enhance the default opts with the server-specific ones
    enhance_server_opts[server.name](opts)
  end

  server:setup(opts)
end)
