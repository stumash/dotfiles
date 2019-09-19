#!/usr/bin/env fish

set __FILE__ (readlink -f (status --current-filename))
set __DIR__ (dirname $__FILE__)
set FISH_CONFIG_DIR "$HOME/.config/fish"

if [ "$argv[1]" != "--last-steps" ]
    # create links to functions
    set FUNCTION_FILES g.fish r.fish t.fish v.fish
    set FISH_CONFIG_DIR "$HOME/.config/fish"
    mkdir -p "$FISH_CONFIG_DIR/functions"

    ln -f "$__DIR__/config.fish" "$FISH_CONFIG_DIR/config.fish"

    for FUNCTION_FILE in $FUNCTION_FILES
        set -l TARGET "$__DIR__/functions/$FUNCTION_FILE"
        set -l LINK "$FISH_CONFIG_DIR/functions/$FUNCTION_FILE"

        ln -f $TARGET $LINK
    end

    set NEXT_STEPS \
        "" \
        "# install oh-my-fish and bobthefish" \
        "curl -L https://get.oh-my.fish > temp" \
        "and fish temp" \
        "and rm temp" \
        "" \
        "# then, run" \
        "~/dotfiles/fish/install.sh --last-steps"
    for STEP in $NEXT_STEPS
        echo "$STEP"
    end
else
    omf install bobthefish
    omf install bass

    # configure bobthefish
    cd $OMF_PATH/themes/bobthefish/
    git remote add stuhub git@github.com:stumash/theme-bobthefish.git
    git fetch stuhub
    git checkout endvi

    # add code to "$FISH_CONFIG_DIR/config.fish"
    ln -f "$__DIR__/myconfig.fish" "$FISH_CONFIG_DIR/myconfig.fish"
    echo "source $FISH_CONFIG_DIR/myconfig.fish" >> "$FISH_CONFIG_DIR/config.fish"
end
