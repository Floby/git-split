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
