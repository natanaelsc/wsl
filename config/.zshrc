# ZSH Configuration

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Define variavéis importantes
export ZSH="$HOME/.oh-my-zsh"
export LANG="en_US.UTF-8"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export GPG_TTY=$(tty)

# Tema padrão
ZSH_THEME="powerlevel10k/powerlevel10k"

CASE_SENSITIVE="true"

# Plugins
plugins=(git zsh-autosuggestions asdf gpg-agent)

source $ZSH/oh-my-zsh.sh

# Preenchimento automático do Angular CLI.
# source <(ng completion script)

# Aliases
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias dev="cd ~/development"
alias dockerstop="docker stop $(docker ps -aq)"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# pnpm
export PNPM_HOME="/home/natanael/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

GITSTATUS_LOG_LEVEL=DEBUG
