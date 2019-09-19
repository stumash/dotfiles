# fish settings

bass source ~/.profile

fish_vi_key_bindings

set -x EDITOR nvim
set -x VISUAL nvim

set -x theme_color_scheme gruvbox
set -x theme_display_vi yes
set -x theme_newline_cursor endvi

# PATH settings

set -x PATH "/usr/local/go/bin" "$HOME/installed_software/bin" $PATH
set -x GOPATH "$HOME/installed_software" $GOPATH
set -x NODE_PATH (npm root -g)
