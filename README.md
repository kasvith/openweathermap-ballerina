# Open Weather Map API for Ballerina

[![Build Status](https://travis-ci.com/kasvith/openweathermap-ballerina.svg?branch=master)](https://travis-ci.com/kasvith/openweathermap-ballerina) ![GitHub](https://img.shields.io/github/license/kasvith/openweathermap-ballerina.svg)

The Open Weather Maps connector allows you to fetch data from Open Weather Maps based on city name, zip, id etc.
It also allows to fetch data over a circle or a box of coordinates.

## Sample

Import the libary from `kasvith/openweathermaps` to your project

```ballerina
import kasvith/openweathermap
```

### Obtain app id from Open Weather Maps

Visit [Open Weather Maps](https://openweathermap.org/api) and Grab a **APPID** by registering.

### Initializing Client

To initialize client after obtaining APPID you need to select language and metrics. They are defaulted to English and Kelvin(for temperature).

```ballerina
openweathermap:OpenWeatherMapClient owmClient =  new({
	appid: "YOUR_APP_ID"
});
```

### Use client to obtain weather of a city by Name
```ballerina
var result = owmClient->getWeatherByCityName("Colombo");
io:println(result);
```

### Use client to obtain weather of a location
```ballerina
var result = owmClient->getWeatherByCityCoordinates({lat: 10, lon: 10});
io:println(result);
```

## Developer Guide

You need Ballerina 0.990.3 for development
