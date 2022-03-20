local M = {}

M.setup_lsp = function(attach, capabilities)
   local lspconfig = require "lspconfig"

   lspconfig.tsserver.setup {
      on_attach = attach,
      capabilities = capabilities,
   }

   -- rust-analyzer
   local opts = {
     tools = {
       autoSetHints = true,
       hover_with_actions = true,
       inlay_hints = {
         show_parameter_hints = false,
         parameter_hints_prefix = "",
         other_hints_prefix = "",
       },
     },

     server = {
       on_attach = attach,
       capabilities = capabilities,
       settings = {
         ["rust-analyzer"] = {
           checkOnSave = {
             command = "clippy"
           }
         }
       }
     }
   }

   require('rust-tools').setup(opts);

   lspconfig.cssls.setup {
      on_attach = attach,
      capabilities = capabilities,
   }

   lspconfig.html.setup {
      on_attach = attach,
      capabilities = capabilities,
   }

   lspconfig.elixirls.setup {
      on_attach = attach,
      capabilities = capabilities,
      cmd = { "/data/data/com.termux/files/home/.config/elixirls/language_server.sh" }
   }
end

return M
