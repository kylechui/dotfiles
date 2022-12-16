#!/bin/sh

CFG=$HOME/.cfg
CONFIG=$HOME/.config
# Move the dotfiles directory to ~/.cfg
mv ../dotfiles.git $CFG

# Create symlinks to the desired locations
ln -s $CFG/.config/alacritty $CONFIG/alacritty
ln -s $CFG/.config/autostart $CONFIG/autostart
ln -s $CFG/.config/logiops $CONFIG/logiops
ln -s $CFG/.config/zathura $CONFIG/zathura
ln -s $CFG/.oh-my-zsh $HOME/.oh-my-zsh
ln -s $CFG/.zshrc $HOME/.zshrc
sudo ln -s $CFG/default.conf /etc/keyd/default.conf

################################################################################
#                               General Settings                               #
################################################################################

# Switch default shell to zsh
sudo chsh -s $(which zsh)

# Set key speed repeat and delay times
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 40
gsettings set org.gnome.desktop.peripherals.keyboard delay 280

# Install some applications
sudo apt install alacritty flameshot

################################################################################
#                                  Oh My Zsh                                   #
################################################################################

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Install Oh My Zsh plugins
sudo apt install autojump
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

################################################################################
#                                    LaTeX                                     #
################################################################################

# Install TexLive (and necessary packages)
sudo apt install texlive-base texlive-latex-extra texlive-fonts-extra python3-pygments

################################################################################
#                                    Neovim                                    #
################################################################################

wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
sudo chmod +x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

################################################################################
#                                     Keyd                                     #
################################################################################

# Clone and build
git clone https://github.com/rvaiya/keyd
cd keyd
make && sudo make install
# Configure keyd to run on startup
sudo systemctl enable -- now keyd

################################################################################
#                                   LogiOps                                    #
################################################################################

# Install dependencies
sudo apt install cmake libevdev-dev libudev-dev libconfig++-dev
# Clone and build
git clone https://github.com/PixlOne/logiops
cd ~/logiops
mkdir build
cd build
cmake ..
make
# Configure LogiOps to run on startup
sudo systemctl enable --now logid

################################################################################
#                                  NoiseTorch                                  #
################################################################################

wget https://github.com/noisetorch/NoiseTorch/releases/download/v0.12.2/NoiseTorch_x64_v0.12.2.tgz
tar -C $HOME -h -xzf NoiseTorch_x64_v0.12.2.tgz
rm NoiseTorch_x64_v0.12.2.tgz 

# TODO (currently manual):
    # Set up GitHub SSH Key
    # Setup i3wm
