#!/bin/bash

e=0

for dir in * ; do
  if [ -d $dir ] ; then 
    cd $dir
    echo ===============================================
    echo "Testing $dir"
    echo ===============================================
    mix test || e=1
    cd ..
  fi
done

exit $e
