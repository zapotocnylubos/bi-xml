#!/bin/sh

java -jar lib/saxon-he-10.5.jar -o:src/html/index.html src/countries.xml src/html.xslt
