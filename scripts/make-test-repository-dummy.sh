mkdir -p $1
cd $1
git init
echo readme > readme.txt
git add readme.txt
git commit -m "add readme"
mkdir src
echo "some code" > src/source.src
git add src
git commit -m "started some code"
mkdir lib
echo "foo" > lib/lib.src
git add lib
git commit -m "started lib"
echo "some other things to read" >> readme.txt
git commit -am "updated readme"
echo bar >> lib/lib.src
git commit -am "continue lib"
