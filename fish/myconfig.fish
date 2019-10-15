# PATH settings

set -x PATH "/usr/local/go/bin" "$HOME/installed_software/bin" $PATH
set -x GOPATH "$HOME/installed_software" $GOPATH
set -x NODE_PATH (npm root -g)
set -x INSTALLED_SOFTWARE_PATH "$HOME/installed_software"

# fish settings

bass source ~/.profile

fish_vi_key_bindings

set FISH_FZF_KEYBINDINGS_PATH $INSTALLED_SOFTWARE_PATH/fzf/shell/key-bindings.fish
test -f $FISH_FZF_KEYBINDINGS_PATH && source $FISH_FZF_KEYBINDINGS_PATH && fzf_key_bindings

set -x EDITOR nvim
set -x VISUAL nvim

set -x theme_color_scheme gruvbox
set -x theme_display_vi yes
set -x theme_newline_cursor endvi

# virtualenv

set -x VIRTUAL_ENV_DISABLE_PROMPT 1
