
# You should have received the contents of zsh-hl/ and zsh-as/ directory with this file.
# These come from https://github.com/zsh-users. Inspired by Leah Neukirchen's dotfiles.

setopt NO_BEEP
setopt C_BASES
setopt OCTAL_ZEROES
setopt PRINT_EIGHT_BIT
setopt SH_NULLCMD
setopt AUTO_CONTINUE
setopt NO_BG_NICE
setopt PATH_DIRS
setopt NO_NOMATCH
setopt EXTENDED_GLOB
disable -p '^'
setopt LIST_PACKED
setopt BASH_AUTO_LIST
setopt NO_AUTO_MENU
setopt NO_CORRECT
setopt NO_ALWAYS_LAST_PROMPT
setopt NO_FLOW_CONTROL
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

SAVEHIST=9000
HISTSIZE=9000
HISTFILE=~/.zsh_history

LISTMAX=0
REPORTTIME=60
TIMEFMT="%J  %U user %S system %P cpu %MM memory %*E total"
MAILCHECK=0

# gitpwd - print %~, limited to $NDIR segments, with inline git branch
NDIRS=3
gitpwd() {
    local -a segs splitprefix; local gitprefix branch
    segs=("${(Oas:/:)${(D)PWD}}")
    segs=("${(@)segs/(#b)(?(#c10))??*(?(#c5))/${(j:...:)match}}")

    if gitprefix=$(git rev-parse --show-prefix 2>/dev/null); then
        splitprefix=("${(s:/:)gitprefix}")
        if ! branch=$(git symbolic-ref -q --short HEAD); then
            branch=$(git name-rev --name-only HEAD 2>/dev/null)
            [[ $branch = *\~* ]] || branch+="~0"    # distinguish detached HEAD
        fi
        if (( $#splitprefix > NDIRS )); then
            print -n "${segs[$#splitprefix]}@$branch "
        else
            segs[$#splitprefix]+=@$branch
        fi
    fi

    (( $#segs == NDIRS+1 )) && [[ $segs[-1] == "" ]] && print -n /
    print "${(j:/:)${(@Oa)segs[1,NDIRS]}}"
}

# Execution time start
_exec_time_preexec_hook() {
    _exec_time_start=$(date +%s)
}

# Execution time end
_exec_time_precmd_hook() {
    [[ -z $_exec_time_start ]] && return
    local _exec_time_stop=$(date +%s)
    _exec_time_duration=$(( $_exec_time_stop - $_exec_time_start ))
    unset _exec_time_start
}

displaytime() {
    local T=$1
    local M=$((T/60))
    local S=$((T%60))
    if [[ $M > 0 ]]; then
        printf '%dm %ds' $M $S
    else
        printf '%ds' $S
    fi
}

# window title
_wndtitle_precmd_hook () { print -Pn '\e]0;$(gitpwd)\a' }

autoload -Uz add-zsh-hook
add-zsh-hook preexec _exec_time_preexec_hook
add-zsh-hook precmd _exec_time_precmd_hook
add-zsh-hook precmd _wndtitle_precmd_hook

_paint_exec_time() {
    if [[ $_exec_time_duration -ge 2 ]]; then
        print -n $(displaytime $_exec_time_duration)
        _exec_time_duration=0
        _exec_time_start=0
    fi
}


autoload -Uz compinit
compinit
# paste to termbin
alias termbin='nc termbin.com 9999'
# repeat N times
alias repn="perl -e 'print((shift@ARGV)x(shift@ARGV));'"
# paste to 0x0
0x0() { curl -F "file=@${1:--}" https://0x0.st/ }
# find in header files
cppgrep() { printf '#include "%s"' "$@[2,-1]" | gcc -E -M -MP -x c++ - | awk -F: '/:$/ {print $1}' | xe -N0 grep -nP "$1" }
# wrap long lines using backslashes
wrap() { perl -pe 's/.{'$(( ${COLUMNS:-80} - 1))'}/$&\\\n/g' -- "$@" }
# reload zshrc
alias reload='source ~/.zshrc'
# create a 64M ramdisk
alias ramdisk='sudo mount -t tmpfs -o size=64m tmpfs /mnt/ramdisk && cd /mnt/ramdisk'
# muscle memory
alias quit="exit"
# faster navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
# colors!
_cls() { if [ -t 1 ]; then /bin/ls --color $*; else /bin/ls $*; fi }
alias l="_cls -lF"
alias la="_cls -lAF"
alias lsd="_cls -lF | grep --color=never '^d'"
alias ls="_cls"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
# random things
yell() {
    SPEW="$*" \
    xterm +sb -geometry `echo -n "$*"|wc -c`x1+100+100 -fs 19.5 -fa "Mx437 IBM BIOS\-2y" \
    -e sh -c 'echo -n "[?9h$SPEW"
                tput civis
                stty -echo -icanon min 1 time 0
                dd bs=1 count=1 >/dev/null 2>&1'

}
mkd() { mkdir -p "$1" && cd "$1" }
exe() { chmod a+x "$1" }
alias md='mkdir'
alias vps=' // -- // '
alias unixlgbt=' // -- // '
alias poweroff='/sbin/shutdown -P now'
alias reboot='/sbin/shutdown -r now'
alias dpi='xdpyinfo | grep -B 2 resolution'
alias fontcalc="perl -e '\$_=\`xdpyinfo|grep dots\`;s/.*?([0-9]+)x.*/\$1/;print((72*shift @ARGV)/\$_."\n");'"
alias tmux='tmux -2'
# set the shell
SHELL=/usr/bin/zsh
# ctrl+s => accept autosuggestion
bindkey "^S" forward-char
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -e $HOME/.zsh/.zsh ]; then
  . ~/.zsh/.zsh
fi
export LD_LIBRARY_PATH=$PREFIX/usr/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=$PREFIX/usr/lib/pkgconfig:$PKG_CONFIG_PATH

