TARGET=$HOME

echo 'NEOVIM'
echo 'stowing neovim configs'
stow --ignore='.md' --target="$TARGET" nvim

echo 'GIT'
echo 'stowing ~/.gitconfig'
stow --ignore='.md' --target="$TARGET" git

echo 'BASH'
echo 'stowing bash configs'
stow --ignore='.md' --target="$TARGET" bash
echo

echo 'STARSHIP'
echo 'stowing starship configs'
stow --ignore='.md' --target="$TARGET" starship
echo

echo 'OTHER'
echo 'stowing other configs'
stow --ignore='.md$' --target="$TARGET" other

# and an extra newline for readability 🤷
echo
