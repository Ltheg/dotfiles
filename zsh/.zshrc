
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/logan.hegler/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/logan.hegler/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/Users/logan.hegler/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/Users/logan.hegler/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH=$PATH:/System/Volumes/Data/opt/homebrew/Cellar/postgresql@17/17.2/bin/  
export PATH="/opt/homebrew/opt/postgresql@14/bin:$PATH"

# color highlight ls outputs
alias ls='ls -G'

# Begin Starshp and terminal config set up #

# ~/.zshrc  -- copy-paste this entire block

export PATH="/usr/local/bin:$HOME/.local/bin:$PATH"

# completion scripts path must be in $fpath before compinit
#    (this ensures zsh-completions functions are picked up)
fpath=(~/.zsh/zsh-completions/src $fpath)

autoload -Uz compinit
compinit

# performance / autosuggest options (optional)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# enable autosuggestions (history-based ghost text)
if [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# initialize Starship (prompt renderer)
eval "$(starship init zsh)"

# source syntax highlighting last (required by plugin)
if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

