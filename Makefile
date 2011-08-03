
all:

# well the only thing you'd want to do is install since it's all bash
install:
	echo installing git-split in /usr/local/bin
	ln -f -s bin/split /usr/local/bin/git-split
