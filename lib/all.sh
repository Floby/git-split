for file in `ls $SPLIT_LIB_DIR | grep -v all.sh` ; do
    source $SPLIT_LIB_DIR/$file
done


object_exists() {
    git cat-file -e $1
    return $?
}

object_type() {
    object_exists $1 || die 3 "object does not exist $1"
    git cat-file -t $1
    return $?
}
