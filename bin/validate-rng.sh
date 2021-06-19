#!/bin/sh

if java -jar lib/jing-trang/build/jing.jar src/countries.rng src/countries.xml; then
  echo Relax NG validation was successful
else
  echo Relax NG validation was not successful
  exit 1
fi
