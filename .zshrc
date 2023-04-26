# (dianna) .dianna/.zshrc

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
alias ls='ls -la'
alias mv='mv -vi'
alias rm='rm -viI'

### overrides
# yes... sometimes I screw up
alias ed="$EDITOR"

##
## globals
##

### PATH

# custom scripts
if [ -d "$HOME/develop/scripts/bin" ]; then
  path+=("$HOME/develop/scripts/bin")
fi

# homebrew
if [ -d '/opt/homebrew' ]; then
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
fi

### GnuPG TTY support
# note: works around terminal i/o issues for PIN input in certain cases
export GPG_TTY=$(tty)
