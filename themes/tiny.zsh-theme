# =============================================================================
# THEMES/TINY.ZSH-THEME
# =============================================================================

MYZSH_COLOR_PATH="cyan"          
MYZSH_COLOR_GIT_WRAP="blue"
MYZSH_COLOR_GIT_BRANCH="red"
MYZSH_COLOR_DIRTY="yellow"       

MYZSH_GIT_DIRTY=" ✗"             
MYZSH_GIT_CLEAN=""               

_myzsh_git_prompt() {
    myzsh_is_git_repo || return

    local branch
    branch=$(myzsh_git_branch)
    [[ -z "$branch" ]] && return

    local status_symbol
    status_symbol=$(myzsh_git_status)

    if [[ -n "$status_symbol" ]]; then
        status_symbol="%B%F{$MYZSH_COLOR_DIRTY}${status_symbol}%f%b"
    fi

    echo -n " %B%F{$MYZSH_COLOR_GIT_WRAP}git:(%f%F{$MYZSH_COLOR_GIT_BRANCH}${branch}%f%F{$MYZSH_COLOR_GIT_WRAP})%f%b${status_symbol}"
}

_myzsh_precmd_prompt() {
    local prompt_str=""

    prompt_str+="%B%(?.%F{green}.%F{red})➜%f%b  "
    prompt_str+="%B%F{$MYZSH_COLOR_PATH}%c%f%b"
    prompt_str+=$(_myzsh_git_prompt)
    prompt_str+=" "
    PROMPT="${prompt_str}"
    RPROMPT="🐷%F{magenta}〰️💕〰️%f🦆 %B%(?.%F{green}.%F{red})[%D{%H:%M:%S}]%f%b"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _myzsh_precmd_prompt