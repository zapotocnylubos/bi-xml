'use strict';

const fs = require('fs');

const data = JSON.parse(fs.readFileSync('data/factbook.json'));

const areas = ['czechia', 'italy', 'greece', 'egypt'];

let output = {
    countries: areas.reduce(function (countries, area) {
        countries[area] = data.countries[area];
        return countries
    }, {}) // Pick only pre-defined countries
};

const output_filename = 'data/factbook_' + areas.join('_') + '.json';
const output_data = JSON.stringify(output, null, '  ');

fs.writeFileSync(output_filename, output_data); // Save reduced dataset to file
