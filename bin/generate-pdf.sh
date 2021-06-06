#!/bin/sh

java -jar lib/saxon-he-10.5.jar -o:src/pdf/document.fo src/countries.xml src/pdf.xslt

./lib/fop-2.6/fop/fop -fo src/pdf/document.fo -pdf src/pdf/document.pdf
