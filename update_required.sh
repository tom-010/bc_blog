[ $(git fetch -q origin master && git log --oneline master...origin/master | wc -l) -gt 0 ]
