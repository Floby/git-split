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
        git cat-file -p $previous_commit | sed -n '/^$/,$p' | tail -n +2
        echo $previous_commit >> $commit_list
        log

        previous_commit=$commit
    done
}
