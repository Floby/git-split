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
