#!/bin/bash

npm install -gs homebridge-http
npm install -gs homebridge-netatmo
perl -i.bak -pe 's/this.accessory.co2 > 1000/this.accessory.co2 > 2000/' /usr/local/lib/node_modules/homebridge-netatmo/service/weatherstation-co2-homekit.js
npm install -gs homebridge-thermostat
