# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
debian_chroot=$(cat /etc/debian_chroot)
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
;;
*)
;;
esac

# lecture coloré de logs
logview()
{
ccze -A < $1 | less -R
}

# lecture colorÃ©e de logs en directfunction logview()
logtail()
{
tail -f $1 | ccze
}

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
eval "`dircolors -b`"
alias ls='ls -B --color=auto --group-directories-first'
fi

# some more ls aliases
alias ll='ls -lB --group-directories-first'
alias la='ls -AB --group-directories-first'
alias l='ls -CFB --group-directories-first'

# paresse mon ami
alias inst="sudo apt-get install"
alias apt-get="sudo apt-get"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
. /etc/bash_completion
fi
# Completion for alias inst
#

_inst()
{
local cur prev special i

COMPREPLY=()
cur=`_get_cword`
prev=${COMP_WORDS[COMP_CWORD-1]}


case "$prev" in
    -@(c|-config-file))
         _filedir
         return 0
         ;;

    -@(t|-target-release|-default-release))
         COMPREPLY=( $( apt-cache policy | \
                grep "release.o=Debian,a=$cur" | \
                sed -e "s/.*a=\(\w*\).*/\1/" | uniq 2> /dev/null) )
         return 0
         ;;

esac

if [[ "$cur" == -* ]]; then

    COMPREPLY=( $( compgen -W '-d -f -h -v -m -q -s -y \
            -u -t -b -c -o --download-only --fix-broken \
            --help --version --ignore-missing \
            --fix-missing --no-download --quiet --simulate \
            --just-print --dry-run --recon --no-act --yes \
            --assume-yes --show-upgraded --only-source \
            --compile --build --ignore-hold \
            --target-release --no-upgrade --force-yes \
            --print-uris --purge --reinstall \
            --list-cleanup --default-release \
            --trivial-only --no-remove --diff-only \
            --tar-only --config-file --option --auto-remove' -- $cur ) )
else
    COMPREPLY=( $( apt-cache pkgnames $cur 2> /dev/null ) )

fi


    return 0
} &&
complete -F _inst $filenames inst

# a partir de la c'est des rajouts perso

# affichage sympathique de la ligne de commande
PS1="[\t] \[\e[01;31m\]\u@\h\[\e[00m\]:\[\e[01;33m\]\w\[\e[00m\]\$ "

# pour définir l'éditeur par défaut comme étant vim
export EDITOR=vim

# pour ceux qui sont frileux (demande confirmation de chaque suppression ou ÃƒÂ©crasement) :
alias cp='cp -ip' # -p : conserve les dates, droits lors de la copie
alias mv='mv -i'
alias rm='rm -i'

## Mettre à  jour sa distrib en quelques secondes (pour une SID assez marrant)
alias maj="sudo apt-get update && sudo apt-get upgrade && sudo apt-get autoclean && sudo apt-get clean && sudo apt-get autoremove" 

# éditer les fichiers vimrc et bashrc facilement
alias vimrc="vim ~/.vimrc"
alias bashrc="vim ~/.bashrc"

# quitter le terminal
alias q="exit"
alias :q="exit"

# rechercher facilement dans la cache d'apt
alias search="apt-cache search"

#Cree le repertoire et va dedans
function mkcd()
{
mkdir $1 && cd $1
}

# ouvrir le répertoire courant
alias s="cd .."

host="Little Marcel"

echo -e "Hello $host, My dear beauty...\n"
echo -e "Il reste `df -h | grep /dev/sda1 | head -n 1 | awk '{print $4}'`o d'espace libre dans ta home\n"


# fait un ls juste derrière un cd
cd() {
if [ "$1" ]
then builtin cd "$1" && ls
else builtin cd && ls
fi
}


# corrige les erreurs dans un "cd"
shopt -s cdspell
shopt -s histverify


export DEBFULLNAME="Mahewin Magnolia"
export DEBEMAIL="datshia966@gmail.com"

#ID de ma clé GPG
#export GPGKEY="1DE6E434"

alias ttop="top -b | head -n 8 | tail -n 1 | awk '{print \$9 \" \" \$12}'"
alias ziziklast="ls --full-time /media/sda2/Zizik/ | awk '{print \$6\" \"\$9\" \"\$10\" \"\$11\" \"\$12\" \"\$13\" \"\$14\" \"\$15}' | sort | tail | cut -b 9- | sed s/^0/\ / | sed s/^/\ /"
set -o vi

LS_COLORS='no=00:fi=00:di=01;37:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.svgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:';
export LS_COLORS
#alias servez-vous
alias grep="grep -i"
alias ack-grep="ack-grep -i"
alias sources="sudo vim /etc/apt/sources.list"

alias maj_wmfs="cd wmfs && git pull && cd build && sudo make install && cd $HOME && wmfs -c reload"
alias perldoc-fr="perldoc -L FR"

export PATH="$PATH:/var/lib/gems/1.8/bin/"
