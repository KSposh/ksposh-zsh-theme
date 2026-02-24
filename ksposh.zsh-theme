#!/bin/sh
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

## ---
## Functions
## ---

+vi-acquire-git-change-info() {
	if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
		count_staged="$(git diff-index --cached --name-only HEAD | wc -l)"
		count_unstaged="$(git diff-files --name-only | wc -l)"

		if [ "$count_staged" -gt 0 ]; then
			hook_com[staged]+="${color_green}$count_staged%{$reset_color%}"
		fi
		if [ "$count_unstaged" -gt 0 ]; then
			hook_com[unstaged]+="${color_orange}$count_unstaged%{$reset_color%}"
		fi

	fi
}

+vi-acquire-untracked-files(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] ; then 
        if [[ $(git ls-files --other --exclude-standard | wc -l) -gt "0" ]] ; then
            hook_com[misc]="${FMT_UNTRACKED}"
        fi
    fi
}
## ---
## Color Scheme
## ---

case "$TERM" in
	*256color)
		color_blue="%F{063}"
		color_cyan="%F{081}"
		color_green="%F{082}"
		color_orange="%F{202}"
		color_purple="%F{135}"
		color_red="%F{009}"
		;;
	*)		
		color_blue="%F{blue}"
		color_cyan="%F{cyan}"
		color_green="%F{green}"
		color_orange="%F{yellow}"
		color_purple="%F{magenta}"
		color_red="%F{red}"
		;;
esac

## ---
## Markers
## ---

usr_config="${color_purple}%n%{$reset_color%}"
pwd_config="${color_green}%~%{$reset_color%}"
sep_config="${color_orange}»%{$reset_color%}"
la_config="${color_orange}<%{$reset_color%}"
ra_config="${color_orange}>%{$reset_color%}"
split_config="${color_orange}§%{$reset_color%}"

# git configurations 

autoload -Uz vcs_info add-zsh-hook
setopt prompt_subst
add-zsh-hook precmd vcs_info

zstyle ':vcs_info:*' check-for-changes true

FMT_BRANCH=" ${sep_config} ${color_cyan}%b%{$reset_color%}"
FMT_ACTION=" ${ra_config}${color_blue}%a${la_config}%{$reset_color%}"
FMT_UNSTAGED=" ${color_orange}▼%{$reset_color%}"
FMT_STAGED=" ${color_green}▲%{$reset_color%}"
FMT_UNTRACKED=" ${color_red}?%{$reset_color%}"


zstyle ':vcs_info:git*+set-message:*' hooks acquire-git-change-info acquire-untracked-files
zstyle ':vcs_info:*'     stagedstr     "${FMT_STAGED}"
zstyle ':vcs_info:*'     unstagedstr   "${FMT_UNSTAGED}"
#zstyle ':vcs_info:*'     untrackedstr  "${FMT_UNTRACKED}"
zstyle ':vcs_info:git:*' actionformats "${FMT_BRANCH}${FMT_ACTION}%u%c" 
zstyle ':vcs_info:git:*' formats       "${FMT_BRANCH}%m%u%c"
zstyle ':vcs_info:*'     nvcsformats   ""

# virtualenv configurations

ZSH_THEME_VIRTUALENV_PREFIX=" ${sep_config} ${color_red}"
ZSH_THEME_VIRTUALENV_SUFFIX="%{$reset_color%}"

# PROMPT 
# comment out what you don't want included
# be aware of spacing

PROMPT=""
PROMPT+="${usr_config}"
PROMPT+=" ${sep_config} " 
PROMPT+="${pwd_config}"
PROMPT+="\$(virtualenv_prompt_info)"
PROMPT+="\${vcs_info_msg_0_}"
PROMPT+=" ${split_config} "
PROMPT+="%{$reset_color%}"

