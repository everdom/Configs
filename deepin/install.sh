#!/bin/bash

dir=`pwd`

# make directory
mkdir ../build
cd ../build

# install tools
sudo apt install -y curl wget aria2 zsh vim tmux git ctags cscope cowsay fortune fortune-zh trash-cli fonts-powerline fonts-firacode fish

# set zsh to default

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install oh-my-zsh extra plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# install powerline fonts
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mv PowerlineSymbols.otf ~/.local/share/fonts/
fc-cache -vf ~/.local/share/fonts/
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit

cd ..
#rm -rf fonts

# make signal links to share zsh configs among all users
rm ~/.zshrc.bak
mv ~/.zshrc ~/.zshrc.bak
ln -s $dir/.zshrc ~/.zshrc

# install spf13 vim config
curl https://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh

# make signal links to share vim configs among all users
rm ~/.vimrc.local.bak
mv ~/.vimrc.local ~/.vimrc.local.bak
ln -s $dir/.vimrc.local ~/.vimrc.local

rm ~/.ideavimrc.bak
mv ~/.ideavimrc ~/.ideavimrc.bak

# set git editor to vim
git config --global core.editor vim

# install emacs26
aria2c http://ftp.gnu.org/gnu/emacs/emacs-26.2.tar.xz
tar -xzvf emacs* && cd emacs*
# install emacs dependencies
sudo apt install -y libjpeg-dev libpng-dev libtiff5-dev libxaw3dxft8-dev librsvg2-dev libcairo2-dev liblcmaps-dev imagemagick libgpm-dev libdbus-1-dev libgconf2-dev libfreetype6-dev libm17n-dev libotf-dev libxft-dev libsystemd-dev
./configure --with-mailutils --without-selinux
make
sudo make install

# install spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
cd ~/.emacs.d/
git checkout develop
rm ~/.spacemacs.bak
mv ~/.spacemacs ~/.spacemacs.bak
ln -s $dir/.spacemacs ~/.spacemacs

# install tmux config
git clone https://github.com/gpakosz/.tmux.git ~/
ln -s -f .tmux/.tmux.conf ~/
cp ~/.tmux/.tmux.conf.local ~/
echo "tmux_conf_theme_left_separator_main='\uE0B0'">>~/.tmux.conf.local
echo "tmux_conf_theme_left_separator_sub='\uE0B1'">>~/.tmux.conf.local
echo "tmux_conf_theme_right_separator_main='\uE0B2'">>~/.tmux.conf.local
echo "tmux_conf_theme_right_separator_sub='\uE0B3'">>~/.tmux.conf.local

# install linuxbrew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
test -r ~/.zprofile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.zprofile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.zprofile

# install fzf ccat exa
brew install fzf
$(brew --prefix)/opt/fzf/install
brew install ccat
brew install exa

cd $dir
