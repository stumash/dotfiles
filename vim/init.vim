set runtimepath^=~/.config/nvim
let &packpath = &runtimepath
lua vim.o.shell = "bash"
lua vim.o.encoding = "utf-8"
lua vim.cmd [[filetype plugin on]]
lua vim.o.mouse = "a" -- mouse can scroll, click, select
lua vim.o.hidden = true -- allow open new buffer even when current is modified
lua vim.o.timeoutlen = 300
lua vim.o.updatetime = 300
lua vim.o.clipboard = "unnamed" -- yank to system clipboard
nnoremap <esc> <esc>:noh<cr>jk:<esc>
set foldmethod=indent
set nofoldenable
" no ex-mode by accident
nnoremap Q <Nop>

function! SystemStripped(cmd, input)
    return substitute(system(a:cmd, a:input), '\n$', '', 'g')
endfunction

function! SystemOnVisSelect(cmd)
    " Preserve line breaks
    let l:paste = &paste
    set paste
    " Reselect the visual mode text
    normal! gv
    " Apply transformation to the text
    execute "normal! c\<c-r>=SystemStripped(\"" . a:cmd . "\", @\")\<cr>\<esc>"
    " Select the new text
    normal! `[v`]h
    " Revert to previous mode
    let &paste = l:paste
endfunction

vnoremap <leader>sf :<c-u>call SystemOnVisSelect("base64")<cr>
vnoremap <leader>fs :<c-u>call SystemOnVisSelect("base64 -d")<cr>

vnoremap <leader>zsf :<c-u>call SystemOnVisSelect("gzip \| base64")<cr>
vnoremap <leader>zfs :<c-u>call SystemOnVisSelect("base64 -d \| gzip -d")<cr>

lua vim.g.home = "~/.config/nvim/"
lua vim.g.pluggedir = vim.g.home .. "plugged/"
call plug#begin(g:pluggedir)
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'scrooloose/nerdcommenter'
Plug 'lewis6991/gitsigns.nvim'
Plug 'bling/vim-airline'
Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-repeat'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'tommcdo/vim-exchange'
Plug 'stevearc/aerial.nvim'
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
Plug 'rafcamlet/nvim-luapad'
Plug 'folke/lsp-colors.nvim'
Plug 'folke/trouble.nvim'
Plug 'luukvbaal/stabilize.nvim'
" autocompletion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'SirVer/ultisnips'
Plug 'stumash/vim-snippets'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
call plug#end()


"""" TROUBLE
lua require"trouble".setup {}


"""" STABILIZE:
lua require"stabilize".setup()


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
" copy current filename into system clipboard
nnoremap <leader>% mz:put=expand('%:p')<CR>
nnoremap <leader>8 <C-W><C-W>


"""" LUA-HELPERS:
luafile ~/.config/nvim/lua/helpers.lua


"""" TELESCOPE:
lua << EOF
require('telescope').setup {
  defaults = {
    path_display = { "truncate", shorten = 5 },
    dynamic_preview_title = true,
    preview = { filesize_limit = 10 } -- 10 MB
  }
}
EOF
nnoremap <leader>fF <cmd>lua require'telescope.builtin'.find_files { no_ignore = true }<cr>
nnoremap <leader>ff <cmd>Telescope git_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fp <cmd>lua require'telescope.builtin'.find_files { cwd = '$HOME/.config/nvim/plugged' }<cr>
nnoremap <leader>fb <cmd>lua require'telescope.builtin'.buffers { last_used = true }<cr>
nnoremap <leader>f/ <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>gB <cmd>Telescope git_branches<cr>
nnoremap <leader>gs <cmd>Telescope git_status<cr>
nnoremap <leader>f: <cmd>Telescope command_history<cr>
nnoremap <leader>fL <cmd>Telescope reloader<cr>


"""" TELESCOPE-FZF:
lua require('telescope').load_extension('fzf')


"""" AERIAL: symbol tree explorer
nnoremap <leader>aa :AerialToggle!<cr>
nnoremap <leader>af :AerialTreeSyncFolds<cr>
nnoremap [a :AerialPrev<cr>
noremap ]a :AerialNext<cr>
noremap [[a :AerialPrevUp<cr>
noremap ]]a :AerialNextUp<cr>
lua require'telescope'.load_extension'aerial'
lua vim.g.aerial = { manage_folds = false }
nnoremap <leader>fa :Telescope aerial<cr>


""""" DISPLAY-SETTINGS:
" non-printable character display settings when :set list!
set showcmd " show vim commands as they're typed
set hlsearch " set hlsearch
set termguicolors " colors
set list " show non-printable characters
lua <<EOF
local tab = [[tab:→\ ]]
local eol = [[eol:↴]]
local spc = [[space:·]]
local w_spc = true
function toggleShowSpace()
  w_spc = not w_spc
  if w_spc == true then
    vim.o.lcs = spc ..','.. tab ..','.. eol
  else
    vim.o.lcs = tab ..','.. eol
  end
end
EOF
nnoremap <leader>LC <CMD>lua toggleShowSpace()<CR>

set breakindent " let lines wrap at the indentation of the line being wrapped
"" colors
colorscheme onedark
hi Normal ctermbg=NONE
set colorcolumn=120 " highlight column 120
set signcolumn=yes " always show signcolumns
highlight SignColumn guibg=0
set cmdheight=2 " Better display for messages


"""" DEVICONS:
lua require'nvim-web-devicons'.setup { default = true }


"""" BUFFERLINE:
lua require"bufferline".setup { options = { diagnostics = "nvim_lsp" } }
" choose buffer
nnoremap <silent><leader><leader> :BufferLinePick<cr>
" last buffer
nnoremap <silent><leader>bb <C-^>
" go left or right
nnoremap <silent><leader>. :BufferLineCycleNext<cr>
nnoremap <silent><leader>, :BufferLineCyclePrev<cr>
" move buffer left or right
nnoremap <silent><leader>> :BufferLineMoveNext<cr>
nnoremap <silent><leader>< :BufferLineMovePrev<cr>


"""" LUAPAD: execute lua in the neovim context easily in a fresh buffer
nnoremap <leader>LL :lua require('luapad').toggle()<CR>
nnoremap <leader>LP :Luapad<CR>:lua require('luapad').toggle()<CR>


"""" TREESITTER: syntactic awareness in vim. highlighting and more
lua << EOF
vim.g.vimsyn_embed = "l" -- highlight lua in vim files
require"nvim-treesitter.configs".setup {
  playground = { enable = true },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
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


"""" NVIM-CMP: auto-complete, smart completion
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set lazyredraw
lua << EOF
local cmp = require'cmp'
cmp.setup {
  snippet = { expand = function(args) vim.fn["UltiSnips#Anon"](args.body) end },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    { name = 'buffer' },
  },
  mapping = {
    ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-y>'] = cmp.mapping.scroll_docs(-4),
    ['<C-e>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<tab>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  }
}
EOF


"""" ULTISNIPS: snippets for autocomplete
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories=[ g:pluggedir . "vim-snippets/UltiSnips/"]
nnoremap <leader>U :UltiSnipsEdit<cr>


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

local servers = { "rust_analyzer", "tsserver", "pylsp" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    flags = { debounce_text_changes = 150 },
    on_attach = function(client)
      require'aerial'.on_attach(client)
    end,
  }
end
EOF


"""" NVIM-METALS: config for scala language server, metals
" useful for restarting metals
nnoremap <leader>ore :!rm -rf .metals .bloop project/metals.sbt<CR>:MetalsRestartServer<CR>
" silence messages about stuff I think?
set shortmess-=F
lua << EOF
_G.metals_config = require'metals'.bare_config()
-- _G.metals_config.capabilities = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- _G.metals_config.settings = { showImplicitArguments = true }
-- _G.metals_config.init_options.statusBarProvider = "show-message"
-- _G.metals_config.on_attach = function(client, bufnr) require'aerial'.on_attach(client) end
EOF
augroup lsp
  autocmd!
  autocmd FileType scala,sc,sbt lua require'metals'.initialize_or_attach(_G.metals_config)
augroup END


"""" GITSIGNS: show which lines have tracked and untracked changes. and more.
lua << EOF
require'gitsigns'.setup {
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 200,
  },
}
EOF
highlight GitSignsCurrentLineBlame guifg=#fffd30
" show the current hunk as popover
nnoremap <leader>gp :Gitsigns preview_hunk<CR>
" go to next hunk of code that git diff thinks changed
nnoremap ]g :Gitsigns next_hunk<CR>
nnoremap [g :Gitsigns prev_hunk<CR>
" change diff base
nnoremap <leader>gC :Gitsigns change_base<Space>
nnoremap <leader>gcm :Gitsigns change_base master<CR>
nnoremap <leader>gch :Gitsigns change_base HEAD<CR>
" show line blame
nnoremap <leader>gb :lua require'gitsigns'.toggle_current_line_blame(true)<cr>


"""" WHICH-KEY: show keymaps
lua require("which-key").setup { triggers = { "<leader>" } }


""""" ROOTER: set the cwd to the project root automatically
let g:rooter_patterns = ['.git', 'Cargo.toml', 'package.json', 'Makefile']


""""" AIRLINE: fancy status line
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
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
let g:airline_theme='onedark'
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


""""" BASE64: base64 encode/decode visual mode mappings
"" base Sixty Four encode
vnoremap <silent> <leader>sf :<c-u>call base64#v_btoa()<cr>
"" base Sixty Four decode
vnoremap <silent> <leader>fs :<c-u>call base64#v_atob()<cr>

lua << EOF
  local all = require('plenary.functional').all
  local setColNums = function(b) vim.o.number = b; vim.o.relativenumber = b end
  function toggleNums()
    local isTrue = function(_, x) return x == true end
    setColNums(not all(isTrue, { vim.o.number, vim.o.relativenumber}))
  end
  setColNums(true)
EOF
noremap <leader>NN :lua toggleNums()<cr>

" reload file
nmap <leader>rr :bufdo e<cr>
" remove trailing whitespace + tabs to spaces
function RemoveTrailingWhitespace_and_TabsToSpaces()
  :exe "silent! :%s/\\s\\+\\n/\\r/"
  :exe "silent! :%s/\\t/    /g"
endfunction
noremap <leader>rmw :call RemoveTrailingWhitespace_and_TabsToSpaces()<CR>

"""" TABS:
lua vim.o.shiftround = true -- '<<' & '>>' always shit to multiples of shiftwidth
lua vim.o.shiftwidth = 4    -- Indents will have a width of 4
lua vim.o.tabstop = 4       -- The width of a TAB is set to 4, but is still \t
lua vim.o.softtabstop = 4   -- Sets the number of columns for a TAB
lua vim.o.expandtab = true  -- Expand TABs to spaces
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
autocmd FileType nim setlocal shiftwidth=2


" :split opens to the right or below
lua vim.o.splitright = true
lua vim.o.splitbelow = true

" let % jump to closing tag in html on top of usual functionality
runtime macros/matchit.vim

" I think is prevents crashes in some buggy LSPs?
set nobackup
set nowritebackup
