# (dianna) .dianna/.oh-my-zsh/themes/minimally.gay.zsh-theme

if [[ "$TERM" =~ 256color ]]; then
  ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[white]%}("
  ZSH_THEME_GIT_PROMPT_SUFFIX=""
  ZSH_THEME_GIT_PROMPT_DIRTY="%F{203} #%{$fg[white]%})%{$reset_color%} "
  ZSH_THEME_GIT_PROMPT_CLEAN="%F{193} ○%{$fg[white]%})%{$reset_color%} "
  PROMPT='%F{213}%2~ $(git_prompt_info)%(?..[%F{203}%?%{$reset_color%}] )%F{213}›%b %{$reset_color%}'
else
  ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[white]%}("
  ZSH_THEME_GIT_PROMPT_SUFFIX=""
  ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} #%{$fg[white]%})%{$reset_color%} "
  ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ○%{$fg[white]%})%{$reset_color%} "
  PROMPT='%{$fg_bold[magenta]%}%2~ $(git_prompt_info)%(?..[%{$fg[red]%}%?%{$reset_color%}] )%{$fg_bold[magenta]%}›%b %{$reset_color%}'
fi
