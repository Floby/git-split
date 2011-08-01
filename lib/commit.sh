# commit lib

# get the sha1 id of a commit from any tree-ish
# usage: deref_commit <tree-ish>
deref_commit() {
    commit=$1
    git show  $commit | head -1 | sed 's/^commit //'
}

# get the sha1 of a subtree in a commit
# usage: get_subpath_tree <commit> <path>
get_subpath_tree() {
    commit=$1
    path=$2
    tree=$(git cat-file -p $commit | head -1 | sed 's/^tree //')
    find_subtree $tree $path
}

# list commits that affect a given subpath from a given branch
# usage: list_useful_commits <subpath> <branch>
#       subpath:    the subpath for which you want to scan changes
#       branch:     not used yet
list_useful_commits() {
    subpath=$1
    branch=HEAD

    # intialize these
    current_tree=`get_subpath_tree $branch`
    previous_commit=`deref_commit $branch`
    for commit in `git rev-list $branch` ; do
        subtree=`get_subpath_tree $commit $subpath`

        if [ "$current_tree" = "$subtree" ] ; then
            previous_commit=$commit
            continue
        fi
        current_tree=$subtree

        log keeping commit $previous_commit
        git cat-file -p $previous_commit | sed -n '/^$/,$p' | tail -n +2 1>&2
        echo $previous_commit
        log

        previous_commit=$commit
    done
}

get_parent_commits() {
    commit=$1
    [ "commit" = `object_type $commit` ] || die 20 "parameter is not a commit"
    git cat-file -p $commit | sed '/^author/,$d' | grep parent | awk '{print $2}'
}

get_commit_tree() {
    commit=$1
    [ "commit" = `object_type $commit` ] || die 20 "parameter is not a commit"
    git cat-file -p $commit | head -1 | awk '{print $2}' 
}


TRANSLATED_COMMITS=`mktemp`

# copy a commit to another repository while changing its base tree
# and parent commits
# usage: translate_commit <commit> <repository> [<subpath>]
translate_commit() {
    commit=$1
    repository=$2
    subpath=$3

    [ -z "$repository" ] && die 10 "you must specify a repository in which to copy commit $commit"
    
    tree=`get_commit_tree $commit`

    if [ ! -z "$subpath" ]; then
        tree=`find_subtree $tree $subpath`
    fi

    [ -z "$tree" ] && return

    # if this commit has already been translated
    # then give it to them
    translated=`grep $commit $TRANSLATED_COMMITS | awk '{print $2}'`
    if [ ! -z "$translated" ]; then
        return
    fi
    
    # here we may not have to translate this commit if it doesn't
    # bring any change to the watched subtree
    # however if this is a merge (more than one parent) we keep it
    # to maintain branch coherence
    if [ 1 -eq `get_parent_commits $commit | wc -w` ]; then
        # there is only one parent commit
        parent=`get_parent_commits $commit`

        # this next line is ugly but I was out of var name ideas
        parent_subtree=$(find_subtree $(get_commit_tree $parent) $subpath)
        if [ "$parent_subtree" = "$tree" ]; then
            # the parent commit subtree is the same as ours
            # no need to translate this commit
            translate_commit $parent $repository $subpath $tree
        fi
    fi

    # if we got there, we have some copying to do!
    
    # copy the tree to the submodule repository
    copy_tree $tree $repository >/dev/null

    # we construct the body of the new commit step by step
    # we store the current commit body in a temp file
    commit_body=`mktemp`

    echo "tree $tree" > $commit_body # this, we have

    for parent in `get_parent_commits $commit`; do
        translated=`translate_commit $parent $repository $subpath $tree`
        [ -z "$translated" ] && continue
        echo "parent $translated" >> $commit_body
    done

    # copy the rest of the original commit info unchanged (author, committer, description)
    git cat-file -p $commit | sed -n '/^author/,$p' >> $commit_body

    # write this new commit in the sub repository
    translated=`cat $commit_body | ( cd $repository ; git hash-object -w --stdin -t commit )`
    echo $commit $translated >> $TRANSLATED_COMMITS

    echo $translated

    # clean up
    rm $commit_body
}
