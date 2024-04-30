# Set up a new machine

# Make sure system is either Darwin or Debian
if [[ "$(uname)" != "Darwin" && ! -f /etc/debian_version ]]; then
    echo "[SETUP] Unsupported OS. Exiting."
    exit 1
fi

# Some debian containers have zilch in apt so install some basic packages
if [[ -f /etc/debian_version ]]; then
    echo "[SETUP] Debian detected. Preparing up apt."
    apt update
    command -v git &> /dev/null || apt install -y git
    command -v wget &> /dev/null || apt install -y wget
    command -v dialog &> /dev/null || apt install -y dialog
fi

# Change to zsh first so installed files will configure for zsh
echo "[SETUP] Setting up zsh"
# Download zsh config files
curl -o ~/.zshrc https://raw.githubusercontent.com/sychou/setup/main/zshrc
curl -o ~/.zprofile https://raw.githubusercontent.com/sychou/setup/main/zprofile
# Download zsh
command -v zsh &> /dev/null || apt install -y zsh
# Change the default shell to zsh - requires user prompt
chsh -s $(which zsh)

# Create bin and download some scripts
echo "[SETUP] Setting up ~/bin"
[ ! -d ~/bin ] && mkdir ~/bin
curl -o ~/bin/fzf-preview.sh https://raw.githubusercontent.com/sychou/setup/main/fzf-preview.sh

# Create a src dir
echo "[SETUP] Setting up ~/src"
[ ! -d ~/src ] && mkdir ~/src

# Install tools using package manager
echo "[SETUP] Installing tools using package manager"

if [[ "$(uname)" == "Darwin" ]]; then

    echo "[SETUP] Darwin detected. Using Homebrew."

    # Install homebrew if needed
    if ! command -v brew &> /dev/null; then
        echo "[SETUP] Installing homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # Install packages
    echo "[SETUP] Installing brew packages"
    brew install bat eza fd fzf gdu htop jq neovim pyenv ripgrep starship tldr
    brew install --cask wezterm

elif [[ -f /etc/debian_version ]]; then

    echo "[SETUP] Debian detected. Using apt."

    # Install apt packages
    sudo apt update
    sudo apt install -y bat fd-find gdu gpg htop jq neovim ripgrep tldr-py wget

    # Add eza deb
    echo "[SETUP] Installing eza"
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza

    # Add wezterm deb
    echo "[SETUP] Installing wezterm"
    curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
    echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
    sudo apt update
    sudo apt install -y wezterm

    # Add tailscale deb
    echo "[SETUP] Installing tailscale"
    curl -fsSL https://pkgs.tailscale.com/stable/debian/bookworm.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
    curl -fsSL https://pkgs.tailscale.com/stable/debian/bookworm.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list
    sudo apt update
    sudo apt install -y tailscale

    # Install fzf (debian version is old)
    echo "[SETUP] Installing fzf"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    # Install pyenv
    # echo "[SETUP] Installing pyenv"
    # curl https://pyenv.run | bash

    # Install starship
    echo "[SETUP] Installing starship"
    curl -sS https://starship.rs/install.sh | sh

fi

echo "[SETUP] Setup is complete. Please log out and log back in using zsh, or execute 'exec zsh' to switch to zsh immediately."
