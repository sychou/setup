# Setup

This is a setup script for new MacOS and Debian machines. It installs a number of useful tools and sets up a number of configurations.

## Tools Included

- bat - combo cat / less - https://github.com/sharkdp/bat
- curl - working with urls - https://curl.se/
- eza - improved ls - https://eza.rocks
- fd - improved find - https://github.com/sharkdp/fd
- fzf - fuzzy finder - https://github.com/junegunn/fzf
- gdu-go - go disk usage - https://github.com/dundee/gdu
- htop - improved top - https://htop.dev/
- httpie - easier curl - https://github.com/httpie/httpie
- jq - sed for json - https://stedolan.github.io/jq/
- neovim - improved vim - https://neovim.io/
- ripgrep - improved grep - https://github.com/BurntSushi/ripgrep
- starship - prompt - https://starship.rs
- tailscale - virtual network and VPN - https://tailscale.com/
- tldr - helpful man - https://tldr.sh
- wezterm - improved terminal - https://wezfurlong.org/wezterm/
- wget - working with urls - https://www.gnu.org/software/wget/
- zsh - improved bash - https://zsh.sourceforge.io/

## Installation

To use:

If using Debian, ensure you have all necessary files:

```sh
apt update
apt install -y dialog
apt install -y sudo
apt install -y curl
```

Next, run the setup file:

```sh
mkdir ~/bin
cd ~/bin
curl -o setup.sh https://raw.githubusercontent.com/sychou/setup/main/setup.sh
bash setup.sh
```

You will need to manually set up tailscale.

```sh
tailscale up
```

## Notes

- You must download the script as it has user prompts that will not work unless run directly.
- There is no need to clone or download this repo directly.
