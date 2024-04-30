# .zshrc
# Loaded for interactive shells (i.e. not shell scripts)
# Good for things at the command line such as EDITOR, aliases,
# and command prompt

echo "Loading .zshrc"

# Check for core cli tools - bat, exa

if command -v eza &> /dev/null; then
    alias ls='eza --hyperlink -s extension'
    alias la='ls -a'
    alias ll='ls -l --no-quotes'
    alias lla='ll -a'
    alias llg='ll --git'
    alias llc='ll -s created'
else
    echo "eza not installed - https://eza.rocks"
    alias ls='gls --color=auto -F --hyperlink'
    alias ll='ls -FGlh'
    alias la='ls -Fa'
    alias lla='ls -FGlha'
fi

if command -v batcat &> /dev/null; then
   alias bat='batcat'
else
    if ! command -v bat &> /dev/null; then
        echo "bat not installed - https://github.com/sharkdp/bat"
    fi
fi

# Aliases
alias vi='nvim'
if command -v gdu-go &> /dev/null; then
    alias gdu='gdu-go'
fi

# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

# Default editor
export EDITOR=nvim
export VISUAL=nvim

# Edit with vi mode
bindkey -v

# CD path
setopt auto_cd
cdpath=($HOME $HOME/Documents $HOME/src)

# fzf
if [ -d "$HOME/.fzf/bin" ]; then
    export PATH="$HOME/.fzf/bin:$PATH"
elif [ -d "/opt/homebrew/opt/fzf/bin" ]; then
    export PATH="/opt/homebrew/opt/fzf/bin:${PATH}"
fi
eval "$(fzf --zsh)"
alias fzp="fzf --preview 'fzf-preview.sh {}'"
alias fzrm="fzf --preview 'fzf-preview.sh {}' --print0 -m | xargs -0 -o rm"
fzmv() {
    destination="$1"
    fzf --preview 'fzf-preview.sh {}' --print0 -m | while IFS= read -r -d '' file; do
        mv "$file" "$destination"
    done
}

# starship prompt
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

# pyenv
if [ -d "$HOME/.pyenv/bin" ]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
fi
if command -v pyenv &> /dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/shims:$PATH"
    eval "$(pyenv init -)"
fi

# ssh-agent
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
fi
