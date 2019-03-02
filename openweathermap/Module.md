Connects to Open Weather Maps from Ballerina.

# Module Overview

The Open Weather Maps connector allows you to fetch data from Open Weather Maps based on city name, zip, id etc.

It also allows to fetch data over a circle or a box of coordinates.

## Sample

Import the libary from `kasvith/openweathermaps` to your project

```ballerina
import kasvith/openweathermaps
```

**Obtain app id from Open Weather Maps**

Visit [Open Weather Maps](https://openweathermap.org/api) and Grab a **APPID** by registering.

**Initializing Client**

To initialize client after obtaining APPID you need to select language and metrics. They are defaulted to English and Kelvin(for temperature).

```ballerina
openweathermap:OpenWeatherMapClient owmClient =  new({
	appid: "YOUR_APP_ID"
});
```

**Use client to obtain weather of a city by ID**
```ballerina
var result = owmClient->getWeatherByCityName("Colombo");
io:println(result);
```
