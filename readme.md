# git-split

`git-split` is a program that splits apart a sub directory of a git project
into its own git repository. Keeping its history and adding itself to
`.gitmodules`

## but why?

I found several other scripts doing more or less the same thing but:
    
1. none really matched my needs
2. they do too many things, so the doc is too complex for such a simple task
3. everybody seems to have fun with it, so why the hell wouldn't I?

The goal of this implementation is only to create a git repository in
a directory of an existing git project. Porting all relevant commits and
branches. I'm all for micro-utilities. So here is one.

Also, I never did any serious project in bash (only regular hacking here and there)
so this was an occasion for me to test my bash-fu

## Work in progress

/!\ Warning /!\

This is very much a work in progress. Do not expect anything to work
as expected. You've been warned.

## License - The MIT License

Copyright (c) 2011 Florent Jaby

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
