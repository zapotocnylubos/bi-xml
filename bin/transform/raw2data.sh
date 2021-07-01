#!/bin/sh

java -jar lib/saxon-he-10.5.jar -o:src/data/countries src/raw/countries src/raw/data.xslt
