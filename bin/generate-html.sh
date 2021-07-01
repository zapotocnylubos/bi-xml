#!/bin/sh

java -jar lib/saxon-he-10.5.jar -o:src/view/html/index.html src/view/sections.xml src/view/html.xslt
