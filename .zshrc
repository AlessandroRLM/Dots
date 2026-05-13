# Zellij auto-start

WM_VAR="/$ZELLIJ"
WM_CMD="zellij"

function start_if_needed() {
    if [[ $- == *i* ]] && [[ -z "${WM_VAR#/}" ]] && [[ -t 1 ]]; then
        exec $WM_CMD
    fi
}

start_if_needed

# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

# Linuxbrew
export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"

# PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOMEBREW_PREFIX/bin:$HOME/.local/bin:$HOME/.cargo/bin"

# Zsh plugins
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Editors
export EDITOR="nvim"
export VISUAL="nvim"

# Homebrew
eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"

# Powerlevel10k
source "$HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme"

# FZF
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Aliases
alias ls='ls --color=auto'

# Completion
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select

# Oh My Zsh
plugins=(
  git
  command-not-found
)

source "$ZSH/oh-my-zsh.sh"

# Tools
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

# P10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
