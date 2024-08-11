#!/usr/bin/env bash

# (dianna) .dianna/.brew/run.sh
#
# notes:
#   ensures brew and key formulae are setup

if ! [ -x "$(command -v brew)" ]; then
  echo '(dianna) installing brew...' >&2
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
else
  echo '(dianna) updating brew...' >&2
  brew update
fi

echo '(dianna) installing or upgrading key formulae...' >&2
xargs brew install < $HOME/.dianna/.brew/formulae.txt
