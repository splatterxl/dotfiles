vim.env.MYVIMRC = vim.env.HOME .. '/.config/nvim/config.vim'

vim.cmd [[
  source $MYVIMRC
]]

local on_attach = function(client, bufnr)
				-- <c-x><c-o>
				vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

				local opts = { noremap = true, silent = true }
				
				-- Mappings
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD',
								'<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',
								'<cmd>lua vim.lsp.buf.definition()<cr>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',
								'<cmd>lua vim.lsp.buf.hover()<cr>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi',
								'<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-K>',
								'<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn',
								'<cmd>lua vim.lsp.buf.rename()<cr>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca',
								'<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
end

local servers = {
				'rust_analyzer',
				'tsserver',
				'sumneko_lua',
				'vimls',
}
for _,server in pairs(servers) do
				require('lspconfig')[server].setup {
							on_attach = on_attach,
				}
end
