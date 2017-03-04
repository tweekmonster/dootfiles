#!/usr/bin/env zsh

# ------------------------------------------------------------------------------
#
# Modification of: https://github.com/kasperisager/zsh-pure/blob/master/pure.zsh-theme
#
# Pure - A minimal and beautiful theme for oh-my-zsh
#
# Based on the custom Zsh-prompt of the same name by Sindre Sorhus. A huge
# thanks goes out to him for designing the fantastic Pure prompt in the first
# place! I'd also like to thank Julien Nicoulaud for his "nicoulaj" theme from
# which I've borrowed both some ideas and some actual code. You can find out
# more about both of these fantastic two people here:
#
# Sindre Sorhus
#   Github:   https://github.com/sindresorhus
#   Twitter:  https://twitter.com/sindresorhus
#
# Julien Nicoulaud
#   Github:   https://github.com/nicoulaj
#   Twitter:  https://twitter.com/nicoulaj
#
# License
#
# Copyright (c) 2013 Kasper Kronborg Isager
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
# ------------------------------------------------------------------------------

# Set required options
#
setopt prompt_subst

# Load required modules
#
autoload -Uz vcs_info

# Set vcs_info parameters
#
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*:*' get-revision true
zstyle ':vcs_info:git*:*' check-for-changes true
zstyle ':vcs_info:git*:*' check-for-staged-changes true
zstyle ':vcs_info:*' unstagedstr '%F{yellow}*%f'
zstyle ':vcs_info:*' stagedstr '%F{green}*%f'

# hash changes branch misc
zstyle ':vcs_info:git*' formats '$(branch_color)%b%f%m%c%u'
zstyle ':vcs_info:git*' actionformats '(%F{red}%a%f) $(branch_color)%b%f %m%c%u'

# Check if there's loose files.
#
branch_color() {
    # Check if we're in a git repo
    command git rev-parse --is-inside-work-tree &>/dev/null || return 1
    # Check if it's dirty
    # then [ $? -eq 1 ] && echo '%F{red}' && return 0
    if [ -n "$(git ls-files --others --exclude-standard)" ]; then
      echo '%F{yellow}'
    else
      echo '%F{cyan}'
    fi
}

# Display information about the current repository
#
repo_information() {
    echo "%F{cyan}${vcs_info_msg_0_%%/.} ${vcs_info_msg_1_} ${vcs_info_msg_2_}"
}

# Displays the exec time of the last command if set threshold was exceeded
#
cmd_exec_time() {
    local stop=`date +%s`
    local start=${cmd_timestamp:-$stop}
    let local elapsed=$stop-$start
    [ $elapsed -gt 5 ] && echo "%F{yellow}${elapsed}s%f"
}

# Get the intial timestamp for cmd_exec_time
#
preexec() {
    cmd_timestamp=`date +%s`
}

fishy_collapsed_wd() {
  pwd | perl -pe "
      BEGIN {
        binmode STDIN,  ':encoding(UTF-8)';
        binmode STDOUT, ':encoding(UTF-8)';
      }; s|^$HOME|~|g; s|/([^/])[^/]*(?=/)|/\$1|g
  "
}

default_prompt='%(?.%F{magenta}.%F{red}%?)❯%f '
# Output additional information about paths, repos and exec time
#
precmd() {
    vcs_info # Get version control info before we start outputting stuff
    if [[ -n $PYENV_SHELL ]]; then
      local version
      version=$(pyenv version-name)
      if [[ $version = system ]]; then
        PROMPT="$default_prompt"
      else
        PROMPT="%F{green}py:%f%F{cyan}$version%f $default_prompt"
      fi
    else
      PROMPT="$default_prompt"
    fi

    line="%F{8}${SSH_TTY:+%n@%m}%f:%F{blue}$(fishy_collapsed_wd)%f $(repo_information) $(cmd_exec_time)"
    cmd_timestamp=99999999999

    if [[ -n $DESK_NAME ]]; then
      line="[[%F{yellow}$DESK_NAME%f]] $line"
    fi

    print -P $line
}

# Define prompts
#
PROMPT="$default_prompt" # Display a red prompt char on failure
RPROMPT=""    # Display username if connected via SSH

# ------------------------------------------------------------------------------
#
# List of vcs_info format strings:
#
# %b => current branch
# %a => current action (rebase/merge)
# %s => current version control system
# %r => name of the root directory of the repository
# %S => current path relative to the repository root directory
# %m => in case of Git, show information about stashes
# %u => show unstaged changes in the repository
# %c => show staged changes in the repository
#
# List of prompt format strings:
#
# prompt:
# %F => color dict
# %f => reset color
# %~ => current path
# %* => time
# %n => username
# %m => shortname host
# %(?..) => prompt conditional - %(condition.true.false)
#
# ------------------------------------------------------------------------------
