#!/usr/bin/env bash
set -euo pipefail

# Set gsettings shortcuts
gsettings set org.gnome.settings-daemon.plugins.media-keys rotate-video-lock-static '[]'
gsettings set org.gnome.shell.keybindings toggle-quick-settings '[]'
gsettings set org.gnome.mutter.keybindings switch-monitor '[]'

# Install tools from APT
sudo apt update
sudo apt install -y alacritty bat neovim zsh pipx curl

# Install rust & cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"

# Install rust tools
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
cargo binstall eza zellij cargo-update

# Install Starship
curl -sS https://starship.rs/install.sh | sh -s -- --yes

# Symlink configuration files
for target in .zshrc .zfunc .gitconfig; do
  ln -sf "$PWD/$target" "$HOME/$target"
done

mkdir -p "$HOME/.config"
for target in .config/*; do
  ln -sf "$PWD/$target" "$HOME/$target"
done

# ZSH setup
RUNZSH=no CHSH=yes KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install fonts
sudo mkdir -p /usr/local/share/fonts
sudo cp fonts/*.ttf /usr/local/share/fonts
fc-cache -f -v

# Install GNOME extensions
pipx install gnome-extensions-cli --system-site-packages
export PATH="PATH:$HOME/.local/bin"
gext install BingWallpaper@ineffable-gmail.com caffeine@patapon.info run-or-raise@edvard.cz color-picker@tuberry clipboard-indicator@tudmotu.com
gext enable BingWallpaper@ineffable-gmail.com caffeine@patapon.info run-or-raise@edvard.cz color-picker@tuberry clipboard-indicator@tudmotu.com
