# PATH settings

set -x INSTALLS "$HOME/installed_software"
test -d "$INSTALLS/bin"; and set -x PATH "$INSTALLS/bin" $PATH

set GO_BIN "/usr/local/go/bin"
test -d $GO_BIN; and set -x PATH $GO_BIN $PATH
test -d $INSTALLS; and set -x GOPATH $INSTALLS $GOPATH;

test -x (which npm); and set -x NODE_PATH (npm root -g)

set NVM_DIR "$HOME/.nvm"
test -d $NVM_DIR; and set -x NVM_DIR $NVM_DIR;

nvm use stable &> /dev/null

# fish settings

bass source ~/.profile

fish_vi_key_bindings

set FISH_FZF_KEYBINDINGS_PATH "$INSTALLS/fzf/shell/key-bindings.fish"
test -f $FISH_FZF_KEYBINDINGS_PATH;
and source $FISH_FZF_KEYBINDINGS_PATH;
and fzf_key_bindings

set -x EDITOR nvim
set -x VISUAL nvim

set -x theme_color_scheme gruvbox
set -x theme_display_vi yes
set -x theme_newline_cursor endvi

# virtualenv

set -x VIRTUAL_ENV_DISABLE_PROMPT 1

# nvm
nvm current > /dev/null; and nvm use default > /dev/null
