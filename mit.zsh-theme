function git_past_time_since_commit() {
  if git log -1 > /dev/null 2>&1; then

    last_commit=$(git log --pretty=format:'%at' -1 2> /dev/null)
    now=$(date +%s)
    time_since_last_commit=$((now-last_commit))

    mins=$((time_since_last_commit / 60))
    hrs=$((time_since_last_commit/3600))

    days=$((time_since_last_commit / 86400))
    sub_hours=$((hrs % 24))
    sub_minutes=$((mins % 60))

    if [ $hrs -gt 24 ]; then
      age="${days}d from last commit "
    elif [ $mins -gt 60 ]; then
      age="${sub_hours}h${sub_minutes}m from last commit "
    else
      age="${mins}m from last commit "
    fi

    color=$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL
    echo "$color↪️ $age%{$reset_color%}"
  fi
}

RPROMPT='%{$fg_bold[red]%} ⌚ %*%{$reset_color%}'

PROMPT='
%{╭─ $fg_bold[green]%}${PWD/#$HOME/%n}%{$reset_color%}$(git_prompt_info) $(git_past_time_since_commit)
╰─ $ '

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[yellow]%}\u26a1 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}branch"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%} \u26a1 "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[peru]%}? "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}§ "
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[yellow]%}✔ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[green]%}⚑ "
