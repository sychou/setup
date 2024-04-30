# Setup

This is a setup script for new MacOS and Debian machines.

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

Notes:

- You must download the script as it has user prompts that will not work unless run directly.
- There is no need to clone or download this repo directly.
