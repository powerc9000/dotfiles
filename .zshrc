## If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH=/Users/claymurray/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="gallois"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias tmux="TERM=screen-256color-bce tmux"

# added by travis gem
[ -f /Users/claym/.travis/travis.sh ] && source /Users/claym/.travis/travis.sh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh  # This loads NV
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/usr/local/bin:$PATH"

fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

alias mvim=/Applications/MacVim.app/Contents/bin/mvim
alias garbo="open https://garb.signin.aws.amazon.com/console"

e(){ echo $@; mvim --remote-tab-silent $@}

commit(){
  MESSAGE="$@"
  git commit -S -m "${message}"
}
pull(){
  GIT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
  BRANCH="${@:-$GIT_BRANCH}"
  echo $BRANCH
  git pull origin $BRANCH
}
push(){
  BRANCH="$(git rev-parse --abbrev-ref HEAD)"
  git push origin $BRANCH
}
add(){
  if [ $# -eq 0 ]
  then
    git add .
  else
    git add $@
  fi
}
now() {
  echo $(date "+%a %Y-%m-%d %H:%M:%S") - "$@" >> $HOME/.now
}

did() {
  if [ "$#" -ne 0 ]
  then
    if [ "$@" = "today" ]
    then
      cur=$(date "+%a %Y-%m-%d")
    else
      cur=$@
    fi
  else
    cur=$(date -v -1d "+%a %Y-%m-%d")
  fi
  echo "on: $cur"
  cat $HOME/.now | grep $cur
}
mktouch() {
    if [ $# -lt 1 ]; then
        echo "Missing argument";
        return 1;
    fi

    for f in "$@"; do
        mkdir -p -- "$(dirname -- "$f")"
        touch -- "$f"
    done
}
docker_tags(){
  aws ecr describe-images \
    --repository-name api \
    --output text \
    --query 'sort_by(imageDetails,& imagePushedAt)[*].imageTags[*]' \
    | tr '\t' '\n' \
    | tail -2
}

eslint_fix(){
  if [ ! -f node_modules/.bin/eslint ]; then
    echo "no local eslint using global"
    eslint $@ --fix
  else
    node_modules/.bin/eslint $@ --fix
  fi
}

eslint(){
  if [ ! -f node_modules/.bin/eslint ]; then
    echo "no local eslint using global"
    command eslint $@
  else
    node_modules/.bin/eslint $@
  fi

}
compose(){
  f="docker-compose-$1.yml"
  shift
  echo $@
  echo $f
  docker-compose -f $f $@
}

api(){
  if [ "$1" = "up" ]; then
    shift
    compose dev up -d $@
  elif [ "$1" = "stop" ]; then
    shift
    compose dev stop $@
  elif [ "$1" = "build" ]; then
    shift
    compose dev build $@
  fi
}

emacs(){
  /Applications/Emacs.app/Contents/MacOS/bin/emacsclient -n -e "(if (> (length (frame-list)) 1) ‘t)" 2> /dev/null | grep t &> /dev/null
  if [ "$?" -eq "1" ]; then
    /Applications/Emacs.app/Contents/MacOS/bin/emacsclient -a '' -nqc "$@" &> /dev/null
  else
    /Applications/Emacs.app/Contents/MacOS/bin/emacsclient -nq "$@" &> /dev/null
  fi
}

# added by travis gem
[ -f /Users/claymurray/.travis/travis.sh ] && source /Users/claymurray/.travis/travis.sh

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"


