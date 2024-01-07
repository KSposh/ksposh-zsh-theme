# prompt style and colors based of Steve Losh's Prose theme:
# https://github.com/sjl/oh-my-zsh/blob/master/themes/prose.zsh-theme
#
# git status configurations based of Sal Ferrarello's guide:
# https://salferrarello.com/zsh-git-status-prompt/
#
# color configurations from:
# https://www.ditig.com/publications/256-colors-cheat-sheet
#
# author: José Dias <ksposh>

# extended color palette when available
if [[ $TERM = *256color ]]; then
  color_blue="$FG[057]"
  color_cyan="%F{81}"
  color_green="$FG[082]"
  color_orange="$FG[202]"
  color_purple="$FG[135]"
  color_red="$FG[009]"
else
  color_blue="%F{blue}"
  color_cyan="%F{cyan}"
  color_green="%F{green}"
  color_orange="%F{yellow}"
  color_purple="%F{magenta}"
  color_red="%F{red}"
fi

pwd_config="${color_green}%~%{$reset_color%}"
sep_config="${color_orange} » %{$reset_color%}"
split_config="${color_orange} § %{$reset_color%}"
usr_config="${color_purple}%n%{$reset_color%}"

# git configurations 

autoload -Uz vcs_info add-zsh-hook
setopt prompt_subst
add-zsh-hook precmd vcs_info

zstyle ':vcs_info:*' check-for-changes true

FMT_BRANCH="${sep_config}${color_cyan}%b%u%c%{$reset_color%}"
FMT_ACTION="${sep_config}${color_blue}%a%{$reset_color%}"
FMT_UNSTAGED="${color_orange} ●"
FMT_STAGED="${color_green} ●"

zstyle ':vcs_info:*' unstagedstr "${FMT_UNSTAGED}"
zstyle ':vcs_info:*' stagedstr "${FMT_STAGED}"
zstyle ':vcs_info:git:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
zstyle ':vcs_info:git:*' formats "${FMT_BRANCH}"
zstyle ':vcs_info:*' nvcsformats ""

# virtualenv configurations

ZSH_THEME_VIRTUALENV_PREFIX="${sep_config}${color_red}"
ZSH_THEME_VIRTUALENV_SUFFIX="%{$reset_color%}"

PROMPT="${usr_config}${sep_config}${pwd_config}\$(virtualenv_prompt_info)\${vcs_info_msg_0_}${split_config}"

