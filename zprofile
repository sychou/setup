# .zprofile
# Loaded for login shells
# Best for environment variables
echo "Loading .zprofile"

# Check for Silicon Mac homebrew
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
# Check for Intel Mac homebrew
elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Set common paths
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
