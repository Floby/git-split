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
