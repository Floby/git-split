# blob lib

copy_blob() {
    blob=$1
    repository=$2
    [ -z "$repository" ] && die 10 "you must specify a repository in which to copy blob $blob"

    git cat-file -p $blob | ( cd $repository ; git hash-object -w --stdin )
}
