" need this up front
set runtimepath^=~/.config/nvim
let &packpath = &runtimepath
set shell=bash
set encoding=utf-8
filetype plugin on
set mouse=a
set hidden
set timeoutlen=300
set updatetime=300
let g:home = '~/.config/nvim/'


call plug#begin(g:home . 'plugged/')
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdcommenter'
Plug 'lewis6991/gitsigns.nvim'
Plug 'bling/vim-airline'
Plug 'tpope/vim-repeat'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-fugitive.git'
Plug 'airblade/vim-rooter'
Plug 'neovim/nvim-lspconfig'
Plug 'scalameta/nvim-metals'
Plug 'unblevable/quick-scope'
Plug 'stumash/vim-base64'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'folke/which-key.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'
Plug 'p00f/nvim-ts-rainbow'
Plug 'nvim-lua/completion-nvim'
Plug 'rafcamlet/nvim-luapad'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'folke/lsp-colors.nvim'
Plug 'folke/trouble.nvim'
call plug#end()


"""" TROUBLE:
lua require("trouble").setup({})


"""" LEADER:
let mapleader=" "
nmap <C-Space> <Space>
lua leader = "<Space>"
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :qa!<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>W :wa<CR>
nnoremap <leader>z :w<CR>:bd<CR>
nnoremap <leader>Z :wqa<CR>
nnoremap <leader>x :bd<CR>
nnoremap <leader>X :bd!<CR>
"" copy current filename into system clipboard
nnoremap <leader>% mz:put =expand('%:p')<CR>0v$h<C-c>dd`z
nnoremap <leader>* <C-W><C-W>


"""" LUA-HELPERS:
luafile ~/.config/nvim/lua/helpers.lua


"""" TELESCOPE:
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fp <cmd>lua require('telescope.builtin').find_files{ search_dirs = { '$HOME/.config/nvim/plugged'  } }<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fth <cmd>Telescope help_tags<cr>


"""" TELESCOPE-FZF:
lua require('telescope').load_extension('fzf')


""""" DISPLAY-SETTINGS:
set showcmd "show vim commands as they're typed
set number "show line number
set relativenumber "show relative line numbering
set hlsearch " set hlsearch
"" set 256 colors available
set t_Co=256
set termguicolors " moar colors
"" non-printable character display settings when :set list!
set lcs=space:·,tab:→\ ,eol:↴
hi NonText ctermfg=0 guifg=#282828
hi SpecialKey ctermfg=0 guifg=#222222
set list
"" let lines wrap at the indentation of beginning of the line being wrapped
set breakindent
"" colors
let g:gruvbox_contrast_dark = "hard"
colorscheme gruvbox
hi Normal ctermbg=NONE
"" highlight column 120
set colorcolumn=120
" always show signcolumns
set signcolumn=yes
highlight SignColumn guibg=#222222
" Better display for messages
set cmdheight=2


"""" DEVICONS:
lua require'nvim-web-devicons'.setup { default = true }


"""" BUFFERLINE:
lua require"bufferline".setup { options = { diagnostics = "nvim_lsp" } }


"""" INDENT-BLANKLINE:
lua << EOF
vim.cmd [[highlight IndentBlanklineIndent1 guibg=#151515 guifg=#303030 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#1f1f1f guifg=#303030 gui=nocombine]]

require("indent_blankline").setup {
  char = "·",
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
  },
  space_char_blankline = "·",
  space_char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
  },
  show_trailing_blankline_indent = true,
}
EOF



"""" LUAPAD: execute lua in the neovim context easily in a fresh buffer
nnoremap <leader>LL :lua require('luapad').toggle()<CR>
nnoremap <leader>LP :Luapad<CR>:lua require('luapad').toggle()<CR>


"""" TREESITTER: syntactic awareness in vim. highlighting and more
" highlight lua in vim files
let g:vimsyn_embed = 'l'

lua << EOF
require('nvim-treesitter.configs').setup {
  playground = { enable = true },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { 'BufWrite', 'CursorHold' },
  },
  ensure_installed = "maintained",
  highlight = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 10000, -- Do not enable for files with more than n lines, int
  },
}
EOF


""""" COLORIZER: show the color of hex and rgb color values
lua require('colorizer').setup()


"""" LSP-CONFIG: neovim-native Language Server Protocol client configuration
nnoremap <silent> <leader>kD :lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <leader>kd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <leader>kh :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>kH :lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <leader>kt :lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <leader>kr :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>ka :lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>kv :Telescope lsp_references<CR>
nnoremap <silent> <leader>ke :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> ]k :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> [k :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <leader>kq :lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> <leader>kf :lua vim.lsp.buf.formatting()<CR>

lua << EOF
vim.lsp.set_log_level("debug")
local nvim_lsp = require('lspconfig')

local servers = { "rust_analyzer", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF
" use completion on every buffer
autocmd BufEnter * lua require'completion'.on_attach()
" don't automatically fill in autocomplete
set completeopt=noselect,menuone


"""" NVIM-METALS: config for scala language server, metals
" useful for restarting metals
nnoremap <leader>ore :!rm -rf .metals .bloop project/metals.sbt<CR>:MetalsRestartServer<CR>
" silence messages about stuff I think?
set shortmess-=F
lua << EOF
_G.metals_config = require("metals").bare_config
_G.metals_config.settings = { showImplicitArguments = true }
_G.metals_config.init_options.statusBarProvider = "show-message"
EOF
augroup lsp
  autocmd!
  autocmd FileType scala,sbt lua require("metals").initialize_or_attach(_G.metals_config)
augroup END


"""" GITSIGNS: show which lines have tracked and untracked changes. and more.
lua require'gitsigns'.setup { debug_mode = true }
" show the current hunk as popover
nnoremap <leader>gp :Gitsigns preview_hunk<CR>
" go to next hunk of code that git diff thinks changed
nnoremap ]g :Gitsigns next_hunk<CR>
nnoremap [g :Gitsigns prev_hunk<CR>
" change diff base
nnoremap <leader>gC :Gitsigns change_base<Space>
nnoremap <leader>gcm :Gitsigns change_base master<CR>
nnoremap <leader>gch :Gitsigns change_base HEAD<CR>


"""" WHICH-KEY: show keymaps
lua require("which-key").setup { triggers = { "<leader>" } }


""""" ROOTER: set the cwd to the project root automatically
let g:rooter_patterns = ['.git', 'Cargo.toml', 'package.json', 'Makefile']


""""" AIRLINE: fancy status line
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#fugitiveline#enabled = 0
let g:airline#extensions#branch#enabled = 0
"" always show status bar
set laststatus=2
"" unicode symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' '
let g:airline_symbols.colnr = ' '
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='+'
"" airline colorscheme/theme
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1


""""" JSON: automatically format json
nnoremap <leader>json :%!python3 -m json.tool<CR>
vnoremap <leader>json :!python3 -m json.tool<CR>


""""" SNEAK: quicksearch for single or two characters with f,t, and s
"" label-mode
let g:sneak#label = 1
"" replace 'f' with 1-char Sneak
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
" replace 't' with 1-char Sneak
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T


""""" CURSOR:
"" highlight current row
set cursorline


""""" FUGITIVE: git, in general
"" git status
nnoremap <leader>gs :Gstatus<CR>
"" git blame
nnoremap <leader>gb :G blame<CR>


""""" BASE64: base64 encode/decode visual mode mappings
"" base Sixty Four encode
vnoremap <silent> <leader>sf :<c-u>call base64#v_btoa()<cr>
"" base Sixty Four decode
vnoremap <silent> <leader>fs :<c-u>call base64#v_atob()<cr>


"""""""" plugin-related settings begin
"" let vim detect filetype. needed for some plugins
"" latex filetype setting
let g:tex_flavor = "latex"
"""""""" plugin-related settings end

"""""""" search settings begin
"" this mapping causes vim to startup with c pressed
nnoremap <esc> <esc>:noh<cr>:<bs><esc>hl
"" but neovim doesn't have this issue
"""""""" search settings end

"""""""" clipboard settings begin
"" ensure that clipboard = the unnamed register
set clipboard=unnamed
"""""""" clipboard settings end

""""" <C-m> is 'm'y namespace
noremap <C-m>hls :set hlsearch!<CR>
noremap <C-m>rn :set relativenumber!<CR>
noremap <C-m>ln :set number!<CR>
" reload file
nmap <C-m>rr :bufdo e<CR>
" remove trailing whitespace + tabs to spaces
function RemoveTrailingWhitespace_and_TabsToSpaces()
    :exe "silent! :%s/\\s\\+\\n/\\r/"
    :exe "silent! :%s/\\t/    /g"
endfunction
noremap <C-m>w :call RemoveTrailingWhitespace_and_TabsToSpaces()<CR>
"""" <C-m is 'm'y namespace

" tab settings
set shiftwidth=4  "Indents will have a width of 4
set tabstop=4     "The width of a TAB is set to 4, but is still \lt
set softtabstop=4 "Sets the number of columns for a TAB
set expandtab     "Expand TABs to spaces
" filetype-specific tab settings
autocmd FileType html setlocal shiftwidth=2
autocmd FileType javascript setlocal shiftwidth=2
autocmd FileType javascriptreact setlocal shiftwidth=2
autocmd FileType typescript setlocal shiftwidth=2
autocmd FileType typescriptreact setlocal shiftwidth=2
autocmd FileType lua setlocal shiftwidth=2
autocmd FileType scala setlocal shiftwidth=2
autocmd FileType vim setlocal shiftwidth=2
autocmd FileType rust setlocal shiftwidth=4
autocmd FileType nim setlocal shiftwidth=4
" except you can still manually TAB like this:
inoremap <C-Tab> <C-v><Tab>

"" :split opens to the right or below
set splitright
set splitbelow

"" let % jump to closing tag in html on top of usual functionality
runtime macros/matchit.vim

"" code folding settings
set foldmethod=indent
set nofoldenable

"" no ex-mode by accident
nnoremap Q <Nop>

" IDK-IF-I-NEED-THIS-ANYMORE:
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup
" don't give |ins-completion-menu| messages.
set shortmess+=c
