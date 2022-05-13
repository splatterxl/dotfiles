" Neovim config
" -------

" install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

" install missing deps
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	\| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()

" bufferline
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'

" statusline
Plug 'nvim-lualine/lualine.nvim'

" colors
Plug 'ghifarit53/tokyonight-vim'

" ctrl-n file tree
Plug 'kyazdani42/nvim-tree.lua'

" completion
" main completion
Plug 'ms-jpq/coq_nvim'
" snippets
Plug 'ms-jpq/coq.artifacts'
" other stuff 
Plug 'ms-jpq/coq.thirdparty'

" misc
Plug 'github/copilot.vim'
Plug 'sbdchd/neoformat'
Plug 'numToStr/Comment.nvim'

" lsp
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'

call plug#end()

" -------
" misc
" -------

set tabstop=2
set number
syntax enable
let mapleader = ','	
let &verbose = 1

lua << EOF
require("bufferline").setup{}
EOF

" -------
" plugins
" -------

" tokyonight
set termguicolors

let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 0

colorscheme tokyonight

" nvim-tree
nnoremap <silent><C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>

lua << EOF
require'nvim-tree'.setup {
				auto_reload_on_write = true
}
EOF

" coq
let g:coq_settings = { 'auto_start': 'shut-up' }

lua << EOF
require("coq_3p") {
				{ src = "copilot", short_name = "COP", accept_key = "<c-f>" },
				{ src = "bc", short_name = "MATH", precision = 6 },
				{ src = "nvimlua", short_name = "vLUA" },
}
EOF

" lspconfig
lua << EOF
require'nvim-lsp-installer'.setup {
				ensure_installed = { "tsserver" },
				automatic_installation = true,
}
EOF

" Comment.nvim
lua require('Comment').setup()

" lualine
lua << EOF
require'lualine'.setup {
				options = {
								theme = 'ayu_mirage',
				},
}
EOF
