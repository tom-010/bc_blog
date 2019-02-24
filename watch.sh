# do not observe .git directory (included in all directories)
# because it changes on commit and revert which causes 
# an inifinity loop
while true
do
	./tcr.sh
    inotifywait -r -e modify ./lib ./test
done
