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
alias sr='screen -dRR'
alias tm='if [ "`tmux ls`" != "" ]; then tmux a; else tmux new-session \; source-file ~/.tmux.startup; fi'
alias sd='screen -d'
alias isrv='/home/swirhen/sh/ircservice.sh'
alias tig='/home/swirhen/sh/tigkw.sh'
alias urr='/home/swirhen/sh/urr.sh'
alias tun='/home/swirhen/sh/tunnelserver.sh'
alias hfr='/home/swirhen/sh/httpftpres.sh'
alias mm='/home/swirhen/sh/mounts.sh'
alias um='/home/swirhen/sh/umounts.sh'
alias fm='/home/swirhen/sh/ftpmount.sh'
alias fum='/home/swirhen/sh/uftpmount.sh'
alias mnu='/data/share/movie/sh/mnu.sh'
alias mnu2='/data/share/movie/sh/mnu2.sh'
alias mmpc='/data/share/movie/sh/mmpc.sh'
alias mmpc2='/data/share/movie/sh/mmpc2.sh'
alias mmpc3='/data/share/movie/sh/mmpc3.sh'
alias mbmpc='/data/share/movie/sh/mbmpc.sh'
alias msmpc='/data/share/movie/sh/msmpc.sh'
alias mpc98='/data/share/movie/sh/mpc98.sh'
alias mpc982='/data/share/movie/sh/mpc982.sh'
alias mcp='/data/share/movie/sh/mcp.sh'
alias mre='/data/share/movie/sh/mre.sh'
alias rmm='rm *.torrent;/data/share/movie/sh/mre.sh'
alias m2re='/data/share/movie/sh/m2re.sh'
alias mmv='/data/share/movie/sh/mmv.sh'
alias mfp='/data/share/movie/sh/fpsmp4.sh'
alias 169='/data/share/movie/sh/169mp4.sh'
alias 1692='/data/share/movie/sh/169mp42.sh'
alias 1693='/data/share/movie/sh/169mp43.sh'
alias 169f='/data/share/movie/sh/169f.sh'
alias ae='/data/share/movie/sh/169f.sh'
alias 169f2='/data/share/movie/sh/169f2.sh'
alias ae2='/data/share/movie/sh/169f2.sh'
alias 43f='/data/share/movie/sh/43f.sh'
alias 43='/data/share/movie/sh/43mp4.sh'
alias menc='/data/share/movie/sh/menc.sh'
alias mkr='/data/share/movie/mkvremarge.sh'
alias aqr='/data/share/movie/sh/agqrrelease.sh'
alias aqr2='/data/share/movie/sh/agqrrelease2.sh'
alias ffm='/usr/bin/wine ffmpeg.exe'
alias ffm3='/usr/bin/wine ffmpeg3.exe'
alias m4b='/usr/bin/wine MP4Box.exe'
alias takc='/usr/bin/wine /home/swirhen/takc.exe'
alias tdl='/data/share/movie/sh/tdlstop.sh 38888 &;/usr/bin/wine aria2c.exe --listen-port=38888 --max-upload-limit=200K --seed-ratio=0.01 --seed-time=1 *.torrent'
alias tdl2='/data/share/movie/sh/tdlstop.sh 38889 &;/usr/bin/wine aria2c.exe --listen-port=38889 --max-upload-limit=200K --seed-ratio=0.01 --seed-time=1 *.torrent'
alias tdl3='/data/share/movie/sh/tdlstop.sh 38890 &;/usr/bin/wine aria2c.exe --listen-port=38890 --max-upload-limit=200K --seed-ratio=0.01 --seed-time=1 *.torrent'
alias tdl4='/data/share/movie/sh/tdlstop.sh 38891 &;/usr/bin/wine aria2c.exe --listen-port=38891 --max-upload-limit=200K --seed-ratio=0.01 --seed-time=1 *.torrent'
alias tdl5='/data/share/movie/sh/tdlstop.sh 38892 &;/usr/bin/wine aria2c.exe --listen-port=38892 --max-upload-limit=200K --seed-ratio=0.01 --seed-time=1 *.torrent'
alias rto='rtorrent *.torrent'
alias sos='source /home/swirhen/.zshrc'
alias vimrc='vim /home/swirhen/.zshrc'
alias rms='rm *.torrent;ls'
alias www='w3m -B'
alias ltr='ls -ltr'
alias lrt='ls -lrt'
alias rt='ls -rt'
alias rh='/home/swirhen/sh/rmhead.sh'
alias s2u='convmv -f sjis -t utf8 --notest'
alias dec='convmv --unescape --notest'
alias mcmv='convmv -r -f utf-8 --nfd -t utf8 --nfc --notest'
alias gr='cd /home/swirhen/.gmailreader/;rm draft;gmailreader.py'
alias mt='sudo /etc/init.d/mediatomb restart'
alias zmv='noglob zmv'
alias zget='wget -r -nd --http-user=dankogai --http-passwd=kogaidan --restrict-file-names=nocontrol -l 1'
alias sget='wget --no-check-certificate'
alias gn='geeknote'
alias pb='pythonbrew'
alias crontab="crontab -i"
alias dstat='/usr/bin/python /usr/bin/dstat'
alias ydl='/data/share/movie/sh/youtubedl.sh'
alias tmp='cd /data/share/temp'
alias tmv='/home/swirhen/torrentsearch/moveseed.sh'

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

if [ $TERM = "screen" ]; then
    precmd () {
        screen -X title $(basename `echo $PWD | sed -e "s/ /_/g"`)
    }
    preexec () {
        screen -X title "`echo $1 | cut -d ' ' -f 1`"
    }
fi

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
