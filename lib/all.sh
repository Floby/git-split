for file in `ls $SPLIT_LIB_DIR | grep -v all.sh` ; do
    source $SPLIT_LIB_DIR/$file
done
