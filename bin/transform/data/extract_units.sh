#!/bin/sh

java -jar lib/saxon-he-10.5.jar -o:src/data/extracted_units src/data/countries src/data/extract_units.xslt
