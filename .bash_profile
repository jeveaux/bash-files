# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Make bash check its window size after a process completes
shopt -s checkwinsize

# LS COLORS
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
#export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# ENVIRONMENT WINE2
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Home
export M2_HOME=/Users/jeveaux/Development/apache-maven-2.2.1
export ANT_HOME=/Users/jeveaux/Development/apache-ant-1.7.1
export ANT_OPTS="-Xmx1024m -XX:MaxPermSize=512m -Dsun.lang.ClassLoader.allowArraySyntax=true -XX:CompileCommand=exclude,org/apache/velocity/runtime/directive/Foreach,render"
export MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=512m -Dsun.lang.ClassLoader.allowArraySyntax=true -XX:CompileCommand=exclude,org/apache/velocity/runtime/directive/Foreach,render"

# #######################

export PATH=$JAVA_HOME/bin:$M2_HOME/bin:$ANT_HOME/bin:$PATH

# GIT ALIASES
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit -v'
alias gl='git pull'
alias glm='git pull origin master'
alias gp='git push'
alias gpm='git push origin master'
alias gst='git status'
alias gd='git diff | $GIT_EDITOR -'
alias gmv='git mv'
alias gdc='git svn dcommit'
alias git_count_commits='git shortlog -s -n --all'

# MORE ALIASES
alias ..="cd .."
alias la="ls -lah"
alias pa="ps aux"
alias flushcache="dscacheutil -flushcache"

# GREP
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;33'
alias grep='grep --color=auto' # Always highlight grep search term

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

## FUNCTION BY http://eustaquiorangel.com/posts/591
# First parameter is a bash printf formatting string
# From second till fifth parameter, rvm-prompt format parameters
__ruby_ps1 () {
   if [ ! -f ./Rakefile ] &&
      [ "$(find -maxdepth 1 -name '*.rb' | head -n1)" == "" ]; then
      exit 1
   fi
   if [ -f ~/.rvm/bin/rvm-prompt ]; then
      rst=$(~/.rvm/bin/rvm-prompt $2 $3 $4 $5)
   fi
   if [ -z "$rst" ]; then
      rst=$(ruby -v | cut -f2 -d' ')
   fi
   fmt="%s"
   if [ -n "$1" ]; then
      fmt="$1"
   fi
   if [ -n "$rst" ]; then
      printf "$fmt" "${rst}"
   fi
}

# 30m - Black
# 31m - Red
# 32m - Green
# 33m - Yellow
# 34m - Blue
# 35m - Purple
# 36m - Cyan
# 37m - White
# Everything else is green...
# 0 - Normal
# 1 - Bold
# 2 - 
function prompt {
	local BLACK="\[\033[0;30m\]"
	local RED="\[\033[0;31m\]"
	local GREEN="\[\033[0;32m\]"
	local YELLOW="\[\033[0;33m\]"
	local BLUE="\[\033[0;34m\]"
	local PURPLE="\[\033[0;35m\]"
	local CYAN="\[\033[0;36m\]"
	local WHITE="\[\033[0;37m\]"
	local WHITEBOLD="\[\033[1;37m\]"
export PS1="${WHITE}\u${RED}@${PURPLE}\h ${CYAN}\w${WHITE}\$(parse_git_branch) ${YELLOW}$ \[\e[m\]\[\e[m\]"
}
prompt

# WELCOME MESSAGE
echo -e ""
echo -ne "Today is "; date
echo -e ""; cal;
echo -ne "Up time: ";uptime | awk /'up/ {print $3,$4}'
echo "";


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

