# (dianna) .dianna/.zshrc

##
## globals
##

export DOTME="$HOME/.dianna"

### LANG
export LANG=en_US.UTF-8

### PATH

# homebrew
if [ -d '/opt/homebrew' ]; then
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
fi

# .cargo/env setup (for rust toolchains)
if [ -e "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi

# .local/bin (e.g. for pipx)
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$PATH:$HOME/.local/bin"
fi

# custom scripts
if [ -d "$HOME/develop/scripts/bin" ]; then
  export PATH="$PATH:$HOME/develop/scripts/bin"
fi

### GnuPG TTY support
# note: works around terminal i/o issues for PIN input in certain cases
export GPG_TTY=$(tty)

### LS_COLORS
export LS_COLORS="$(vivid generate $DOTME/.vivid/themes/minimally-gay.yml)"

### ZSH

# oh-my-zsh (if installed)
if [ -d "$HOME/.oh-my-zsh" ]; then
  export ZSH="$HOME/.oh-my-zsh"
fi

##
## oh-my-zsh (if installed)
##

if [[ $ZSH =~ "oh-my-zsh" ]]; then

  ### custom folder
  ZSH_CUSTOM="$DOTME/.oh-my-zsh"

  ### theme
  ZSH_THEME="minimally.gay"

  ### completions
  CASE_SENSITIVE="true"

  ### date format
  HIST_STAMPS="dd.mm.yyyy"

  ### plugins
  plugins=(git)

  ### autoupdates
  zstyle ':omz:update' mode disabled

  ### finalize
  source $ZSH/oh-my-zsh.sh

fi

##
## preferences
##

### zsh
typeset -U path

### editors
export EDITOR='nvim'
alias edit='nvim'

### builtins
alias cp='cp -vi'
alias ls='gls --color=auto'
alias mv='mv -vi'
alias rm='rm -viI'

### overrides
# yes... sometimes I screw up
alias ed="$EDITOR"

##
## completions
##

if [ -d '/opt/homebrew/share/zsh-completions' ]; then
  export FPATH="$FPATH:/opt/homebrew/share/zsh-completions"
fi

if [ -d '/opt/homebrew/share/zsh/site-functions' ]; then
  export FPATH="$FPATH:/opt/homebrew/share/zsh/site-functions"
fi

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

autoload -Uz compinit
compinit
