# (dianna) .dianna/.oh-my-zsh/themes/minimally.gay.zsh-theme

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[white]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} #%{$fg[white]%})%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ○%{$fg[white]%})%{$reset_color%} "

PROMPT='%{$fg_bold[magenta]%}%2~ $(git_prompt_info)%{$fg_bold[magenta]%}›%b %{$reset_color%}'
