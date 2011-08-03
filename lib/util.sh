# quit the program with an error message
# usage: die <code> <message>
die() {
    code=1
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        code=$1
        shift
    fi
    log $*
    exit $code
}

# echo on stderr
log() {
    echo $* 1>&2
}

usage() {
    log "usage: git-split <repository> <subpath>"
    log
    log repository is the git repository in which you\'ll operate
    log subpath is the subdirectory you want to split apart as a submodule
}

die_usage() {
    usage
    die $*
}

is_sha1() {
   [[ "$1" =~ ^[a-f0-9]{40}$ ]] 
   return $?
}

short_sha() {
    sha=$1
    echo $sha | sed -r 's/^(.{6}).*$/\1/'
}


gc() {
    env | grep | GITSPLIT_TMP | xargs rm
}

gc_error() {
    gc
    rm -rf $SUBPATH/.git
}


GREEN="\\033[1;32m"
NORMAL="\\033[0;39m"
RED="\\033[1;31m"
PINK="\\033[1;35m"
BLUE="\\033[1;34m"
WHITE="\\033[0;02m"
LIGHTGRAY="\\033[1;08m"
YELLOW="\\033[1;33m"
CYAN="\\033[1;36m"
