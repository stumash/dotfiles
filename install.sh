TARGET=$HOME

echo 'NEOVIM'
echo 'stowing neovim configs'
stow --ignore='.md' --target="$TARGET" nvim

echo 'GIT'
echo 'Add the following to ~/.gitconfig:'
echo '```'
echo '[include]'
echo '    path = ~/path/to/dotfiles/git/.gitconfig'
echo '```'
echo 'You may also want to add these lines for your work-specific or'
echo 'personal-project-specific identities/configs:'
echo '```'
echo '[includeIf "gitdir:~/hopper/"]'
echo '    path = ~/hopper/.gitconfig'
echo '[includeIf "gitdir:~/me/code/"]'
echo '    path = ~/me/code/.gitconfig'
echo '```'
echo

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
echo
