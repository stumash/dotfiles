set runtimepath^=~/.config/nvim.nvim,
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
lua vim.o.textwidth = 0
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
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'jssee/vim-delight' " stop highlighting searches when the cursor moves
Plug 'stevearc/dressing.nvim'
Plug 'ziontee113/icon-picker.nvim'
Plug 'scrooloose/nerdcommenter'
Plug 'lewis6991/gitsigns.nvim'
Plug 'TimUntersberger/neogit'
Plug 'akinsho/git-conflict.nvim'
Plug 'j-hui/fidget.nvim', { 'tag': 'legacy' }
Plug 'tpope/vim-repeat'
Plug 'ggandor/leap.nvim'
Plug 'kylechui/nvim-surround'
Plug 'tommcdo/vim-exchange'
Plug 'simrat39/symbols-outline.nvim'
Plug 'airblade/vim-rooter'
Plug 'neovim/nvim-lspconfig'
Plug 'scalameta/nvim-metals'
Plug 'unblevable/quick-scope'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
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
Plug 'Wansmer/treesj'
Plug 'mbbill/undotree'
Plug 'johmsalas/text-case.nvim'
Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'
" colors/appearance
Plug 'feline-nvim/feline.nvim'
Plug 'stumash/snowball.nvim'
Plug 'joshdick/onedark.vim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
" autocompletion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'SirVer/ultisnips'
Plug 'stumash/vim-snippets'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
call plug#end()


"""" which-key: show keymaps
lua << EOF
WK = require"which-key"
WK.setup { triggers = { "<leader>" } }
EOF


"""" guess-indent
lua require'guess-indent'.setup { filetype_exclude = { "netrw", "tutor" } }
autocmd FileType java,python,rust,bash,sh,tex,ron setlocal shiftwidth=4
autocmd FileType scala,typescript,javascript,lua,teal setlocal shiftwidth=2


"""" vim-matchup
lua vim.g.loaded_matchit = 1


"""" leap.nvim: get around fast
lua require'leap'.add_default_mappings()
lua require'leap'.opts.highlight_unlabeled_phase_one_targets = true


"""" fidget
lua require"fidget".setup{}


"""" dressing.nvim
lua require'dressing'.setup { input = { insert_only = false } }


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
  view = {
    adaptive_size = true,
    side = "right",
  },
  on_attach = nvim_tree_on_attach,
}
WK.register {
  ["<leader>n"] = {
    name = "nvim-tree",
    N = { '<cmd>NvimTreeFindFile<cr>',           "find current file" },
    n = { '<cmd>NvimTreeToggle<cr>',             "toggle" },
    c = { '<cmd>NvimTreeCollapseKeepBuffer<cr>', "collapse all folders" },
    C = { '<cmd>NvimTreeCollapse<cr>',           "collapse folders w/o open buffers" },
  },
}
EOF


"""" vim-easy-align
lua << EOF
for _, mode in ipairs{"n", "x"} do
  WK.register {
    ["<leader>e"] = {
      name  = "easy-align",
      e     = { "<Plug>(LiveEasyAlign)",        "live easy-align" },
      E     = { "<Plug>(EasyAlign)",            "easy-align" },
      ["|"] = { "mavip:EasyAlign *<bar><cr>'a", "table easy-align" },
      mode  = mode,
    },
  }
end
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
nnoremap <leader>q :qa<CR>
nnoremap <leader>Q :qa!<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>W :wa<CR>
nnoremap <leader>x :bd<cr>
nnoremap <leader>X :bd!<cr>
nnoremap <leader>z :close<cr>
" copy current filename into system clipboard
nnoremap <leader>%% <cmd>lua print(vim.fn.expand('%:p'))<cr>
nnoremap <leader>%p mz:put=expand('%:p')<cr>


"""" terminal
" double-esc to enter vim edit mode
tnoremap <esc><esc> <c-\><c-n>
lua WK.register { ["<leader>T"] = {"<cmd>terminal bash<cr>", "open terminal"} }


"""" my lua helpers:
luafile ~/.config/nvim/lua/helpers.lua


"""" telescope:
lua << EOF
local telescope = require'telescope'
telescope.setup {
  defaults = {
    path_display = { 'truncate', shorten = 5 },
    dynamic_preview_title = true,
    preview = { filesize_limit = 10 }, -- 10 MB
    layout_strategy = 'flex',
    layout_config = {
      flex = { flip_columns = 250 }, -- go horizontal if nvim wider than this
      vertical = {
        preview_cutoff = 110, -- if vertical, dont display file preview when height less than this
        preview_height = 90, -- if vertical, dedicate this many row to file preview
    },
    },
  }
}
local builtins = require'telescope.builtin'
local find_files = builtins.find_files
local buffers = builtins.buffers
WK.register {
  ["<leader>f"] = {
    mode = "n",
    name = "telescope",
    -- general telescope commands
    F = {function() find_files { hidden = true, no_ignore = true  } end, "search all file names"},
    f = {"<cmd>Telescope git_files<cr>", "search git file names"},
    a = {"<cmd>Telescope live_grep<cr>", "search all files"},
    p = {function() find_files { cwd = '$HOME/.config/nvim/plugged' } end, "search nvim plugin file names"},
    b = {function() buffers { last_used = true } end, "search open buffer file names"},
    ["/"] = {"<cmd>Telescope current_buffer_fuzzy_find<cr>", "search current buffer"},
    [":"] = {"<cmd>Telescope command_history<cr>", "search command history"},
    -- git telescope commands
    g = {
      mode = "n",
      name = "git telescope commands",
      B = {"<cmd>Telescope git_branches<cr>", "search git branches"},
      s = {"<cmd>Telescope git_status<cr>", "search git status"},
    },
  }
}
EOF
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
  },
  symbols = {
    Class = { icon = 'C', hl = '@type' },
  },
}
WK.register {
  ["<leader>a"] = {
    mode = "n",
    name = "symbols tree",
    a = {"<CMD>SymbolsOutline<CR>", "toggle symbols tree"},
  }
}
EOF


"""" non-printable characters, a.k.a. listchars:
" non-printable character display settings when :set list!
set showcmd " show vim commands as they're typed
set hlsearch " set hlsearch
set termguicolors " colors

""" lcs.nvim: toggle listchars
lua << EOF
local lcs = require'lcs'
lcs.setup()
WK.register {
  ["<leader>LCS"] = {
    mode = "n",
    name = "toggle show listchars",
    L = {function() lcs.toggleShow() end, "on/off"},
    s = {function() lcs.toggleShow('s') end, "toggle space"},
    t = {function() lcs.toggleShow('tb') end, "toggle tab"},
    e = {function() lcs.toggleShow('e') end, "toggle eol"},
    r = {function() lcs.toggleShow('tr') end, "toggle trailing space"},
  }
}
EOF


"""" display settings
set nowrap
set breakindent " let lines wrap at the indentation of the line being wrapped
"" colors
set colorcolumn=140 " highlight column 120
set signcolumn=yes " always show signcolumns
highlight SignColumn guibg=0
set cmdheight=2 " Better display for messages
lua << EOF
require'tokyonight'.setup {
  transparent = true,
  styles = {
    sidebars = "dark",
    floats = "dark",
  },
}
vim.cmd[[colorscheme tokyonight-night]]
EOF


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
  matchup = { enable = false },
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
        ["am"] = "@function.outer",
        ["im"] = "@function.inner",
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


"""" toggle-lsp-diagnostics:
lua require'toggle_lsp_diagnostics'.init()
lua vim.keymap.set("n", "<leader>kT", "<cmd>ToggleDiag<cr>")


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


"""" treesj: change code from single line to multiline (and vice versa) syntax style where applicable
lua << EOF
local tsj = require'treesj'
tsj.setup {
  use_default_keymaps = false,
  max_join_length = 140,
  last_separator = true,
}
WK.register {
  ["<leader>s"] = {
    name = "multiline or single-line argument formatter",
    i = { tsj.join, "join ('in')" },
    o = { tsj.split, "join ('in')" },
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
lua << EOF
WK.register {
  ["<leader>k"] = {
    mode = "n",
    name = "LSP actions",
    D = { function() vim.lsp.buf.declaration() end,        "go to declaration" },
    d = { function() vim.lsp.buf.definition() end,         "go to defintion" },
    h = { function() vim.lsp.buf.hover() end,              "hover info" },
    H = { function() vim.lsp.buf.signature_help() end,     "show signature" },
    t = { function() vim.lsp.buf.type_definition() end,    "show type def" },
    r = { function() vim.lsp.buf.rename() end,             "rename" },
    a = { function() vim.lsp.buf.code_action() end,        "show all actions" },
    v = { "<cmd>Telescope lsp_references<cr>",             "list references" },
    e = { function() vim.diagnostic.open_float() end,      "open in floating window" },
    q = { function() vim.lsp.diagnostic.set_loclist() end, "loclist for errors" },
    f = { function() vim.lsp.buf.format() end,             "format buffer" },
  },
  ["]"] = {
    mode = "n",
    name = "go to next",
    k = { function() vim.diagnostic.goto_next({severity=1}) end, "go to next error" },
    i = { function() vim.diagnostic.goto_next() end,             "go to next warning" },
  },
  ["["] = {
    mode = "n",
    name = "go to prev",
    k = { function() vim.diagnostic.goto_prev({severity=1}) end, "go to prev error" },
    i = { function() vim.diagnostic.goto_prev() end,             "go to prev warning" },
  },
}

vim.lsp.set_log_level("debug")
local lspconfig = require('lspconfig')

local servers = { "rust_analyzer", "tsserver", "pyright", "teal_ls", "kotlin_language_server" }
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
lua require'harpoon'.setup { menu = { width = math.floor(vim.api.nvim_win_get_width(0) * 0.8) } }
lua require("telescope").load_extension('harpoon')
nnoremap <leader>ha :lua require("harpoon.mark").add_file()<cr>
nnoremap <leader>hh :Telescope harpoon marks<cr>
nnoremap <leader>hH :lua require"harpoon.ui".toggle_quick_menu()<cr>
" <c-d> to delete entries


"""" icon-picker
lua << EOF
require'icon-picker'.setup{}
WK.register {
  ["<leader>i"] = {
    mode = "n",
    name = "icon-picker",
    i = {"<cmd>PickEmoji<cr>", "pick emoji"},
    I = {"<cmd>PickEverything<cr>", "pick any icon"},
  }
}
EOF
inoremap <c-i> <cmd>PickEmojiInsert<cr>


"""" git START
"""" gitsigns: show which lines have tracked and untracked changes. and more.
lua << EOF
require'gitsigns'.setup {
  keymaps = {},
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 200,
  },
}
EOF
highlight GitSignsCurrentLineBlame guifg=#fffd30
" show the current hunuhjrnettkecifhucldrlekrnjtcibgnvuknlhgf
" go to next hunk of code that git diff thinks changed
nnoremap ]g :Gitsigns next_hunk<CR>
nnoremap [g :Gitsigns prev_hunk<CR>


"""" neogit
lua require'neogit'.setup {}


"""" git-conflict: handle merge conflicts slightly better
lua require('git-conflict').setup()


lua << EOF
WK.register {
  ["<leader>g"] = {
    name = "git",
    h = {
      name = "gitsigns hunk actions",
      p = {"<cmd>Gitsigns preview_hunk<cr>",    "preview hunk"},
      r = {"<cmd>Gitsigns reset_hunk<cr>",      "reset hunk"},
      s = {"<cmd>Gitsigns stage_hunk<cr>",      "stage hunk"},
      u = {"<cmd>Gitsigns undo_stage_hunk<cr>", "unstage hunk"},
      c = {
        name = "change gitsigns diff base",
        c = {"<cmd>Gitsigns change_base<space>",     "diff against custom refname"},
        m = {"<cmd>Gitsigns change_base master<cr>", "diff against master"},
        h = {"<cmd>Gitsigns change_base HEAD<cr>",   "diff unstaged"},
      },
    },
    b = {"<cmd>Gitsigns toggle_current_line_blame<cr>", "toggle line blame"},
    g = {"<cmd>Neogit<cr>", "neogit"},
    c = {
      name = "conflict",
      o = {"<cmd>GitConflictChooseOurs<cr>",   "choose ours"},
      t = {"<cmd>GitConflictChooseTheirs<cr>", "choose theirs"},
      b = {"<cmd>GitConflictChooseBoth<cr>",   "choose both"},
      n = {"<cmd>GitConflictChooseNone<cr>",   "choose neither"},
      c = {"<cmd>GitConflictListQ<cr>",        "list conflicts"},
      ["]"] = {"<cmd>GitConflictNextConflict<cr>", "next conflict"},
      ["["] = {"<cmd>GitConflictPrevConflict<cr>", "prev conflict"},
    },
  },
}
EOF
"""" git END


"""" nvim-surround
lua require'nvim-surround'.setup{}


"""" text-case and nerdcommenter
lua << EOF
-- nergcommenter
vim.g.NERDDefaultAlign = 'left'
vim.g.NERDSpaceDelims = 1
vim.g.NERDCreateDefaultMappings = 0
vim.g.NERDCompactSexyComs = 1
vim.g.NERDTrimTrailingWhitespace = 1
vim.g.NERDToggleCheckAllLines = 1
-- text-case
local tc = require'textcase'
tc.setup {}
-- shorcuts
local function make_onkeypress_function(textcase_fn_name)
  return function()
    local mode = vim.fn.mode()
    if mode == "n" then
      tc.current_word(textcase_fn_name)
    elseif mode == "v" then
      tc.operator(textcase_fn_name)
    end
  end
end

for _, mode in ipairs { "n", "v" } do
  WK.register {
    ["<leader>c"] = {
      mode = mode,
      name = "NerdComment & Text-Case",
      -- nerd commenter
      ["/"] = { "<Plug>NERDCommenterToggle", "toggle comment" },
      ["?"] = { "<Plug>NERDCommenterInvert", "invert comment" },
      -- text-case
      c = {
        mode = mode,
        name = "text-case",
        u = { make_onkeypress_function('to_upper_case'), "upper case" },
        l = { make_onkeypress_function('to_lower_case'), "lower case" },
        ["_"] = { make_onkeypress_function('to_snake_case'), "snake case" },
        ["-"] = { make_onkeypress_function('to_dash_case'), "dash case" },
        ["."] = { make_onkeypress_function('to_dot_case'), "dot case" },
        c = { make_onkeypress_function('to_camel_case'), "camel case" },
        p = { make_onkeypress_function('to_pascal_case'), "pascal case" },
        ["/"] = { make_onkeypress_function('to_path_case'), "path case" },
      }
    }
  }
end
EOF


"""" undotree: view and access the entire edit history of the buffer
lua << EOF
WK.register {
  ["<leader>u"] = { "<cmd>UndotreeToggle<cr>", "undotree toggle"}
}
if bool(vim.fn.has("persistent_undo")) then
  local target_path = os.getenv("HOME") .. "/.nvim/undodir/"
  if not bool(vim.fn.isdirectory(target_path)) then
    vim.fn.mkdir(target_path, "p")
  end
  vim.opt.swapfile = false
  vim.opt.backup = false
  vim.opt.undodir = target_path
  vim.opt.undofile = true
else
  print("no persistent_undo")
end
vim.g.undotree_WindowLayout = 4
EOF


"""" nvim-ufo: better folding
lua << EOF
vim.o.foldcolumn = '0'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.keymap.set('n', 'zR', require'ufo'.openAllFolds, { desc = "open all folds" })
vim.keymap.set('n', 'zM', require'ufo'.closeAllFolds, { desc = "open all folds" })
require'ufo'.setup {
  provider_selector = function(bufnr, filetype, buftype) return {'treesitter', 'indent'} end,
}
EOF


"""" cursor:
"" highlight current row
lua vim.go.cursorline = true


"""" toggle nums
lua << EOF
local all = require('plenary.functional').all
local function isTrue(_, x) return x == true end
local function setColNums(b) vim.o.number = b; vim.o.relativenumber = b end
function toggleNums() setColNums(not all(isTrue, { vim.o.number, vim.o.relativenumber})) end

setColNums(true)

WK.register {
  ["<leader>NN"] = { "<cmd>lua toggleNums()<cr>", "toggle line numbers" },
}
EOF

" reload file
nmap <leader>rr :bufdo e<cr>
nmap <leader>rc <cmd>source ~/.config/nvim/init.vim<cr>
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
lua << EOF
WK.register {
  ["<leader><leader>"] = {
    mode = "n",
    name = "switching windows",
    l = { "<c-w>l", "right" },
    h = { "<c-w>h", "left" },
    j = { "<c-w>j", "down" },
    k = { "<c-w>k", "up" },
    o = { "<c-w><c-w>", "other" },
  },
}
EOF
