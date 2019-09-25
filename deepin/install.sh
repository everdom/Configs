#!/bin/bash

dir=`pwd`
# make directory
mkdir ../build
cd ../build

echo "--------------------------------------------------------------------------------"
echo "install packages..."
echo "--------------------------------------------------------------------------------"
sudo apt install -y curl wget aria2 zsh vim tmux git ctags cscope cowsay fortune fortune-zh trash-cli fonts-powerline fonts-firacode fish htop vim-gtk

echo "set zsh to default..."
chsh -s /usr/bin/zsh

echo "--------------------------------------------------------------------------------"
echo "install oh-my-zsh..."
echo "--------------------------------------------------------------------------------"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "--------------------------------------------------------------------------------"
echo "install oh-my-zsh extra plugins..."
echo "--------------------------------------------------------------------------------"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

#echo "--------------------------------------------------------------------------------"
#echo "install powerline fonts..."
#echo "--------------------------------------------------------------------------------"
#wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
#wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
#mv PowerlineSymbols.otf ~/.local/share/fonts/
#fc-cache -vf ~/.local/share/fonts/
#mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

## clone
#git clone https://github.com/powerline/fonts.git --depth=1
## install
#cd fonts
#./install.sh
## clean-up a bit

#cd ..
#rm -rf fonts

echo "--------------------------------------------------------------------------------"
echo "install nerd fonts..."
echo "--------------------------------------------------------------------------------"
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install
cd ..

echo "--------------------------------------------------------------------------------"
echo "make signal links to share zsh configs among all users..."
echo "--------------------------------------------------------------------------------"
rm ~/.zshrc.bak
mv ~/.zshrc ~/.zshrc.bak
ln -s $HOME/.zshrc ~/.zshrc

echo "--------------------------------------------------------------------------------"
echo "install spf13 vim config..."
echo "--------------------------------------------------------------------------------"
curl https://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh

echo "--------------------------------------------------------------------------------"
echo "make signal links to share vim configs among all users..."
echo "--------------------------------------------------------------------------------"
rm ~/.vimrc.local.bak
mv ~/.vimrc.local ~/.vimrc.local.bak
ln -s $HOME/.vimrc.local ~/.vimrc.local

rm ~/.ideavimrc.bak
mv ~/.ideavimrc ~/.ideavimrc.bak

echo "set git editor to vim..."
git config --global core.editor vim

echo "--------------------------------------------------------------------------------"
echo "install emacs26..."
echo "--------------------------------------------------------------------------------"
aria2c http://ftp.gnu.org/gnu/emacs/emacs-26.3.tar.xz
tar -xvf emacs*
cd emacs-26.3
# install emacs dependencies
sudo apt install -y libjpeg-dev libpng-dev libtiff5-dev libxaw3dxft8-dev librsvg2-dev libcairo2-dev liblcmaps-dev imagemagick libgpm-dev libdbus-1-dev libgconf2-dev libfreetype6-dev libm17n-dev libotf-dev libxft-dev libsystemd-dev
./configure --with-mailutils --without-selinux
make -j8
sudo make install

echo "--------------------------------------------------------------------------------"
echo "install spacemacs..."
echo "--------------------------------------------------------------------------------"
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
cd ~/.emacs.d/
#git checkout develop
git checkout b110ac09f94c6a412747172584c21baf3d31f507
rm ~/.spacemacs.bak
mv ~/.spacemacs ~/.spacemacs.bak
ln -s $HOME/.spacemacs ~/.spacemacs
sudo apt install graphviz

echo "--------------------------------------------------------------------------------"
echo "install tmux config..."
echo "--------------------------------------------------------------------------------"
git clone https://github.com/gpakosz/.tmux.git ~/.tmux
ln -s -f $HOME/.tmux/.tmux.conf ~/
cp ~/.tmux/.tmux.conf.local ~/
#echo "tmux_conf_theme_left_separator_main='\ue0b0'">>~/.tmux.conf.local
#echo "tmux_conf_theme_left_separator_sub='\ue0b1'">>~/.tmux.conf.local
#echo "tmux_conf_theme_right_separator_main='\ue0b2'">>~/.tmux.conf.local
#echo "tmux_conf_theme_right_separator_sub='\ue0b3'">>~/.tmux.conf.local
rm ~/.tmux.conf.local.bak
mv ~/.tmux.conf.local ~/.tmux.conf.local.bak
ln -s $HOME/.tmux.conf.local ~/.tmux.conf.local

echo "--------------------------------------------------------------------------------"
echo "install terminal tools..."
echo "--------------------------------------------------------------------------------"
sudo apt install pry mutt irssi cmus moc ranger gdb cgdb
ln -s -f $HOME/.tmux.sh ~/.tmux.sh


echo "--------------------------------------------------------------------------------"
echo "install linuxbrew..."
echo "--------------------------------------------------------------------------------"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
test -r ~/.zprofile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.zprofile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.zprofile

echo "--------------------------------------------------------------------------------"
echo "install fzf ccat exa..."
echo "--------------------------------------------------------------------------------"
brew install exa
brew install ccat
brew install fzf
$(brew --prefix)/opt/fzf/install

cd $dir
