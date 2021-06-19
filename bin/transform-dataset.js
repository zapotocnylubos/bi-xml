'use strict';

const fs = require('fs'),
    xml2js = require('../lib/xml2js');     // npm install -g xml2js && npm link xml2js

const xmlbuilder = new xml2js.Builder({
    xmldec: {
        version: '1.0',
        encoding: 'UTF-8',
        standalone: null
    }
});

const areas = ['czechia', 'italy', 'greece', 'egypt'];
const input_filename = 'data/factbook_' + areas.join('_') + '.json';

const data = JSON.parse(fs.readFileSync(input_filename));

areas.forEach(function (area) {
    const {
        name, introduction,
        geography, government, economy,
        energy, communications, military_and_security,
        transnational_issues
    } = data.countries[area].data;

    // omit age_structure and sex_ratio in final XML document
    const {age_structure, sex_ratio, ...people} = data.countries[area].data.people;

    // omit air_transport in final XML document
    const {air_transport, ...transportation} = data.countries[area].data.transportation;

    const xml_object = {
        country: {
            $: {
                id: area
            },
            name,
            introduction,
            geography,
            people,
            government,
            economy,
            energy,
            communications,
            transportation,
            military_and_security,
            transnational_issues
        }
    };

    const xml = xmlbuilder.buildObject(xml_object);

    const output_filename = 'src/countries/' + area + '.xml';
    fs.writeFileSync(output_filename, xml);
});
