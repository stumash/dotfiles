set runtimepath^=~/.config/nvim.nvim,
let &packpath = &runtimepath
lua vim.o.shell = "bash"
lua vim.o.encoding = "utf-8"
lua vim.cmd [[filetype plugin on]]
lua vim.filetype.add { extension = { ron = "ron" } }
lua vim.o.mouse = "a" -- mouse can scroll, click, select
lua vim.o.scrolloff = 3 -- always at least 3 lines above and below cursor a top and bottom of screen
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
augroup savescroll
  autocmd!
  autocmd BufLeave * let b:winview = winsaveview()
  autocmd BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
augroup END


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
Plug 'airblade/vim-rooter'
Plug 'neovim/nvim-lspconfig'
Plug 'unblevable/quick-scope'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'akinsho/bufferline.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'folke/which-key.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'
Plug 'rafcamlet/nvim-luapad'
Plug 'folke/lsp-colors.nvim'
Plug 'folke/trouble.nvim'
Plug 'andymass/vim-matchup'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
Plug 'junegunn/vim-easy-align'
Plug 'NMAC427/guess-indent.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'Wansmer/treesj'
Plug 'mbbill/undotree'
Plug 'johmsalas/text-case.nvim'
Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'
Plug 'stevearc/aerial.nvim'
Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'}
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'github/copilot.vim'
Plug 'LunarVim/bigfile.nvim'
" colors/appearance
Plug 'feline-nvim/feline.nvim'
Plug 'stumash/snowball.nvim'
Plug 'joshdick/onedark.vim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
" autocompletion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
call plug#end()


"""" which-key: show keymaps
lua << EOF
WK = require"which-key"
WK.setup {
  triggers = {
    { "<leader>", mode = { "n", "v" } },
  }
}
EOF


"""" guess-indent
autocmd FileType java,python,rust,bash,sh,tex,ron setlocal tabstop=4
autocmd FileType scala,typescript,javascript,javascriptreact,typescriptreact,lua,teal setlocal tabstop=2
set shiftwidth=0  " in insert mode, the tab key and backspace key should move the cursor by `tabstop` columns
lua require'guess-indent'.setup { filetype_exclude = { "netrw", "tutor" } }


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
WK.add {
  mode = { "n" },
  { "<leader>n", group = "nvim-tree" },
  { "<leader>nN", '<cmd>NvimTreeFindFile<cr>',           desc = "find current file" },
  { "<leader>nn", '<cmd>NvimTreeToggle<cr>',             desc = "toggle" },
  { "<leader>nc", '<cmd>NvimTreeCollapseKeepBuffer<cr>', desc = "collapse all folders" },
  { "<leader>nC", '<cmd>NvimTreeCollapse<cr>',           desc = "collapse folders w/o open buffers" },
}
EOF


"""" vim-easy-align
lua << EOF
for _, mode in ipairs{"n", "x"} do
  WK.add {
    { "<leader>e", group = "easy-align" },
    { "<leader>ee", "<Plug>(LiveEasyAlign)",        mode = mode, desc = "live easy-align" },
    { "<leader>eE", "<Plug>(EasyAlign)",            mode = mode, desc = "easy-align" },
    { "<leader>e|", "mavip:EasyAlign *<bar><cr>'a", mode = mode, desc = "table easy-align" },
  }
end
EOF


"""" shellvis and text transforms
" <leader>E is for 'E'llvis
" base64
lua << EOF
local sv = require'shellvis'
WK.add {
  mode = { "v" },
  { "<leader>E", group = "shellvis" },
  { "<leader>Esf", function() sv.replaceWith'base64' end,        desc = "base64 encode" },
  { "<leader>Efs", function() sv.replaceWith'base64 -d' end,     desc = "base64 decode" },
  { "<leader>Ejq", function() sv.replaceWith'jq --indent 2' end, desc = "json format" },
}
EOF


"""" trouble
lua << EOF
local diagnostics_enabled = true
function toggle_all_diagnostics(only_current_file)
  diagnostics_enabled = not diagnostics_enabled
  if diagnostics_enabled then
    if only_current_file then
      pcall(vim.diagnostic.enable, 0)
    else
      pcall(vim.diagnostic.enable)
    end
  else
    if only_current_file then
      pcall(vim.diagnostic.disable, 0)
    else
      pcall(vim.diagnostic.disable)
    end
  end
end

require"trouble".setup {}
WK.add {
  mode = { "n" },
  { "<leader>t", group = "trouble" },
  { "<leader>tt", "<cmd>TroubleToggle<cr>",                       desc = "toggle" },
  { "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "toggle trouble all diags" },
  { "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "toggle trouble file diags" },
  { "<leader>tq", "<cmd>TroubleToggle quickfix<cr>",              desc = "toggle trouble quickfix" },
  { "<leader>tl", "<cmd>TroubleToggle loclist<cr>",               desc = "toggle trouble loclist" },
  { "<leader>tk", "<cmd>TroubleToggle lsp_references<cr>",        desc = "toggle trouble lsp refs" },
  { "<leader>ta", function() toggle_all_diagnostics(true) end,    desc = "toggle file diagnostics" },
  { "<leader>tA", toggle_all_diagnostics,                         desc = "toggle all diagnostics" },
}
EOF


"""" leader:
nmap <C-Space> <Space>
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
lua WK.add { {"<leader>T", "<cmd>terminal bash<cr>", desc = "open terminal"} }


"""" my lua helpers:
luafile ~/.config/nvim/lua/helpers.lua


"""" telescope:
lua << EOF
local select_one_or_multi = function(prompt_bufnr)
  local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
  local multi = picker:get_multi_selection()
  if not vim.tbl_isempty(multi) then
    require('telescope.actions').close(prompt_bufnr)
    for _, j in pairs(multi) do
      if j.path ~= nil then
        vim.cmd(string.format('%s %s', 'edit', j.path))
      end
    end
  else
    require('telescope.actions').select_default(prompt_bufnr)
  end
end

local telescope = require'telescope'
local lga_actions = require'telescope-live-grep-args.actions'
telescope.setup {
  extensions = { live_grep_args = { auto_quoting = true } },
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      -- above are the defaults
      "--glob", "*",
      "--glob", "!.git",
      "--glob", "!notebooks"
    },
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
    mappings = {
      i = {
        ['<CR>'] = select_one_or_multi,
        ['<C-k>'] = lga_actions.quote_prompt({postfix = [[ -g "!*test*" -g "!*notebook*"]]}),
      },
    },
  },
}

telescope.load_extension'file_browser' -- telescope-file-browser
telescope.load_extension'fzf' -- telescope-fzf
telescope.load_extension'live_grep_args' -- telescope-live-grep-args

local builtins = require'telescope.builtin'
local find_files = builtins.find_files
local buffers = builtins.buffers
local live_grep = builtins.live_grep
WK.add {
  mode = { "n" },
  { "<leader>f", group = "telescope" },
  -- general telescope commands
  { "<leader>fF", function() find_files { hidden = true, no_ignore = true  } end,   desc = "search all file names"},
  { "<leader>ff", "<cmd>Telescope git_files<cr>",                                   desc = "search git file names"},
  { "<leader>fa", live_grep,                                                        desc = "search all files"},
  { "<leader>fA", telescope.extensions.live_grep_args.live_grep_args,               desc = "search all files with args"},
  { "<leader>fp", function() find_files { cwd = '$HOME/.config/nvim/plugged' } end, desc = "search nvim plugin file names"},
  { "<leader>fb", function() live_grep { grep_open_files = true } end,              desc = "search in open buffers"},
  { "<leader>fB", function() buffers { last_used = true } end,                      desc = "search open buffer file names"},
  { "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>",                   desc = "search current buffer"},
  { "<leader>f:", "<cmd>Telescope command_history<cr>",                             desc = "search command history"},
  -- not really a telescope command
  { "<leader>f'", "/[^[:alnum:][:punct:][:space:]]<cr>", desc = "search non-ascii chars" },
  -- git telescope commands
  {
    { "<leader>fg", group = "git telescope commands" },
    { "<leader>fgB", "<cmd>Telescope git_branches<cr>", desc = "search git branches"},
    { "<leader>fgs", "<cmd>Telescope git_status<cr>",   desc = "search git status"},
    { "<leader>fgt", "<cmd>Telescope file_browser<cr>", desc = "telescope filebrowser" },
    { "<leader>fgtL", "<cmd>Telescope reloader<cr>",    desc = "telescope reloader" },
  },
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
WK.add {
  mode = { "n" },
  { "<leader>LCS", group = "toggle show listchars" },
  { "<leader>LCSL", function() lcs.toggleShow() end,     desc = "on/off"},
  { "<leader>LCSs", function() lcs.toggleShow('s') end,  desc = "toggle space"},
  { "<leader>LCSt", function() lcs.toggleShow('tb') end, desc = "toggle tab"},
  { "<leader>LCSe", function() lcs.toggleShow('e') end,  desc = "toggle eol"},
  { "<leader>LCSr", function() lcs.toggleShow('tr') end, desc = "toggle trailing space"},
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
highlight! link DiagnosticUnnecessary Comment " unused variables should be formatted the same as comments


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
    show_duplicate_prefix = true,
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
    "c", "cpp",
    "rust",
    "javascript", "typescript", "tsx",
    "json", "ron", "yaml",
    "lua", "teal", "vim",
    "python",
    "bash",
    "java", "kotlin",
    "markdown", "latex",
    "dockerfile", "hcl", "terraform",
    "css", "scss", "html",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
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


"""" aerial.nvim
lua << EOF
vim.o.splitkeep = 'screen' -- need this for some reason
local fk = { "Class", "Constructor", "Enum", "Function", "Interface", "Module", "Method", "Struct" }
local aerial_settings =            { filter_kind = fk,    highlight_on_hover = true, manage_folds = true, link_tree_to_folds = true }
local aerial_settings_unfiltered = { filter_kind = false, highlight_on_hover = true, manage_folds = true, link_tree_to_folds = true }

require'aerial'.setup(aerial_settings)
local is_unfiltered = false

local function toggle_filter()
  local new_is_unfiltered = not is_unfiltered
  local new_settings = new_is_unfiltered and aerial_settings_unfiltered or aerial_settings
  print('unfiltered: ' .. (new_is_unfiltered and 'true' or 'false'))
  local aerial = require'aerial'
  aerial.setup(new_settings)
  aerial.refetch_symbols(0)

  is_unfiltered = new_is_unfiltered
end

WK.add {
  mode = { "n" },
  { "<leader>a", group = "symbols outline" },
  { "<leader>aa", "<cmd>AerialToggle right<cr>", desc = "toggle symbols outline"},
  { "<leader>at", toggle_filter,                 desc = "toggle symbols filtering"},
}
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

local cmp = require'cmp'
cmp.setup {
  snippet = { expand = function(args) require'luasnip'.expand_snippet(args.body) end },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = "luasnip" },
  },
  mapping = {
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-y>'] = cmp.mapping.scroll_docs(-4),
    ['<C-e>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    -- <cr> only inserts completion if choice is selected
    ["<CR>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
          fallback()
        end
      end,
      s = cmp.mapping.confirm({ select = true }),
      c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
    }),
    ['<cr>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  }
}
EOF


"""" luasnip: snippets
lua require'luasnip.loaders.from_vscode'.lazy_load()
" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'


"""" treesj: change code from single line to multiline (and vice versa) syntax style where applicable
lua << EOF
local tsj = require'treesj'
local tsj_lu = require'treesj.langs.utils'
tsj.setup {
  use_default_keymaps = false,
  max_join_length = 140,
}

local no_last_sep = { lua=true }
WK.add {
  { "<leader>s", group = "multiline or single-line argument formatter"},
  { "<leader>si", tsj.join,                                                                            desc = "join [I]n" },
  { "<leader>so", function() tsj.split { split = { last_separator = not no_last_sep[vim.o.ft] } } end, desc = "split [O]ut" },
}
EOF


"""" LSP-CONFIG: neovim-native Language Server Protocol client configuration
lua << EOF
WK.add {
  mode = { "n" },
  { "<leader>k", group = "LSP actions" },
  { "<leader>kD", function() vim.lsp.buf.declaration() end,              desc = "go to declaration" },
  { "<leader>kd", function() vim.lsp.buf.definition() end,               desc = "go to defintion" },
  { "<leader>kh", function() vim.lsp.buf.hover() end,                    desc = "hover info" },
  { "<leader>kH", function() vim.lsp.buf.signature_help() end,           desc = "show signature" },
  { "<leader>kt", function() vim.lsp.buf.type_definition() end,          desc = "show type def" },
  { "<leader>kr", function() vim.lsp.buf.rename() end,                   desc = "rename" },
  { "<leader>ka", function() vim.lsp.buf.code_action() end,              desc = "show all actions" },
  { "<leader>kv", "<cmd>Telescope lsp_references<cr>",                   desc = "list references" },
  { "<leader>ke", function() vim.diagnostic.open_float() end,            desc = "open in floating window" },
  { "<leader>kq", function() vim.lsp.diagnostic.set_loclist() end,       desc = "loclist for errors" },
  { "<leader>kf", function() vim.lsp.buf.format() end,                   desc = "format buffer" },
  { "<leader>k]", function() vim.diagnostic.goto_next({severity=1}) end, desc = "go to next error" },
  { "<leader>k[", function() vim.diagnostic.goto_prev({severity=1}) end, desc = "go to prev error" },
}
WK.add {
  mode = { "n" },
  { "<leader>i", group = "LSP goto warning" },
  { "<leader>i]", function() vim.diagnostic.goto_next() end, desc = "go to next warning" },
  { "<leader>i[", function() vim.diagnostic.goto_prev() end, desc = "go to prev warning" },
}

vim.lsp.set_log_level("debug")
local lspconfig = require('lspconfig')

local servers = { "rust_analyzer", "tsserver", "ruff", "pyright", "teal_ls", "kotlin_language_server" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = require'cmp_nvim_lsp'.default_capabilities(),
    flags = { debounce_text_changes = 150 },
  }
end
EOF


"""" rooter: set the cwd to the project root automatically
let g:rooter_patterns = ['.git', 'pyproject.toml']


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
lua << EOF
local harpoon_mark = require'harpoon.mark'
local harpoon_ui = require'harpoon.ui'
WK.add {
  mode = { "n" },
  { "<leader>h", group = "harpoon" },
  { "<leader>ha", harpoon_mark.add_file,              desc = "harpoon add file" },       -- <c-d> to delete entries
  { "<leader>hh", "<cmd>Telescope harpoon marks<cr>", desc = "harpoon telescope menu" }, -- <c-d> to delete entries
  { "<leader>hH", harpoon_ui.toggle_quick_menu,       desc = "harpoon toggle menu" },
}
EOF


"""" icon-picker
lua << EOF
require'icon-picker'.setup{}
WK.add {
  mode = { "n" },
  { "<leader>i", group = "icon-picker" },
  { "<leader>ii", "<cmd>PickEmoji<cr>",      desc = "pick emoji" },
  { "<leader>iI", "<cmd>PickEverything<cr>", desc = "pick any icon" },
}
EOF
" e is for emoji
inoremap <c-e> <cmd>PickEmojiInsert<cr>

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


"""" neogit
lua require'neogit'.setup {}


"""" git-conflict: handle merge conflicts slightly better
lua require('git-conflict').setup()


lua << EOF
local gs = require'gitsigns'
function toggle_blame() print('show_blame=' .. bool_to_str(gs.toggle_current_line_blame())) end
WK.add {
  mode = "n",
  { "<leader>g", group = "git" },
  { "<leader>gb", toggle_blame,      desc = "toggle line blame"},
  { "<leader>gg", "<cmd>Neogit<cr>", desc = "neogit"},
  {
    { "<leader>gh", group = "gitsigns hunk" },
    { "<leader>ghp", "<cmd>Gitsigns preview_hunk<cr>",    desc = "preview hunk" },
    { "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>",      desc = "reset hunk" },
    { "<leader>ghs", "<cmd>Gitsigns stage_hunk<cr>",      desc = "stage hunk" },
    { "<leader>ghu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "unstage hunk" },
    { "<leader>gh]", "<cmd>Gitsigns next_hunk<cr>",       desc = "next hunk" },
    { "<leader>gh[", "<cmd>Gitsigns prev_hunk<cr>",       desc = "previous hunk" },
    {
      { "<leader>ghc", group = "change gitsigns diff base" },
      { "<leader>ghcc", "<cmd>Gitsigns change_base<space>",     desc = "diff against custom refname" },
      { "<leader>ghcm", "<cmd>Gitsigns change_base master<cr>", desc = "diff against master" },
      { "<leader>ghch", "<cmd>Gitsigns change_base HEAD<cr>",   desc = "diff unstaged" },
    },
  },
  {
    { "<leader>gc", group = "conflict" },
    { "<leader>gco", "<cmd>GitConflictChooseOurs<cr>",   desc = "choose ours" },
    { "<leader>gct", "<cmd>GitConflictChooseTheirs<cr>", desc = "choose theirs" },
    { "<leader>gcb", "<cmd>GitConflictChooseBoth<cr>",   desc = "choose both" },
    { "<leader>gcn", "<cmd>GitConflictChooseNone<cr>",   desc = "choose neither" },
    { "<leader>gcc", "<cmd>GitConflictListQ<cr>",        desc = "list conflicts" },
    { "<leader>gc]", "<cmd>GitConflictNextConflict<cr>", desc = "next conflict" },
    { "<leader>gc[", "<cmd>GitConflictPrevConflict<cr>", desc = "prev conflict" },
  },
}
EOF
"""" git END


"""" nvim-surround
lua require'nvim-surround'.setup{}


"""" text-case and nerdcommenter
lua << EOF
-- nerdcommenter
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
  WK.add {
    mode = mode,
    { "<leader>c", group = "NerdComment & Text-Case" },
    { "<leader>c/", "<Plug>NERDCommenterToggle", desc = "toggle comment" },
    { "<leader>c?", "<Plug>NERDCommenterInvert", desc = "invert comment" },
    { 
      { "<leader>cc", name = "text-case" },
      { "<leader>ccu", make_onkeypress_function('to_upper_case'),  desc = "upper case" },
      { "<leader>ccl", make_onkeypress_function('to_lower_case'),  desc = "lower case" },
      { "<leader>cc_", make_onkeypress_function('to_snake_case'),  desc = "snake case" },
      { "<leader>cc-", make_onkeypress_function('to_dash_case'),   desc = "dash case" },
      { "<leader>cc.", make_onkeypress_function('to_dot_case'),    desc = "dot case" },
      { "<leader>ccc", make_onkeypress_function('to_camel_case'),  desc = "camel case" },
      { "<leader>ccp", make_onkeypress_function('to_pascal_case'), desc = "pascal case" },
      { "<leader>cc/", make_onkeypress_function('to_path_case'),   desc = "path case" },
    },
  }
end
EOF


"""" undotree: view and access the entire edit history of the buffer
lua << EOF
WK.add { { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "undotree toggle" } }
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
vim.keymap.set('n', 'zM', require'ufo'.closeAllFolds, { desc = "close all folds" })
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

WK.add { { "<leader>NN", "<cmd>lua toggleNums()<cr>", desc= "toggle line numbers" } }
EOF

" reload file
lua << EOF
WK.add {
  { "<leader>rr", "<cmd>bufdo e<cr>",                        desc = "re-open current file" },
  { "<leader>rc", "<cmd>source ~/.config/nvim/init.vim<cr>", desc = "re-load config" },
}
EOF
" remove trailing whitespace + tabs to spaces
function RemoveTrailingWhitespace_and_TabsToSpaces()
  :exe "silent! :%s/\\s\\+\\n/\\r/"
  :exe "silent! :%s/\\t/    /g"
endfunction

lua WK.add { { "<leader>rmw", "<cmd>call RemoveTrailingWhitespace_and_TabsToSpaces()<cr>", desc = "rm trailing \\s, and tabs to spaces" } }

" :split opens to the right or below
lua vim.o.splitright = true
lua vim.o.splitbelow = true

" I think is prevents crashes in some buggy LSPs?
lua vim.go.bk = false
lua vim.go.wb = false


"""" windows
lua << EOF
WK.add {
  mode = "n",
  { "<leader><leader>", group = "switching windows" },
  { "<leader><leader>l", "<c-w>l",     desc = "right" },
  { "<leader><leader>h", "<c-w>h",     desc = "left" },
  { "<leader><leader>j", "<c-w>j",     desc = "down" },
  { "<leader><leader>k", "<c-w>k",     desc = "up" },
  { "<leader><leader>o", "<c-w><c-w>", desc = "other" },
}
EOF
