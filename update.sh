git fetch origin
rm * -rf
git reset --hard origin/master
cd web_viewer/
mix deps.get
kill `ps -ef | grep elixir | grep -v grep | awk '{print $2}'`
nohup ./run.sh &
