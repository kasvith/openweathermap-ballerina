import ballerina/io;
// Mappers used to map json data from API to records

function mapJsonToWeather(json payload) returns Weather|error {
    Weather weather = {};

    weather.id = check int.convert(payload.id);
    weather.main = payload.main.toString();
    weather.description = payload.description.toString();
    weather.icon = payload.icon.toString();
    
    return weather;
}

function mapJsonToWeatherArray(json payload) returns Weather[]|error {
    Weather[] arr = [];

    int i = 0;
    json[] weathers = <json[]>payload;
    foreach var w in weathers {
        arr[i] = check mapJsonToWeather(w);
        i += 1;
    }

    return arr;
}

function mapJsonToCoord(json payload) returns Coord|error{
    Coord coord = {};

    coord.lat = check float.convert(payload.lat);
    coord.lon = check float.convert(payload.lon);

    return coord;
}

function mapJsonToMain(json payload) returns Main|error {
    Main main = {};

    main.temp = check float.convert(payload.temp);
    main.pressure = check float.convert(payload.pressure);
    main.humidity = check float.convert(payload.humidity);
    main.temp_min = check float.convert(payload.temp_min);
    main.temp_max = check float.convert(payload.temp_max);
    main.sea_level = check float.convert(payload.sea_level);
    main.grnd_level = check float.convert(payload.grnd_level);

    return main;
}

function mapJsonToWind(json payload) returns Wind|error{
    Wind wind = {};

    wind.deg = check float.convert(payload.deg);
    wind.speed = check float.convert(payload.speed);

    return wind;
}

function mapJsonToSnow(json payload) returns Snow|error{
    Snow snow = {};

    snow.h1 = check float.convert(payload["1h"]);
    snow.h3 = check float.convert(payload["3h"]);

    return snow;
}

function mapJsonToRain(json payload) returns Snow|error{
    Rain rain = {};

    rain.h1 = check float.convert(payload["1h"]);
    rain.h3 = check float.convert(payload["3h"]);

    return rain;
}

function mapJsonToClouds(json payload) returns Clouds|error{
    Clouds clouds = {};

    clouds._all = check float.convert(payload["all"]);
    clouds.today = check float.convert(payload["today"]);

    return clouds;
}

function mapJsonToSys(json payload) returns Sys|error {
    Sys sys = {};

    sys._type = check int.convert(payload["type"]);
    sys.id = check int.convert(payload["id"]);
    sys.message = payload.message.toString();
    sys.country = payload.country.toString();
    sys.sunrise = check int.convert(payload["sunrise"]);
    sys.sunset = check int.convert(payload["sunset"]);

    return sys;
}

function mapJsonToWeatherRecord(json payload) returns WeatherRecord|error {
    WeatherRecord wrecord = {};
    
    wrecord.id = check int.convert(payload.id);
    wrecord.cod = check int.convert(payload.cod);
    wrecord.dt = check int.convert(payload.dt);
    wrecord.name = payload.name.toString();
    wrecord.base = payload.base.toString();
    wrecord.weather = check mapJsonToWeatherArray(payload.weather);
    wrecord.coord = check mapJsonToCoord(payload.coord);
    wrecord.main = check mapJsonToMain(payload.main);
    wrecord.wind = check mapJsonToWind(payload.wind);
    wrecord.snow = check mapJsonToSnow(payload.snow);
    wrecord.rain = check mapJsonToRain(payload.rain);
    wrecord.clouds = check mapJsonToClouds(payload.clouds);
    wrecord.sys = check mapJsonToSys(payload.sys);

    return wrecord;
}

function mapJsonToWeatherRecordArray(json payload) returns WeatherRecord[]|error {
    WeatherRecord[] arr = [];

    int i = 0;
    json[] weathers = <json[]>payload;
    foreach var w in weathers {
        arr[i] = check mapJsonToWeatherRecord(w);
        i += 1;
    }

    return arr;
}

function mapJsonToMultiWeatherRecord(json payload) returns MultiWeatherRecord|error{
    MultiWeatherRecord mrecord = {};

    if (payload.count != ()) {
        mrecord.count = check int.convert(payload.count);
    } else if(payload.cnt != ()){
        mrecord.count = check int.convert(payload.cnt);
    }

    mrecord.cod = check int.convert(payload.cod);
    mrecord.message = payload.message.toString();
    mrecord.records = check mapJsonToWeatherRecordArray(payload.list);

    return mrecord;
}
