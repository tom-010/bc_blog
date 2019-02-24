# || exit 0 is neccacary because otherwise this sripts returns 1 if nothing is there for commit 
# which triggers the revert step, which is without effect (when nothing is to commit, nothing is 
# to revert), but misleading
git commit -am working || exit 0
