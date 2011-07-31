# tree lib

# find the tree of a subpath of the specified tree
# usage: find_subtree <tree> <path>
find_subtree() {
    tree=$1
    next=$(echo $2 | sed 's#/# #' | awk '{print $1}')
    left=$(echo $2 | sed 's#/# #' | awk '{print $2}')
    
    nexttree=$(git cat-file -p $tree | grep "$next" | grep tree | awk '{print $3}')

    if test -n "$left" ; then
        find_subtree $nexttree $left 
        return $?
    fi

    echo $nexttree
}

# copy a tree with its subtrees and blobs to another git repository
# usage: copy_tree <tree> <repository>
copy_tree() {
    tree=$1
    repository=$2
    [ -z "$repository" ] && die 10 "you must specify a repository in which to copy tree $tree"

    # for the blobs in this tree, copy them over
    for blob in `git cat-file -p $tree | grep blob | awk '{ print $3 }'` ; do
        copy_blob $blob $repository
    done
    
    # now copy subtrees recursively
    for subtree in `git cat-file -p $tree | grep tree | awk '{ print $3 }'` ; do
        copy_tree $subtree $repository
    done

    # copy this very tree
    git cat-file tree $tree | ( cd $repository ; git hash-object -w --stdin -t tree )
}
