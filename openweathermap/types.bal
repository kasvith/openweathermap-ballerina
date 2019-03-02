# Represents a Coordinate on map
#
# + lat - lat City geo location, longitude
# + lon - lon City geo location, latitude
public type Coord record {
    float lat = 0;
    float lon = 0;
};

# Represents a Weather report
#
# + id - id Weather condition id
# + main - main Group of weather parameters (Rain, Snow, Extreme etc.) 
# + description - description Weather condition within the group 
# + icon - icon  Weather icon id
public type Weather record {
    int id = 0;
    string main = "";
    string description = "";
    string icon = "";
};

# Represnt main data of request
#
# + temp - temp Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit. 
# + pressure - pressure Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), hPa 
# + humidity - humidity Humidity, %
# + temp_min - temp_min Minimum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
# + temp_max - temp_max Maximum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit. 
# + sea_level - sea_level Atmospheric pressure on the sea level, hPa 
# + grnd_level - grnd_level Atmospheric pressure on the ground level, hPa
public type Main record {
    float temp = 0;
    float pressure = 0;
    float humidity = 0;
    float temp_min = 0;
    float temp_max = 0;
    float sea_level = 0;
    float grnd_level = 0;
};

# Represents a wind record
#
# + speed - speed Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour. 
# + deg - deg Wind direction, degrees (meteorological)
public type Wind record {
    float speed = 0;
    float deg = 0;
};

# Represents a Snow record
#
# + h1 - h1 Snow volume for the last 1 hour, mm 
# + h3 - h3 Snow volume for the last 3 hours, mm
public type Snow record {
    float h1 = 0;
    float h3 = 0;
};

# Represents a Rain record
#
# + h1 - h1 Rain volume for the last 1 hour, mm 
# + h3 - h3 Rain volume for the last 3 hours, mm
public type Rain record {
    float h1 = 0;
    float h3 = 0;
};

# Represnt internal data
#
# + _type - _type Internal parameter 
# + id - id Internal parameter 
# + message - message Internal parameter
# + country - country Country code (GB, JP etc.)
# + sunrise - sunrise Sunrise time, unix, UTC 
# + sunset - sunset Sunset time, unix, UTC
public type Sys record {
    int _type = 0;
    int id = 0;
    string message = "";
    string country = "";
    int sunrise = 0;
    int sunset = 0;
};

# Represents cloud record
#
# + _all - _all Cloudiness, %
# + today - today Cloudiness today, %
public type Clouds record {
    float _all = 0;
    float today = 0;
};

# Description
#
# + id - id Parameter Description 
# + name - name Parameter Description 
# + cod - cod Parameter Description 
# + base - base Parameter Description 
# + dt - dt Parameter Description 
# + weather - weather Parameter Description 
# + coord - coord Parameter Description 
# + main - main Parameter Description 
# + wind - wind Parameter Description 
# + clouds - clouds Parameter Description 
# + rain - rain Parameter Description 
# + snow - snow Parameter Description 
# + sys - sys Parameter Description
public type WeatherRecord record {
    int id = 0;
    string name = "";
    int cod = 0;
    string base = "";
    int dt = 0;
    Weather[] weather = [];
    Coord coord = {};
    Main main = {};
    Wind wind = {};
    Clouds clouds = {};
    Rain rain = {};
    Snow snow = {};
    Sys sys = {};
};

# Represents multiple weather records together
#
# + message - message Parameter Description 
# + cod - cod Parameter Description 
# + count - count Parameter Description 
# + records - records Parameter Description
public type MultiWeatherRecord record {
    string message = "";
    int cod = 0;
    int count = 0;
    WeatherRecord[] records = [];
};

public type BoundingBox record {
    float lon_left = 0;
    float lat_bottom = 0;
    float lon_right = 0;
    float lat_top = 0;
    int zoom = 0;
};

public type OpenWeatherMapConfig record{
    string appid;
    string lang = "en";
    string units = "";
};
