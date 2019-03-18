#!/bin/bash

e=0

for dir in * ; do
  if [ -d $dir ] ; then 
    cd $dir
    echo ===============================================
    echo "Testing $dir"
    echo ===============================================
    test -e mix.exs && (mix test || e=1)
    cd ..
  fi
done

echo ===============================================
echo "Testing starting and stopping of whole app"
echo ===============================================

./scripts/test_run_stop.sh || e=1

exit $e

