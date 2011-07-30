die() {
    code=""
    [ -z "$1" ] && code=1
    log $*
    exit $1 $code
}

log() {
    echo $* 1>&2
}
