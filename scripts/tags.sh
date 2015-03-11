# Create Ctags
cd $WS
#TAGS=~/tools/ctags-5.9~svn20110310/ctags
#$TAGS -R --exclude=sp --exclude=xgs --exclude=asg --exclude=spider --exclude=enduro --exclude=np4 --exclude=ppa --exclude=scratch --exclude=auto_test

#Create CSCOPE Tags
find  $WS                            \
    -path "*/sp/*"      -prune -o    \
    -path "*/xgs/*"     -prune -o    \
    -path "*/asg/*"     -prune -o    \
    -path "*/spider/*"  -prune -o    \
    -path "*/enduro/*"  -prune -o    \
    -path "*/np4/*"     -prune -o    \
    -path "*/ppa/*"     -prune -o    \
    -path "*/auto_test/*" -prune -o  \
    -path "*/scratch/*" -prune -o    \
    -name "*.[ch]" -print >~/cscopedb/cscope.files

gtags -f ~/cscopedb/cscope.files

# -name "*.[ch]" -print >~/cscopedb/cscope.files

#cd ~/cscopedb
#cscope -b -q
