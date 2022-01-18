# List of common aliases
alias e="nvim"
alias vim="nvim"
alias rm="rm -i"
alias update="sudo apt update && sudo apt upgrade"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Archive extractor function
ex() {
    if [ -f $1 ]; then
        case $1 in
            (*.tar.bz2) tar xjf $1 ;;
            (*.tar.gz) tar xzf $1 ;;
            (*.rar) unrar $1 ;;
            (*.gz) gunzip $1 ;;
            (*.tar.bz2) tar xjf $1 ;;
            (*.tar) tar xf $1 ;;
            (*.tgz) tar xzf $1 ;;
            (*.zip) unzip $1 ;;
            (*.Z) uncompress $1 ;;
            (*.7z) 7z x $1 ;;
            (*) echo "'$1' could not be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
