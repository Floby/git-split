# git-split

`git-split` is a program that splits apart a sub directory of a git project
into its own git repository. Keeping its history and adding itself to
`.gitmodules`

## but why?

I found several other scripts doing more or less the same thing but:
    
1. none really matched my needs
2. they do too many things, so the doc is too complex for such a simple task
3. everybody seems to have fun with it, so why the hell wouldn't I?

The goal of this implementation is to only to create a git repository in
a directory of an existing git project. Porting all relevant commits and
branches. I'm all for micro-utilities. So here is one.

Also, I never did any serious project in bash (only regular hacking here and there)
so this was an occasion for me to test my bash-fu

## Work in progress

/!\ Warning /!\

This is very much a work in progress. Do not expect anything to work
as expected. You've been warned.

