# BI-XML semestral project

## Project output
HTML output can be found in `src/html` and there openning `index.html` in web browser.

PDF output can be found in `src/pdf/docuemnt.pdf`

## Repository structure
```
.
├── bin
│   ├── generate-html.sh        # Generates HTML
│   ├── generate-pdf.sh         # Generates PDF
│   ├── reduce-dataset.js       # Helper script to manage dataset
│   ├── transform-dataset.js    # Helper script to manage dataset
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
