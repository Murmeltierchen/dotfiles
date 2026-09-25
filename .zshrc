if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

export COMPOSE_PROGRESS=plain

ZSH_THEME="powerlevel10k/powerlevel10k"
DEFAULT_USER="$USER"

zstyle ':omz:update' mode auto

COMPLETION_WAITING_DOTS="true"

HIST_STAMPS="yyyy-mm-dd"

plugins=(git command-not-found sudo kitty zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

alias :q='exit'
alias :qa='exit'

i() {
    if [ "$#" -eq 0 ]; then
        yay -Syu --sudoloop --removemake
    else
        yay -S --needed --sudoloop --removemake "$@"
    fi
}

mkd() {
  for i in *.$1(N); do
    mkdir -p "${i%.*}" && mv -n "$i" "${i%.*}/"
  done
}

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
export PATH="$HOME/.local/bin:$PATH"

fpath=(~/.zsh/completions $fpath)
autoload -U compinit
compinit
