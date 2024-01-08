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
  color_blue="%F{057}"
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

usr_config="${color_purple}%n%{$reset_color%}"
pwd_config="${color_green}%~%{$reset_color%}"
sep_config="${color_orange}»%{$reset_color%}"
dot_config="${color_orange}🞄%{$reset_color%}"
split_config="${color_orange}§%{$reset_color%}"

# git configurations 

autoload -Uz vcs_info add-zsh-hook
setopt prompt_subst
add-zsh-hook precmd vcs_info

zstyle ':vcs_info:*' check-for-changes true

FMT_BRANCH=" ${sep_config} ${color_cyan}%b%{$reset_color%}"
FMT_ACTION=" ${dot_config} ${color_blue}%a%{$reset_color%}"
FMT_UNSTAGED=" ${color_red}▼%{$reset_color%}"
FMT_STAGED=" ${color_green}▲%{$reset_color%}"

zstyle ':vcs_info:*' unstagedstr "${FMT_UNSTAGED}"
zstyle ':vcs_info:*' stagedstr "${FMT_STAGED}"
zstyle ':vcs_info:git:*' actionformats "${FMT_BRANCH}${FMT_ACTION}%u%c"
zstyle ':vcs_info:git:*' formats "${FMT_BRANCH}%u%c"
zstyle ':vcs_info:*' nvcsformats ""

# virtualenv configurations

ZSH_THEME_VIRTUALENV_PREFIX=" ${sep_config} ${color_red}"
ZSH_THEME_VIRTUALENV_SUFFIX="%{$reset_color%}"

PROMPT="${usr_config} ${sep_config} ${pwd_config}\$(virtualenv_prompt_info)\${vcs_info_msg_0_} ${split_config} "

