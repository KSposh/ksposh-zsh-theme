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
# virtualenv configurations from:
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/virtualenv/virtualenv.plugin.zsh

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
		count_untracked="$(git ls-files --other --exclude-standard | wc -l)" 

		if [ "$count_staged" -gt 0 ]; then
			hook_com[staged]+="$count_staged"
		fi
		if [ "$count_unstaged" -gt 0 ]; then
			hook_com[unstaged]+="$count_unstaged"
		fi
        if [ "$count_untracked" -gt 0 ]; then
            hook_com[misc]=" ${color_red}?"

		fi
	fi
}

__zsh_virtualenv_prompt_info() {
  [ -n "$VIRTUAL_ENV" ] || return
  echo "${ZSH_THEME_VIRTUALENV_PREFIX=[}${VIRTUAL_ENV_PROMPT:-${VIRTUAL_ENV:t:gs/%/%%}}${ZSH_THEME_VIRTUALENV_SUFFIX=]}"
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

marker_user="${color_purple}%n"
marker_path="${color_green}%~"
marker_separator="${color_orange}»"
marker_less="${color_orange}<"
marker_right="${color_orange}>"
marker_split="${color_orange}§"

## ---
## Version Control (Git) Configurations
## ---

autoload -Uz vcs_info add-zsh-hook
setopt prompt_subst
add-zsh-hook precmd vcs_info

zstyle ':vcs_info:git*+set-message:*' hooks acquire-git-change-info 
zstyle ':vcs_info:git:*' formats       "${marker_separator} ${color_cyan}%b%m%u%c"
zstyle ':vcs_info:git:*' actionformats "${marker_separator} ${color_cyan}%b ${marker_right}${color_blue}%a${marker_less}%m%u%c" 
zstyle ':vcs_info:*'     stagedstr     " ${color_green}▲"
zstyle ':vcs_info:*'     unstagedstr   " ${color_orange}▼"
zstyle ':vcs_info:*'     nvcsformats   ""
zstyle ':vcs_info:*'	 check-for-changes true

## ---
## Python Virtual Env Variables
## ---

ZSH_THEME_VIRTUALENV_PREFIX="${color_red}"
ZSH_THEME_VIRTUALENV_SUFFIX=" ${marker_separator}"

## ---
## PROMPT
## Comment out what needs to be disabled
## Don't include spacing for function edits
## ---

PROMPT=""
PROMPT+="\$(__zsh_virtualenv_prompt_info)" # TODO Still not working as expected
PROMPT+=" ${marker_user}"
PROMPT+=" ${marker_separator}" 
PROMPT+=" ${marker_path}"
PROMPT+="\${vcs_info_msg_0_}"
PROMPT+=" ${marker_split}"
PROMPT+=" %{$reset_color%}"

