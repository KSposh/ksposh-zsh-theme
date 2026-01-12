# prompt style and colors based of Steve Losh's Prose theme:
# https://github.com/sjl/oh-my-zsh/blob/master/themes/prose.zsh-theme
#
# git status configurations based of Sal Ferrarello's guide:
# https://salferrarello.com/zsh-git-status-prompt/
#
# git untracted configuration from:
# https://github.com/zsh-users/zsh/blob/f9e9dce5443f323b340303596406f9d3ce11d23a/Misc/vcs_info-examples#L155-L170
# https://github.com/zsh-users/zsh/blob/f9e9dce5443f323b340303596406f9d3ce11d23a/Functions/VCS_Info/VCS_INFO_formats#L37-L50
#
# color codes from:
# https://www.ditig.com/publications/256-colors-cheat-sheet
#
# author: José Dias <ksposh>

# color configuration

if [[ $TERM = *256color ]]; then
    color_blue="%F{063}"
    color_cyan="%F{081}"
    color_green="%F{082}"
    color_orange="%F{202}"
    color_purple="%F{135}"
    color_red="%F{009}"
else
    color_blue="%F{blue}"
    color_cyan="%F{cyan}"
    color_green="%F{green}"
    color_orange="%F{yellow}"
    color_purple="%F{magenta}"
    color_red="%F{red}"
fi

# markers

usr_config="${color_purple}%n%{$reset_color%}"
pwd_config="${color_green}%~%{$reset_color%}"
sep_config="${color_orange}»%{$reset_color%}"
lh_config="${color_orange}<%{$reset_color%}"
rh_config="${color_orange}>%{$reset_color%}"
split_config="${color_orange}§%{$reset_color%}"


# git configurations 

autoload -Uz vcs_info add-zsh-hook
setopt prompt_subst
add-zsh-hook precmd vcs_info

zstyle ':vcs_info:*' check-for-changes true

FMT_BRANCH=" ${sep_config} ${color_cyan}%b%{$reset_color%}"
FMT_ACTION="${tilda_config}${color_blue}%a%{$reset_color%}"
FMT_UNSTAGED=" ${color_orange}▼%{$reset_color%}"
FMT_STAGED=" ${color_green}▲%{$reset_color%}"
FMT_UNTRACKED=" ${color_red}🞍%{$reset_color%}"

+vi-set-git-items() {
    if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == 'true' ]]; then
        staged_count="$(git diff --staged --numstat | wc -l)"
        unstaged_count="$(git diff --numstat | wc -l)"
        if [[ "$staged_count" -gt "0" ]]; then
            hook_com[staged]+=" ${color_green}$staged_count%{$reset_color%}"
        fi
        if [[ "$unstaged_count" -gt "0" ]]; then
            hook_com[unstaged]+=" ${color_orange}$unstaged_count%{$reset_color%}"
        fi
    fi
}

+vi-set-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == 'true' ]]; then
        if [[ $(git ls-files --other --exclude-standard | wc -l) -gt "0" ]]; then
            hook_com[misc]="${FMT_UNTRACKED}"
        fi
    fi
}

zstyle ':vcs_info:git*+set-message:*' hooks set-git-items set-untracked
zstyle ':vcs_info:*' stagedstr "${FMT_STAGED}"
zstyle ':vcs_info:*' unstagedstr "${FMT_UNSTAGED}"
#zstyle ':vcs_info:*'     untrackedstr  "${FMT_UNTRACKED}"
zstyle ':vcs_info:git:*' actionformats "${FMT_BRANCH}${FMT_ACTION}%u%c"
zstyle ':vcs_info:git:*' formats "${FMT_BRANCH}%m%u%c"
zstyle ':vcs_info:*' nvcsformats ""

# virtualenv configurations

ZSH_THEME_VIRTUALENV_PREFIX=" ${sep_config} ${color_red}"
ZSH_THEME_VIRTUALENV_SUFFIX="%{$reset_color%}"

# PROMPT 
# comment out what you don't want included
# be aware of spacing

PROMPT=" "
# PROMPT+="${usr_config}"
# PROMPT+=" ${sep_config} "
PROMPT+="${pwd_config}"
PROMPT+="\$(virtualenv_prompt_info)"
PROMPT+="\${vcs_info_msg_0_}"
PROMPT+=" ${split_config} "
PROMPT+="%{$reset_color%}"

# Use modern completion system
autoload -Uz compinit
compinit

# TODO needs revision. Unsure about this.
# # Use modern completion system
# autoload -Uz compinit
# compinit

# zstyle ':completion:*' auto-description 'specify: %d'
# zstyle ':completion:*' completer _expand _complete _correct _approximate
# zstyle ':completion:*' format 'Completing %d'
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*' menu select=2
# eval "$(dircolors -b)"
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
# zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
# zstyle ':completion:*' menu select=long
# zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle ':completion:*' use-compctl false
# zstyle ':completion:*' verbose true

# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
# zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

