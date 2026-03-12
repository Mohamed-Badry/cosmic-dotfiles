# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;; 
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=erasedups:ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=500
export HISTFILESIZE=10000
PROMPT_COMMAND='history -a'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi




# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^	*[0-9]	*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
. "$HOME/.cargo/env"

# pnpm
export PNPM_HOME="/home/crim/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# --- User Added Configurations ---

# Aliases for Rust tools
# ls -> eza
alias ls='eza --icons'
alias ll='eza -alF --icons'
alias la='eza -a --icons'
alias l='eza -F --icons'
alias tree='eza --tree --icons'


# --- Auto-completion ---
# Source user-defined completions
if [ -d "$HOME/.local/share/bash-completion/completions" ]; then
  for file in "$HOME/.local/share/bash-completion/completions"/*; do
    [ -f "$file" ] && source "$file"
  done
fi

# Make 'ls' tab-completion use eza's completion function
complete -F _eza ls

# --- FZF Key Bindings ---
[ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && source /usr/share/doc/fzf/examples/key-bindings.bash
#######################################################
# SOURCED ALIAS'S AND SCRIPTS
#######################################################

# EXPORTS
export PATH="$HOME/bin:$PATH"
export PIP_DEFAULT_TIMEOUT=300
export UV_HTTP_TIMEOUT=2000
export EDITOR=hx
export VISUAL=hx

# MISC
# Disable the bell
bind "set bell-style visible" 2>/dev/null
# Ignore case on auto-completion
bind "set completion-ignore-case on" 2>/dev/null
# Show auto-completion list automatically
bind "set show-all-if-ambiguous On" 2>/dev/null

# Custom directories
export start_dir="/media/crim/Productivity/Programming"
export android_dir="/storage/emulated/0/Linux"

# JAVA ALIASES (Keeping these as they seem specific to your workflow)
javacp () {
	export CLASSPATH="$(find . -wholename '**/*.jar' -printf '%p;' | sed 's/\\.///g')"
}
alias javac='javac -cp $CLASSPATH'
alias java='java -cp $CLASSPATH'

#######################################################
# ALIASES
#######################################################

# Navigation
alias web='cd /var/www/html'
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias bd='cd "$OLDPWD"'

# Enhanced 'cd' that lists files after entering
cd () {
	if [ -n "$1" ]; then
		builtin cd "$@" && eza --icons
	else
		builtin cd $start_dir && eza --icons
	fi
}

# Helpers
alias edit='hx'
alias shx='sudo hx'
alias ebrc='edit ~/.bashrc'
alias brighten='/home/crim/.local/bin/increase_webcam_exposure.sh'
alias checkcommand="type -t"
alias pwdtail="pwd|awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'"
alias zj='zellij'

# Safety & Verbosity
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -iv'
alias mkdir='mkdir -p'
alias ps='ps auxf'
alias ping='ping -c 10'
alias less='less -R'
alias cls='clear'

# System
alias apt-get='sudo apt-get'
alias multitail='multitail --no-repeat -c'
alias freshclam='sudo freshclam'
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'
alias uu='sudo apt update && sudo apt upgrade'


# LS -> EZA (Modern replacements)
# Note: 'ls', 'll', 'la', 'l' are already defined in your bashrc block above
alias lx='eza -lbF --icons --sort=ext'       # sort by extension
alias lk='eza -lbF --icons --sort=size'      # sort by size
alias lc='eza -lbF --icons --sort=modified'  # sort by change time
alias lu='eza -lbF --icons --sort=accessed'  # sort by access time
alias lr='eza -R --icons'                    # recursive ls
alias lt='eza -T --icons'  					 # tree ls
alias lm='eza -alh --icons | more'           # pipe through 'more'
alias lw='eza -x --icons'                    # wide listing format
alias labc='eza -a --icons --sort=name'      # alphabetical sort
alias lf="eza -F --icons | grep -v /"        # files only
alias ldir="eza -D --icons"                  # directories only

# Chmod
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

# Search & Process
alias h="history | grep "
alias p="ps aux | grep "
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# Archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

# Extract function
extract () {
	for archive in $*
	do
		if [ -f $archive ] ; then
			case $archive in
				*.tar.bz2)   tar xvjf $archive    ;; 
				*.tar.gz)    tar xvzf $archive    ;; 
				*.bz2)       bunzip2 $archive     ;; 
				*.rar)       rar x $archive       ;; 
				*.gz)        gunzip $archive      ;; 
				*.tar)       tar xvf $archive     ;; 
				*.tbz2)      tar xvjf $archive    ;; 
				*.tgz)       tar xvzf $archive    ;; 
				*.zip)       unzip $archive       ;; 
				*.Z)         uncompress $archive  ;; 
				*.7z)        7z x $archive        ;; 
				*)           echo "don't know how to extract '$archive'..." ;; 
			esac
	else
		echo "'$archive' is not a valid file!"
	fi
	done
}

# Search text in files (Adapted for Ripgrep)
ftext () {
    # Uses ripgrep if available
    rg -i -n --color=always "$1" . | less -r
}

# Detach app from terminal session (mostly for mpv)
detach() {
    setsid -f "$@" > /dev/null 2>&1
}

# Quick Copy/Move/Mkdir & Go
cpg () {
	if [ -d "$2" ];then
		cp $1 $2 && cd $2
	else
		cp $1 $2
	fi
}
mvg () {
	if [ -d "$2" ];then
		mv $1 $2 && cd $2
	else
		mv $1 $2
	fi
}
mkdirg () {
	mkdir -p $1
	cd $1
}

# Go up N directories
up () {
	local d=""
	limit=$1
	for ((i=1 ; i <= limit ; i++))
		do
			d=$d/..
		done
	d=$(echo $d | sed 's/^\///')
	if [ -z "$d" ]; then
		d=..
	fi
	cd $d
}

# Trim helper
trim() {
	local var=$@
	var="${var#${var%%[![:space:]]*}}"
	var="${var%${var##*[![:space:]]}}"
	echo -n "$var"
}

# Backup function
backup_home() {
	BACKUPDIR=/media/crim/Productivity/Programming/dotfiles/Cosmic
	rsync -aP --delete --exclude-from=/home/$USER/.rsync-homedir-local.txt /home/$USER/ $BACKUPDIR/
}

# Bat (Cat replacement)
alias cat='bat --no-pager'

# Color Man Pages (Using Bat if possible, or less termcap)
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# --- Starship Prompt ---
eval "$(starship init bash)"

# --- Zoxide (Smart Jump) ---
# Initialize zoxide
eval "$(zoxide init bash)"

# Override 'z' to list files after jumping (matches your 'cd' workflow)
z() {
    __zoxide_z "$@" && eza --icons
}

# Override 'zi' (interactive) to list files after jumping
zi() {
    __zoxide_zi "$@" && eza --icons
}

source $HOME/.uv-global/bin/activate

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
eval "$(_MARIMO_COMPLETE=bash_source marimo)"



# ytfzf aliases
alias ym="ytfzf -m -t"
alias ym-sub="ytfzf -m -t -c S"
alias ym-hist="ytfzf -m -t -c H"

alias yt="ytfzf -t"
alias yt-sub="ytfzf -t -c S"
alias yt-hist="ytfzf -t -c H"


# if app is vscode use the vscode-starship config
# if [[ "$TERM_PROGRAM" == "vscode" ]]; then
#     export STARSHIP_CONFIG=~/.config/starship-vscode.toml
#     eval "$(starship init bash)"
# fi

export PATH="/home/crim/.pixi/bin:$PATH"
eval "$(pixi completion --shell bash)"
