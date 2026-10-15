# Linuxbrew
export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"

# PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOMEBREW_PREFIX/bin:$HOME/.local/bin:$HOME/.bun/bin:/usr/local/go/bin"

# Zellij auto-start
# Kept before p10k/oh-my-zsh so the outer shell execs zellij without loading everything twice.

WM_VAR="/$ZELLIJ"
WM_CMD="zellij"

function start_if_needed() {
    if [[ $- == *i* ]] && [[ -z "${WM_VAR#/}" ]] && [[ -t 1 ]] \
        && [[ -z "$SSH_CONNECTION" ]] && command -v "$WM_CMD" >/dev/null; then
        exec $WM_CMD
    fi
}

start_if_needed

# Dotfiles drift warning
function dots_check() {
    local dots="$HOME/Dots"
    [[ -d "$dots/.git" ]] || return
    local dirty=$(git -C "$dots" status --porcelain 2>/dev/null | wc -l)
    local ahead=$(git -C "$dots" rev-list --count '@{u}..HEAD' 2>/dev/null || echo 0)
    if (( dirty + ahead > 0 )); then
        print -P "%F{yellow}~/Dots: ${dirty// /} uncommitted, ${ahead} unpushed%f"
    fi
}

dots_check

# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

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

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

ou() {
    local modulo="$1"
    local db="$2"

    if [[ -z "$modulo" || -z "$db" ]]; then
        echo "Uso: ou <modulo> <db>"
        return 1
    fi

    docker compose stop web &&
    docker compose run --rm -T web odoo \
        -u "$modulo" \
        -d "$db" \
        --no-http \
        --stop-after-init &&
    docker compose start web
}

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C "$HOMEBREW_PREFIX/bin/terraform" terraform

# dbt aliases
alias dbtf="$HOME/.local/bin/dbt"
