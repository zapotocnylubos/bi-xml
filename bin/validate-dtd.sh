#!/bin/sh

if xmllint --noout --dtdvalid src/countries.dtd src/countries.xml; then
  echo DTD validation was successful
else
  echo DTD validation was not successful
  exit 1
fi
