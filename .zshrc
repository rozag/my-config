export ME=/Users/alexey
export ZSH=$ME/.oh-my-zsh
export LANG=en_US.UTF-8
export EDITOR="vim"
export ZSH_THEME="agnoster"

export PATH=$PATH:$ME/anaconda3/bin
export PATH=$PATH:$ME/Library/Android/sdk/platform-tools

# Go related stuff
export GOPATH=$HOME/workspace/go
export PATH=$PATH:$(go env GOPATH)/bin

# Python related stuff
export PATH="/Users/alexey/anaconda3/bin:$PATH"
export PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH="/usr/local/lib/python3.6/site-packages:$PATH"

# PostgreSQL - Postgress.app
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# Gradle completion
fpath=($HOME/.zsh/gradle-completion $fpath)

# Android Device Monitor stuff
export ANDROID_HVPROTO=ddm

plugins=(git)

source $ZSH/oh-my-zsh.sh

export ENABLE_CORRECTION="true"

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias advice="advice | cowsay"
alias :q="exit"
alias tarcd='tar -czf "../${PWD##*/}.tar.gz" .'
alias wtr='curl wttr.in/moscow'
alias kakava='python3 /Users/alexey/workspace/kakava/kakava'
alias v='vim'
alias wuzz='"$GOPATH/bin/wuzz"'
alias gmnf="git merge --no-ff"
alias gd="git icdiff"
alias gdf="git diff-tree --no-commit-id --name-only -r"
alias gcob="git checkout -b"
alias glb="git shortlog -sn"

# ctags macOS fix
alias ctags="`brew --prefix`/bin/ctags"

# Android development bash aliases (https://medium.com/@jonfhancock/bash-your-way-to-better-android-development-1169bc3e0424#.ezlrvqk5w)
alias startintent="adb devices | tail -n +2 | cut -sf 1 | xargs -I X adb -s X shell am start $1"
alias apkinstall="adb devices | tail -n +2 | cut -sf 1 | xargs -I X adb -s X install -r $1"
alias rmapp="adb devices | tail -n +2 | cut -sf 1 | xargs -I X adb -s X uninstall $1"
alias clearapp="adb devices | tail -n +2 | cut -sf 1 | xargs -I X adb -s X shell pm clear $1"
alias wifiadb='adb start-server && \
    sleep 3 && \
    adb tcpip 5555 && \
    sleep 3 && \
    adb shell ip -f inet addr show wlan0 | \
    tail -n +2 | \
    head -n 1 | \
    cut -d '/' -f 1 | \
    xargs -n1 | \
    tail -n +2 | \
    awk '"'"'{print "connect", $1":5555"}'"'"' | \
    xargs adb && \
    adb devices'
alias devs="adb devices"
alias w='./gradlew --daemon'
alias wo='w --offline'

# Android reverse engineering aliases
export AHACK=$ME/Library/Android/hack
export ANDROID_HOME=$ME/Library/Android/sdk

alias apktool='java -jar $AHACK/apktool_2.2.2.jar'
alias jadx-gui='$AHACK/jadx-0.6.1/bin/jadx-gui'
alias baksmali='java -jar $AHACK/baksmali-2.1.3.jar'
alias sign='java -jar $AHACK/sign.jar'
alias droidc='javac -classpath $ANDROID_HOME/platforms/android-25/android.jar'
alias dx='$ANDROID_HOME/build-tools/25.0.2/dx'
alias dex2jar='$AHACK/dex2jar-2.0/d2j-dex2jar.sh'
alias backdoor-apk='$AHACK/backdoor-apk/backdoor-apk.sh'

# Pull database from device
function pulldevdb {
   adb exec-out run-as $1 cat databases/$2 > $2
}

### BEGIN UNALIAS GIT PLUGIN ###
unalias glg
unalias glgg
unalias glgga
unalias glgm
unalias glgp
unalias glo
unalias glog
unalias gloga
unalias glol
unalias gunwip
### END UNALIAS GIT PLUGIN ###

### BEGIN MARKS ###
export MARKPATH=$HOME/.marks
function jump { 
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark { 
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark { 
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/ -/g' && echo
}
function _completemarks {
    reply=($(ls $MARKPATH))
}

compctl -K _completemarks jump
compctl -K _completemarks unmark

alias jm="jump"
### END MARKS ###

# Short name to react-native init blah-blah...
function rninit {
    if [ -z ${rndir+x} ]; then 
        echo "rndir is unset"; 
    else 
        echo "rndir is set to '$rndir'"; 
    fi
    if [ -z ${rnname+x} ]; then 
        echo "rnname is unset"; 
    else 
        echo "rnname is set to '$rnname'"; 
    fi
    md $rndir
    cd $rndir
    react-native init $rnname
    mv $rnname/* ../$rndir
    mv $rnname/.* ../$rndir
    rm -r $rnname
    ls -la
    unset $rndir
    unset $rnname
}

# logbook function - https://routley.io/tech/2017/11/23/logbook.html
function lb() {
    today=$(date '+%Y-%m-%d')
    logbook_name=$today.md
    logbook_path=~/logbook/$logbook_name
    if [ ! -f $logbook_path ]; then
        echo -e "# Logbook $today\n\n" > $logbook_path
        echo -e "## How to use it?\n" >> $logbook_path
        echo -e "1. Consider the problem you’re attempting to solve" >> $logbook_path
        echo -e "2. Describe your method for solving it" >> $logbook_path
        echo -e "3. Describe the process of carrying out the method" >> $logbook_path
        echo -e "4. Record what happened, and ask how it could be improved" >> $logbook_path
        echo -e "\n\n" >> $logbook_path
    fi
    if [ "$1" = "vim" ]; then
        vim $logbook_path
    fi
}

# Print great advice
advice
