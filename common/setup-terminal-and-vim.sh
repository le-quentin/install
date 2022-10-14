#!/bin/sh

# This script assumes that vim dotfiles are already imported

# Exit on any command fail
set -e

# vim-plug to manage vim plugins
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
gvim -v +'PlugInstall --sync' +qa
gvim -v -u ~/.vimrc.ide +'PlugInstall --sync' +qa

# fancy terminal
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" "--unattended"
mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/erikw/tmux-powerline.git $HOME/.tmux-powerline
