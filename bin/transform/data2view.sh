#!/bin/sh

java -jar lib/saxon-he-10.5.jar -o:src/view/sections src/data/countries src/data/view.xslt
