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


