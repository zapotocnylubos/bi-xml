# BI-XML semestral project

## Dataset transformation process

```
data/factbook.json
[  js  ] -> data/factbook_czechia_italy_greece_egypt.json    [bin/reduce-dataset.js     ]
[xml2js]   -> raw/countries/*.xml                            [bin/dataset2raw.js  ]
[ XSLT ]     -> data/countries/*.xml                         [bin/transform/raw2data.sh ]
[ XSLT ]       -> view/sections/*.xml                        [bin/transform/data2view.sh]
[ XSLT ]          -> view/html/index.html                    [bin/generate-html.sh      ]
[ XSLT ]             view/html/countries/*.html
[ XSLT ]          -> view/pdf/document.fo                    [(1/2) bin/generate-pdf.sh ]
[ FOP  ]            -> view/pdf/document.pdf                 [(2/2) bin/generate-pdf.sh ]
```

## Project output
HTML output can be found in `src/html` and there opening `index.html` in web browser.

PDF output can be found in `src/pdf/docuemnt.pdf`

## Repository structure
```
.
├── bin
│   ├── generate-html.sh        # Generates HTML
│   ├── generate-pdf.sh         # Generates PDF
│   ├── reduce-dataset.js       # Helper script to manage dataset
│   ├── dataset2raw.js    # Helper script to manage dataset
│   ├── validate-dtd.sh         # Validates merged XML with DTD
│   └── validate-rng.sh         # Validates merged XML with Relax NG
├── data
│   ├── factbook.json                                # Original dataset
│   ├── factbook_czechia_italy_greece_egypt.json     # Reduced dataset
├── lib                         # Used libraries
│   ├── fop-2.6
│   ├── jing-trang
│   ├── saxon-he-10.5.jar
│   └── xml2js
└── src
    ├── countries               # Separated country datasets
    ├── countries.dtd           # DTD      validation schema
    ├── countries.rng           # Relax NG validation schema
    ├── countries.xml           # Merged all countries data into one XML file
    ├── html                    # HTML generated output
    ├── html.xslt               # HTML transformation 
    ├── pdf                     # PDF    generated output
    └── pdf.xslt                # XML-FO transformation
```

## Validation
### Requirements
- ```xmllint``` installed in `$PATH`

Other libraries are stored directly in repository under `lib/` directory

Running `bin/validate-rng.sh` or `bin/validate-dtd.sh` **MUST** be performed from repository root
> Relative paths are used

## ePub
Not created
