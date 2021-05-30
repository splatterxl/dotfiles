scriptencoding utf-8
" ███╗░░██╗███████╗░█████╗░██╗░░░██╗██╗███╗░░░███╗
" ████╗░██║██╔════╝██╔══██╗██║░░░██║██║████╗░████║
" ██╔██╗██║█████╗░░██║░░██║╚██╗░██╔╝██║██╔████╔██║
" ██║╚████║██╔══╝░░██║░░██║░╚████╔╝░██║██║╚██╔╝██║
" ██║░╚███║███████╗╚█████╔╝░░╚██╔╝░░██║██║░╚═╝░██║
" ╚═╝░░╚══╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝

set nocompatible 					" be iMproved, required

" Plugins
call plug#begin('~/.cache/nvim/plugged') 	"required
Plug 'wakatime/vim-wakatime'
" tools
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree'
Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'andweeb/presence.nvim'
" Plug 'itchyny/lightline.vim'
Plug 'dag/vim-fish'
Plug 'tjdevries/coc-zsh'
Plug 'udalov/kotlin-vim'
Plug 'dense-analysis/ale'
" Plug 'maximbaz/lightline-ale'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'cespare/vim-toml'
Plug 'machakann/vim-highlightedyank'
Plug 'machakann/vim-sandwich'
Plug 'beloglazov/vim-online-thesaurus'
Plug 'mattboehm/vim-accordion'
Plug 'ap/vim-css-color'
" colorschemes
Plug 'morhetz/gruvbox'
Plug 'sainnhe/sonokai'
Plug 'NLKNguyen/papercolor-theme'
Plug 'AtifChy/onedark.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'arcticicestudio/nord-vim'
" Lang-Specific
Plug 'yuezk/vim-js'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'preservim/nerdcommenter'
" also you might wanna try
" Plug 'akinsho/nvim-bufferline.lua'

call plug#end()						" required
" lua require'bufferline'.setup{}                       " we need to wait
" until nvim 0.5.0 /shrug

" General Settings
set t_Co=256						" color support
set splitbelow splitright				" fix vim window split
set mouse=a						" enable mouse
set number						" always show line number
"set number relativenumber 				" show number relativenumber
set showmatch						" set show matching parenthesis
set ignorecase						" ignore case when searching
set smartcase						" ignore case if search pattern is all lowercase, case-sensitive otherwise
set cursorline						" highlight cursor line
" set cursorcolumn 					" highlight cursor column
set clipboard+=unnamedplus				" copy paste between vim and everything else
set inccommand=nosplit					" required for hlsearch
set noshowmode
"set updatetime=100

"autocmd InsertEnter * norm zz 				" vertically center document in insert mode
augroup Buf
	au!
	" autocmd BufWritePre * %s/\s\+$//e			" remove trailing whitespace on save
	autocmd BufWritePost ~/.config/X11/Xresources,~/.config/X11/Xdefaults !xrdb -merge % " run xrdb on ~/.Xresources & ~/.Xdefaults when I edit them
augroup END
if (has('autocmd') && !has('gui_running'))
  augroup colorset
    autocmd!
    let s:white = { 'gui': '#ABB2BF', 'cterm': '145', 'cterm16' : '7' }
" `bg` will not be styled since there is no `bg` setting
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white })
  augroup END
endif

hi Comment cterm=italic
let g:onedark_hide_endofbuffer = 1
let g:onedark_terminal_italics = 0
let g:onedark_termcolors = 256

syntax enable
filetype plugin indent on 				" vim-fish

colorscheme onedark

" oceanic-next colorscheme
"colorscheme OceanicNext
"let g:oceanic_next_terminal_bold = 1
"let g:oceanic_next_terminal_italic = 1

" checks if your terminal has 24-bit color support
if (has('termguicolors'))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

" gruvbox settings
"colorscheme gruvbox
"let g:gruvbox_italic = 1
"let g:gruvbox_contrast_dark = 'hard'
"let g:gruvbox_invert_selection = 0			" selected texts are highlighted in white
"set background=dark					" set background color
"hi Normal ctermbg=NONE guibg=NONE			" transparent background

" sonokai settings
"colorscheme sonokai
"set termguicolors
"let g:sonokai_style = 'atlantis'
"let g:sonokai_style = 'andromeda'
"let g:sonokai_enable_italic = 1

" NERDTree Config
"let g:NERDTreeDirArrowExpandable = '►'
"let g:NERDTreeDirArrowCollapsible = '▼'
"let NERDTreeShowLineNumbers = 1
"let NERDTreeShowHidden = 1
"let NERDTreeMinimalUI = 1

" Air-line configuration
let g:airline_powerline_fonts = 1
let g:airline_highlighting_cache = 1
let g:airline_extensions = ['branch', 'tabline', 'coc', 'ale']
let g:airline#extensions#ale#error_symbol = ' '
let g:airline#extensions#ale#warning_symbol = ' '
let g:airline#extensions#ale#checking_symbol = ' '
" Key Bindings
map <M-s> :setlocal spell! spelllang=en_US<CR>
"map <C-e> :NERDTree<CR>
"map <C-r> :source /home/atif/.config/nvim/init.vim<CR>
"map <C-e> :Lex<bar>vertical resize 30<CR>
map <C-t> :term<CR>

"" Cursor fix
"augroup RestoreCursorShapeOnExit
"    autocmd!
"    autocmd VimLeave * set guicursor=a:hor20
"augroup END

" nvim config
if has('nvim')
    autocmd TermOpen term://* startinsert
endif

" source plugin config
"source /home/atif/.config/nvim/coc.vim
source $HOME/.config/nvim/lightline.vim

" startify config
let g:startify_custom_header = [
	\'   ███╗░░██╗███████╗░█████╗░██╗░░░██╗██╗███╗░░░███╗ ',
	\'   ████╗░██║██╔════╝██╔══██╗██║░░░██║██║████╗░████║ ',
	\'   ██╔██╗██║█████╗░░██║░░██║╚██╗░██╔╝██║██╔████╔██║ ',
	\'   ██║╚████║██╔══╝░░██║░░██║░╚████╔╝░██║██║╚██╔╝██║ ',
	\'   ██║░╚███║███████╗╚█████╔╝░░╚██╔╝░░██║██║░╚═╝░██║ ',
	\'   ╚═╝░░╚══╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝ ',
	\]
let g:startify_lists = [
	\ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
	\ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
	\ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]
let g:startify_bookmarks = [
	\ { 'a': '~/.config/nvim/init.vim' } ,
	\ { 'b': '~/wrappercord/src/index.js' },
	\ { 'c': '~/lightbulb/src/index.ts' },
	\ ]
" autocmd BufWritePre *.js term prettier --write $FILE
" autocmd BufWritePre *.ts term 'prettier --write ' . expand('%:p') 
" term 'echo ' . expand('%:p')
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
nnoremap <silent><nowait> <C-n> :<C-u>NERDTreeToggle<CR>
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
let mapleader = ","
filetype plugin on
nnoremap <silent><nowait> <C-c> ,c 
