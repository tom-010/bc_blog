export ARTICLE_PATH=~/articles
cd web_viewer/
nohup ./scripts/prod_run.sh &
cd ..
cd web_writer/
nohup ./scripts/prod_run.sh &
cd ..
