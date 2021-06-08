# users generic .zshrc file for zsh
## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8
export EDITOR=/usr/bin/vim

## Default shell configuration
#
# set prompt
#
autoload colors
colors
case ${UID} in
0)
    PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        #PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
        PROMPT="${PROMPT}"
    ;;
*)
    PROMPT="%{${fg[red]}%}%/%%%{${reset_color}%} "
    PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        #PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
        PROMPT="${PROMPT}"
    ;;
esac
RPROMPT="%T"

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep

setopt nocheckjobs
setopt HIST_IGNORE_SPACE

function chpwd() { ls }

## Keybind configuration
#
# vim like keybind
#
bindkey -v

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

setopt multios

## Completion configuration
#
fpath=(~/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit

## zsh editor
#
autoload zed

autoload zmv

## Prediction configuration
#
#autoload predict-on
#predict-on

## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

case "${OSTYPE}" in
freebsd*|darwin*)
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color"
    ;;
esac

alias la="ls -a"
alias lf="ls -F"

alias du="du -h"
alias df="df -h"

case "${OSTYPE}" in
darwin*)
    alias updateports="sudo port selfupdate; sudo port outdated"
    alias portupgrade="sudo port upgrade installed"
    ;;
freebsd*)
    case ${UID} in
    0)
        updateports() 
        {
            if [ -f /usr/ports/.portsnap.INDEX ]
            then
                portsnap fetch update
            else
                portsnap fetch extract update
            fi
            (cd /usr/ports/; make index)

            portversion -v -l \<
        }
        alias appsupgrade='pkgdb -F && BATCH=YES NO_CHECKSUM=YES portupgrade -a'
        ;;
    esac
    ;;
esac

# swirhensan alias
#set yesterday=`date --date`
#alias cp='ruby /usr/bin/cp.rb'
alias ll='ls -lF'
alias lh='ls -lh'
alias la='ls -A'
alias l='ls -CF'
alias x=exit
alias rf='rm -rf'
alias pse='ps -ef | grep'
alias apti='sudo apt install -y'
alias aptr='sudo apt remove'
alias df='df -h'
alias su='sudo su'
alias mov='cd /data/share/movie'
alias shr='cd /data/share'
alias s0r='find . -type f -size 0 | perl -nle unlink'
alias tm='if [ "`tmux ls`" != "" ]; then tmux a; else tmux new-session \; source-file ~/.tmux.startup; fi'
alias tig='/home/swirhen/sh/tigkw.sh'
alias mnu='python3 /data/share/movie/sh/mnu.py'
alias mmpc='python3 /data/share/movie/sh/mmpc.py'
alias mmmpc='python3 /data/share/movie/sh/mmmpc.py'
alias mpc98='python3 /data/share/movie/sh/mpc98.py'
alias mre='python3 /data/share/movie/sh/mre.py'
alias rmm='rm *.torrent;python3 /data/share/movie/sh/mre.py'
alias mmv='python3 /data/share/movie/sh/mmv.py'
alias 169='/data/share/movie/sh/169mp4.sh'
alias ae='/data/share/movie/sh/169f.sh'
alias mkr='/data/share/movie/mkvremarge.sh'
alias aqr='/data/share/movie/sh/agqrrelease.sh'
alias ffm='/usr/bin/wine ffmpeg.exe'
alias ffm3='/usr/bin/wine ffmpeg3.exe'
#alias tdl='/data/share/movie/sh/tdlstop.sh 38888 &; aria2c --listen-port=38888 --max-upload-limit=200K --seed-ratio=0.01 --seed-time=1 *.torrent'
alias rto='rtorrent *.torrent'
alias sos='source /home/swirhen/.zshrc'
alias vimrc='vim /home/swirhen/.zshrc'
alias rms='rm *.torrent;ls -lrth'
alias www='w3m -B'
alias ltr='ls -ltrh'
alias lrt='ls -lrth'
alias rt='ls -rt'
alias s2u='convmv -f sjis -t utf8 --notest'
alias dec='convmv --unescape --notest'
alias mcmv='convmv -r -f utf-8 --nfd -t utf8 --nfc --notest'
alias zmv='noglob zmv'
alias sget='wget --no-check-certificate'
alias pb='pythonbrew'
alias crontab="crontab -i"
alias ydl='youtube-dl'
alias tmp='cd /data/share/temp'
alias cm='cd /data/share/temp/"THE IDOLM@STER CINDERELLA GIRLS/music"'
alias cl='cd /data/share/temp/"THE IDOLM@STER CINDERELLA GIRLS/livedvd"'
alias mm='cd /data/share/temp/"THE IDOLM@STER MILLION LIVE/music"'
alias ml='cd /data/share/temp/"THE IDOLM@STER MILLION LIVE/livedvd"'
alias sm='cd /data/share/temp/"THE IDOLM@STER Shiny Colors/music"'
alias sl='cd /data/share/temp/"THE IDOLM@STER Shiny Colors/livedvd"'
alias hm='cd /data/share/temp/"hololive IDOL PROJECT/music"'
alias hl='cd /data/share/temp/"hololive IDOL PROJECT/live"'
alias tmv='/home/swirhen/torrentsearch/moveseed.sh'
alias mc='/data/share/movie/sh/nico_search/makecombinesh.sh'
alias cb='/data/share/movie/sh/nico_search/combine.sh'
alias nr='/data/share/movie/sh/nico_search/nicorelease.sh'
alias pip='pip3'
alias rbot='kill `cat /data/share/movie/sh/python-lib/slackbot.pid`; sleep 1; nohup python /data/share/movie/sh/python-lib/slackbot_run.py > /dev/null &'
alias dbot='kill `cat /data/share/movie/sh/python-lib/discordbot.pid`; sleep 1; nohup python /data/share/movie/sh/python-lib/discord_bot.py > /dev/null &'
alias zbot='kill `cat /data/share/movie/sh/python-lib/discordbot_ztb.pid`; sleep 1; nohup python /data/share/movie/sh/python-lib/discord_bot_ztb.py > /dev/null &'
alias gp='git pull'
alias gps='git push'
alias gc='git commit -m'
alias gs='git status'

## terminal configuration
#
unset LSCOLORS
case "${TERM}" in
xterm)
    export TERM=xterm-color
    ;;
kterm)
    export TERM=kterm-color
    # set BackSpace control character
    stty erase
    ;;
cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors \
        'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm*)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors \
        'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
esac

if [ -s ${HOME}/.rvm/scripts/rvm ] ; then source ${HOME}/.rvm/scripts/rvm ; fi

## load user .zshrc configuration file
#
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

#source $HOME/.pythonbrew/etc/bashrc
### Virtualenvwrapper
VIRTUALENVWRAPPER_PYTHON=$HOME/.pythonbrew/pythons/Python-3.4.3/bin/python
if [ -f /home/swirhen/.pythonbrew/pythons/Python-3.4.3/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /home/swirhen/.pythonbrew/pythons/Python-3.4.3/bin/virtualenvwrapper.sh
fi
if [[ -s ~/.nvm/nvm.sh ]];
 then source ~/.nvm/nvm.sh
fi

PATH="/home/swirhen/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/swirhen/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/swirhen/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/swirhen/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/swirhen/perl5"; export PERL_MM_OPT;

#pecoでhistory検索
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# find コマンドの出力結果をpeco する。 ファイルが選ばれたら1つ手前のディレクトリを返す
function pecofindd() {
  if [ $# -eq 0 ]; then
    finded=`find . | peco`
  else
    finded=`find $1 | peco`
  fi
  if [ -f $finded ]; then
    echo $finded | perl -pe 's/\/[^\/]*$/\n/g'
  else
    echo $finded
  fi
}
zle -N pecofindd
bindkey '^f' pecofindd

# cdr
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

function peco-cdr () {
    local selected_dir="$(cdr -l | sed 's/^[0-9]\+ \+//' | peco --prompt="cdr >" --query "$LBUFFER")"
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
}
zle -N peco-cdr
bindkey '^E' peco-cdr
