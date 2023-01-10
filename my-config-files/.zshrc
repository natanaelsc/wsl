# My zsh config

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Inicia daemon do Docker na inicialização, se não iniciar sozinho.
RUNNING=`ps aux | grep dockerd | grep -v grep`
if [ -z "$RUNNING" ]; then
    sudo dockerd > /dev/null 2>&1 &
    disown
fi

# Define variavéis importantes
export ZSH="$HOME/.oh-my-zsh"
export LANG="en_US.UTF-8"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Tema padrão
ZSH_THEME="powerlevel10k/powerlevel10k"

CASE_SENSITIVE="true"

# Plugins
plugins=(git ssh-agent zsh-autosuggestions zsh-nvm asdf)

source $ZSH/oh-my-zsh.sh

# Preenchimento automático do Angular CLI.
# source <(ng completion script)

# Aliases
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias dev="cd ~/development"
alias dockerstop="docker stop $(docker ps -aq)"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
