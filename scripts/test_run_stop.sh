RES=0
./run.sh
sleep 5
./scripts/test_system_up.sh && RES=0 || RES=1
./stop.sh
exit $RES
