git fetch origin
#rm * -rf
git reset --hard origin/master
cd web_viewer/
./scripts/build.sh
kill `ps -ef | grep elixir | grep -v grep | awk '{print $2}'`
nohup ./scripts/prod_run.sh &
