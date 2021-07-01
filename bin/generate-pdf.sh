#!/bin/sh

java -jar lib/saxon-he-10.5.jar -o:src/view/pdf/document.fo src/view/sections.xml src/view/pdf.xslt

./lib/fop-2.6/fop/fop -fo src/view/pdf/document.fo -pdf src/view/pdf/document.pdf
