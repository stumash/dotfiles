set runtimepath^=~/.config/nvim
let &packpath = &runtimepath
lua vim.o.shell = "bash"
lua vim.o.encoding = "utf-8"
lua vim.cmd [[filetype plugin on]]
lua vim.filetype.add { extension = { ron = "ron" } }
lua vim.o.mouse = "a" -- mouse can scroll, click, select
lua vim.o.hidden = true -- allow open new buffer even when current is modified
lua vim.o.timeoutlen = 300
lua vim.o.updatetime = 300
lua vim.o.clipboard = "unnamed" -- yank to system clipboard
" nnoremap <esc> <esc>:noh<cr>jk:<esc>
lua vim.keymap.set("n", "<esc>", "<esc><cmd>noh<cr>jk<cmd><esc>")
augroup vimrc_foldmethod
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END
set foldmethod=indent
set nofoldenable
" no ex-mode by accident
lua vim.keymap.set("n", "Q", "<nop>")
let mapleader=" "


lua vim.g.home = "~/.config/nvim/"
lua vim.g.pluggedir = vim.g.home .. "plugged/"
call plug#begin(g:pluggedir)
Plug 'stumash/shellvis'
Plug 'stumash/lcs.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'stevearc/dressing.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'ziontee113/icon-picker.nvim'
Plug 'scrooloose/nerdcommenter'
Plug 'lewis6991/gitsigns.nvim'
Plug 'TimUntersberger/neogit'
Plug 'akinsho/git-conflict.nvim'
Plug 'j-hui/fidget.nvim'
Plug 'tpope/vim-repeat'
Plug 'justinmk/vim-sneak'
Plug 'kylechui/nvim-surround'
Plug 'tommcdo/vim-exchange'
Plug 'simrat39/symbols-outline.nvim'
Plug 'airblade/vim-rooter'
Plug 'neovim/nvim-lspconfig'
Plug 'scalameta/nvim-metals'
Plug 'unblevable/quick-scope'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
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
Plug 'andymass/vim-matchup'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'junegunn/vim-easy-align'
Plug 'NMAC427/guess-indent.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'aarondiel/spread.nvim'
Plug 'mbbill/undotree'
" colors/appearance
Plug 'feline-nvim/feline.nvim'
Plug 'stumash/snowball.nvim'
Plug 'joshdick/onedark.vim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
" " autocompletion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'SirVer/ultisnips'
Plug 'stumash/vim-snippets'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
call plug#end()


"""" toggle-lsp-diagnostics:
lua require'toggle_lsp_diagnostics'.init()
lua vim.keymap.set("n", "<leader>kT", "<cmd>ToggleDiag<cr>")


"""" guess-indent
lua require'guess-indent'.setup { filetype_exclude = { "netrw", "tutor" } }
autocmd FileType java,python,rust,bash,sh,tex,ron setlocal shiftwidth=4
autocmd FileType scala,typescript,javascript,lua,teal setlocal shiftwidth=2


"""" vim-matchup
lua vim.g.loaded_matchit = 1


"""" spread.nvim
lua vim.keymap.set('n', '<leader>so', function() require'spread'.out() end)
lua vim.keymap.set('n', '<leader>si', function() require'spread'.combine() end)


"""" fidget
lua require"fidget".setup{}


"""" nvim-tree
lua << EOF
local function nvim_tree_on_attach(bufnr)
  local api = require('nvim-tree.api')
  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  api.config.mappings.default_on_attach(bufnr) -- OR use all default mappings
  vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
end

require'nvim-tree'.setup {
  git = { ignore = false },
  sort_by = "case_sensitive",
  view = { adaptive_size = true },
  on_attach = nvim_tree_on_attach,
}
local start_size = 30
local incr_size = 10
local size = start_size
function increaseNvimTreeSize()
  size = size + incr_size
  require'nvim-tree'.resize(size)
end
function decreaseNvimTreeSize()
  if size > start_size then
    size = size - incr_size
    require'nvim-tree'.resize(size)
  else
    print([[can't decrease below start_size ]] .. start_size)
  end
end
vim.keymap.set('n', '<leader>nl', increaseNvimTreeSize)
vim.keymap.set('n', '<leader>nh', decreaseNvimTreeSize)
vim.keymap.set('n', '<leader>nN', '<cmd>NvimTreeFindFile<cr>')
vim.keymap.set('n', '<leader>nn', '<cmd>NvimTreeToggle<cr>')
EOF


"""" vim-easy-align
lua << EOF
-- Start interactive EasyAlign in visual mode (e.g. vipga)
vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)')
vim.keymap.set('x', 'gA', '<Plug>(LiveEasyAlign)')
-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
vim.keymap.set('n', '<leader>ga', '<Plug>(EasyAlign)')
vim.keymap.set('n', '<leader>gA', '<Plug>(LiveEasyAlign)')
-- format current table
vim.keymap.set('n', '<leader><bar>', [[mavip:EasyAlign *<bar><cr>'a]])
EOF


"""" shellvis and text transforms
" <leader>e is for 'e'llvis
" base64
vnoremap <leader>esf :<c-u>call shellvis#do("base64")<cr>
vnoremap <leader>efs :<c-u>call shellvis#do("base64 -d")<cr>
" gzip | base64
vnoremap <leader>ezsf :<c-u>call shellvis#do("gzip \| base64")<cr>
vnoremap <leader>ezfs :<c-u>call shellvis#do("base64 -d \| gzip -d")<cr>
" json formatting, defaults to indent = 2 spaces
nnoremap <leader>json :%!jq<CR>
nnoremap <leader>jsoN4 :%!jq --indent 4<CR>
vnoremap <leader>json :<c-u>call shellvis#do("jq")<cr>
vnoremap <leader>jsoN4 :<c-u>call shellvis#do("jq --indent 4")<cr>
" sort
vnoremap <leader>esort :<c-u>call shellvis#do("sort")<cr>
" uniq
vnoremap <leader>euniq :<c-u>call shellvis#do("uniq")<cr>


"""" trouble
lua require"trouble".setup {}
nnoremap <leader>tt <cmd>TroubleToggle<cr>
nnoremap <leader>tw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>td <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>tq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>tl <cmd>TroubleToggle loclist<cr>
nnoremap <leader>tk <cmd>TroubleToggle lsp_references<cr>


"""" stabilize:
lua require"stabilize".setup { nexted = "QuickFixCmdPost *" }


"""" leader:
nmap <C-Space> <Space>
lua leader = "<Space>"
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :qa!<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>W :wa<CR>
nnoremap <leader>x :lua closeWindowOrBufferAsNeeded{}<CR>
nnoremap <leader>X :lua closeWindowOrBufferAsNeeded{force=true}<CR>
" copy current filename into system clipboard
nnoremap <leader>%% <cmd>lua print(vim.fn.expand('%:p'))<cr>
nnoremap <leader>%p mz:put=expand('%:p')<cr>
nnoremap <leader>O <C-W><C-W>


"""" terminal
" double-esc to enter vim edit mode
tnoremap <esc><esc> <c-\><c-n>
nnoremap <leader>T :terminal bash --login<cr>


"""" my lua helpers:
luafile ~/.config/nvim/lua/helpers.lua


"""" telescope:
lua << EOF
require'telescope'.setup {
  defaults = {
    path_display = { 'truncate', shorten = 5 },
    dynamic_preview_title = true,
    preview = { filesize_limit = 10 }, -- 10 MB
    layout_strategy = 'flex',
    layout_config = {
      flex = { flip_columns = 250 }, -- go horizontal if nvim wider than this
      vertical = {
        preview_cutoff = 110, -- if vertical, dont display file preview when height less than this
        preview_height = 110, -- if vertical, dedicate this many row to file preview
    },
    },
  }
}
EOF
nnoremap <leader>fF <cmd>lua require'telescope.builtin'.find_files { hidden = true, no_ignore = true }<cr>
nnoremap <leader>ff <cmd>Telescope git_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fp <cmd>lua require'telescope.builtin'.find_files { cwd = '$HOME/.config/nvim/plugged' }<cr>
nnoremap <leader>fb <cmd>lua require'telescope.builtin'.buffers { last_used = true }<cr>
nnoremap <leader>f/ <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>gB <cmd>Telescope git_branches<cr>
nnoremap <leader>gs <cmd>Telescope git_status<cr>
nnoremap <leader>f: <cmd>Telescope command_history<cr>
nnoremap <leader>fL <cmd>Telescope reloader<cr>


"""" telescope-file-browser:
lua require"telescope".load_extension"file_browser"
nnoremap <leader>fb :Telescope file_browser<cr>


"""" telescope-fzf:
lua require('telescope').load_extension('fzf')


"""" symbols-outline: ast tree structure of code
lua << EOF
require'symbols-outline'.setup {
  autofold_depth = 1,
  keymaps = {
    fold = "h",
    unfold = "l",
    fold_all = "H",
    unfold_all = "L",
  }
}
EOF
lua vim.keymap.set('n', '<leader>aa', '<CMD>SymbolsOutline<CR>')
lua vim.keymap.set('n', '<leader>ax', '<CMD>SymbolsOutlineClose<CR>')
lua vim.keymap.set('n', '<leader>ai', '<CMD>SymbolsOutlineOpen<CR>')


"""" non-printable characters, a.k.a. listchars:
" non-printable character display settings when :set list!
set showcmd " show vim commands as they're typed
set hlsearch " set hlsearch
set termguicolors " colors

""" lcs.nvim: toggle listchars
lua require'lcs'.setup()
nnoremap <leader>LCSL <CMD>lua require'lcs'.toggleShow()<CR>
nnoremap <leader>LCSs <CMD>lua require"lcs".toggleShow('s')<CR>
nnoremap <leader>LCSt <CMD>lua require"lcs".toggleShow('tb')<CR>
nnoremap <leader>LCSe <CMD>lua require"lcs".toggleShow('e')<CR>
nnoremap <leader>LCSr <CMD>lua require"lcs".toggleShow('tr')<CR>


"""" display settings
set breakindent " let lines wrap at the indentation of the line being wrapped
"" colors
colorscheme tokyonight-night
hi Normal ctermbg=NONE
set colorcolumn=120 " highlight column 120
set signcolumn=yes " always show signcolumns
highlight SignColumn guibg=0
set cmdheight=2 " Better display for messages


"""" devicons:
lua require'nvim-web-devicons'.setup { default = true }


"""" bufferline:
lua << EOF
require"bufferline".setup {
  options = {
    diagnostics = "nvim_lsp",
    numbers = "ordinal",
    offsets = {
      { filetype = "NvimTree", highlight = "Directory", separator = true },
    },
    show_buffer_close_icons = false,
  },
}
EOF

" last buffer
nnoremap <silent><leader>bb <C-^>
" go SS
nnoremap <silent><leader>. :BufferLineCycleNext<cr>
nnoremap <silent><leader>, :BufferLineCyclePrev<cr>
" move buffer left or right
nnoremap <silent><leader>> :BufferLineMoveNext<cr>
nnoremap <silent><leader>< :BufferLineMovePrev<cr>
" open buffers by their visible ordinal
nnoremap <silent><leader>1 <cmd>lua require("bufferline").go_to_buffer(1, true)<cr>
nnoremap <silent><leader>2 <cmd>lua require("bufferline").go_to_buffer(2, true)<cr>
nnoremap <silent><leader>3 <cmd>lua require("bufferline").go_to_buffer(3, true)<cr>
nnoremap <silent><leader>4 <cmd>lua require("bufferline").go_to_buffer(4, true)<cr>
nnoremap <silent><leader>5 <cmd>lua require("bufferline").go_to_buffer(5, true)<cr>
nnoremap <silent><leader>6 <cmd>lua require("bufferline").go_to_buffer(6, true)<cr>
nnoremap <silent><leader>7 <cmd>lua require("bufferline").go_to_buffer(7, true)<cr>
nnoremap <silent><leader>8 <cmd>lua require("bufferline").go_to_buffer(8, true)<cr>
nnoremap <silent><leader>9 <cmd>lua require("bufferline").go_to_buffer(9, true)<cr>
" close all buffers to the right or left of current buffer
nnoremap <silent><leader>bl <CMD>BufferLineCloseRight<CR>
nnoremap <silent><leader>bh <CMD>BufferLineCloseLeft<CR>


"""" LUAPAD: execute lua in the neovim context easily in a fresh buffer
nnoremap <leader>LL :lua require('luapad').toggle()<CR>
nnoremap <leader>LP :Luapad<CR>:lua require('luapad').toggle()<CR>


"""" treesitter: syntactic awareness in vim. highlighting and more
lua << EOF
vim.g.vimsyn_embed = "l" -- highlight lua in vim files
require"nvim-treesitter.configs".setup {
  indent = { enable = true }, -- might want this to be `false` for javascript
  playground = { enable = true },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },
  ensure_installed = {
    "c", "rust", "cpp",
    "javascript", "typescript", "tsx",
    "json", "ron", "yaml",
    "lua", "teal", "vim",
    "python",
    "bash",
    "java", "kotlin",
    "latex",
    "dockerfile", "hcl", "terraform",
    "css", "scss", "html",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 10000, -- Do not enable for files with more than n lines, int
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
      include_surrounding_whitespace = true,
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>sn"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>sp"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]c"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]C"] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[c"] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[C"] = "@class.outer",
      },
    },
  },
}
vim.g.markdown_fenced_languages = {'html', 'python', 'lua', 'vim', 'typescript', 'javascript', 'rust'}
EOF


"""" colorizer: show the color of hex and rgb color values
lua require('colorizer').setup()


"""" nvim-cmp: auto-complete, smart completion
lua << EOF
vim.opt_global.shortmess:remove('F')
vim.opt_global.shortmess:append('c')
vim.opt_global.completeopt = { "menuone", "noinsert", "preview" }

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
    ['<cr>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  }
}
EOF


"""" ultisnips: snippets for autocomplete
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
nnoremap <silent> <leader>ke :lua vim.diagnostic.open_float()<CR>
nnoremap <silent> ]k :lua vim.diagnostic.goto_next({severity=1})<CR>
nnoremap <silent> [k :lua vim.diagnostic.goto_prev({severity=1})<CR>
nnoremap <silent> ]i :lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> [i :lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> <leader>kq :lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> <leader>kf :lua vim.lsp.buf.formatting()<CR>

lua << EOF
vim.lsp.set_log_level("debug")
local lspconfig = require('lspconfig')

local servers = { "rust_analyzer", "tsserver", "pyright", "teal_ls" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = require'cmp_nvim_lsp'.default_capabilities(),
    flags = { debounce_text_changes = 150 },
  }
end
EOF


"""" nvim-metals: config for scala language server, metals
lua << EOF
function make_metals_config()
  local config = require'metals'.bare_config()

  config.capabilities = require'cmp_nvim_lsp'.default_capabilities()
  config.settings = {
    showImplicitArguments = true,
    showInferredType = true,
    serverVersion = [[0.11.5]],
    decorationColor = [[Title]],
  }

  return config
end
function make_metals_config_and_restart()
  local config = make_metals_config()
  local metals = require'metals'
  metals.initialize_or_attach(config)
  metals.restart_server()
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "sc", "java" },
  callback = function()
    require'metals'.initialize_or_attach(make_metals_config())
  end,
})
EOF
nnoremap <leader>ore :!rm -rf .metals .bloop project/metals.sbt<CR>:lua make_metals_config_and_restart()<CR>


"""" gitsigns: show which lines have tracked and untracked changes. and more.
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
nnoremap <leader>ghr :Gitsigns reset_hunk<CR>
nnoremap <leader>ghs :Gitsigns stage_hunk<CR>
nnoremap <leader>ghu :Gitsigns undo_stage_hunk<CR>
" go to next hunk of code that git diff thinks changed
nnoremap ]g :Gitsigns next_hunk<CR>
nnoremap [g :Gitsigns prev_hunk<CR>
" change diff base
nnoremap <leader>gC :Gitsigns change_base<Space>
nnoremap <leader>gcm :Gitsigns change_base master<CR>
nnoremap <leader>gch :Gitsigns change_base HEAD<CR>
" set base back to index
nnoremap <leader>gci :Gitsigns change_base<CR>
" show line blame
nnoremap <leader>gb :Gitsigns toggle_current_line_blame<CR>


"""" icon-picker
lua require'icon-picker'.setup{}
nnoremap <leader>i <cmd>PickEmoji<cr>
nnoremap <leader>I <cmd>PickEverything<cr>
inoremap <c-i> <cmd>PickEmojiInsert<cr>
inoremap <c-I> <cmd>PickEverythingInsert<cr>


"""" neogit
lua require'neogit'.setup {}
nnoremap <leader>gg :Neogit<cr>


"""" which-key: show keymaps
lua require("which-key").setup { triggers = { "<leader>" } }


"""" rooter: set the cwd to the project root automatically
let g:rooter_patterns = ['.git', 'Cargo.toml', 'package.json', 'Makefile']


"""" feline: fancy status bar
lua << EOF
local snowball = require'snowball'
snowball.setup { labels = snowball.labels_alternate }
require'feline'.setup {
  custom_providers = { [snowball.provider_name] = snowball.provider },
  components = snowball.reverse_scroll_bar(snowball.add_whitespace_component(
    require'feline.default_components'.statusline.icons
  )),
}
EOF
"" always show status bar
set laststatus=2


"""" harpoon: navigate to popular fle locations faster
lua require("telescope").load_extension('harpoon')
nnoremap <leader>ha :lua require("harpoon.mark").add_file()<cr>
nnoremap <leader>hh :Telescope harpoon marks<cr>
" <c-d> to delete entries


"""" git-conflict: handle merge conflicts slightly better
lua require('git-conflict').setup()
" Select 'ours'
nnoremap <leader>gco <cmd>GitConflictChooseOurs<cr>
" Select 'theirs'
nnoremap <leader>gct <cmd>GitConflictChooseTheirs<cr>
" Select 'both' ours and theirs
nnoremap <leader>gcb <cmd>GitConflictChooseBoth<cr>
" Select 'neither'
nnoremap <leader>gcn <cmd>GitConflictChooseNone<cr>
nnoremap <leader>]c <cmd>GitConflictNextConflict<cr>
nnoremap <leader>[c <cmd>GitConflictPrevConflict<cr>
nnoremap <leader>gcc <cmd>GitConflictListQ<cr>

"""" nvim-surround
lua require'nvim-surround'.setup{}


"""" nerdcommenter: comment and uncomment easily
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1
let g:NERDCreateDefaultMappings = 0
let g:NERDCompactSexyComs = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1
" toggle line(s)
nnoremap <leader>cc <Plug>NERDCommenterToggle
vnoremap <leader>cc <Plug>NERDCommenterToggle
" toggle line(s), but respect individual line commentedness
nnoremap <leader>ci <Plug>NERDCommenterInvert
vnoremap <leader>ci <Plug>NERDCommenterInvert
" start writing a comment at the end of the current line
nnoremap <leader>cA <Plug>NERDCommenterAppend
" 'sexy' comment
nnoremap <leader>cs <Plug>NERDCommenterSexy
vnoremap <leader>cs <Plug>NERDCommenterSexy


"""" undotree: view and access the entire edit history of the buffer
nnoremap <leader>u :UndotreeToggle<CR>
lua vim.g.undotree_WindowLayout = 4


"""" sneak: quicksearch for single or two characters with f,t, and s, respectively
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


"""" cursor:
"" highlight current row
lua vim.go.cursorline = true


"""" toggle nums
lua << EOF
  local all = require('plenary.functional').all
  local isTrue = function(_, x) return x == true end
  local setColNums = function(b) vim.o.number = b; vim.o.relativenumber = b end
  function toggleNums()
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
lua vim.o.tabstop = 4       -- The width of a TAB is set to 4, but is still \t
lua vim.o.softtabstop = 4   -- Sets the number of columns for a TAB
lua vim.o.expandtab = true  -- Expand TABs to spaces

" :split opens to the right or below
lua vim.o.splitright = true
lua vim.o.splitbelow = true

" I think is prevents crashes in some buggy LSPs?
lua vim.go.bk = false
lua vim.go.wb = false

"""" windows
nmap <leader><leader>l <c-w>l
nmap <leader><leader>h <c-w>h
nmap <leader><leader>j <c-w>j
nmap <leader><leader>k <c-w>k
