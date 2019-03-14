n=$(git log --pretty=format:'%H||%s' | grep '||working' | wc -l)
git reset --soft HEAD~$n && git commit

