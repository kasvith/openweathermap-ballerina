import ballerina/http;
// Defines endpoints for client

# Creates a client that can be used to connect OpenWeatherMap Current Weather API
#
# + config - OpenWeatherMap Configuration
public type OWMCurrentWeatherClient client object {
    OpenWeatherMapConfig config;
    http:Client basicClient;

    public function __init(OpenWeatherMapConfig config){
        self.config = config;
        self.basicClient = new (API_BASE);
    }

    # Perform a GET request for API endpoint
    #
    # + path - Path of request without API Base 
    # + return - json or error
    function doGetRequest(string path) returns json|error{
        string finalPath = string `{{path}}&{{APPID}}={{self.config.appid}}`;

        if(self.config.lang != "en"){
            finalPath += "&lang=" + self.config.lang;
        }

        var units = self.config.units;
        if(units != ""){
            finalPath += "&units=" + units;
        }

        var httpResponse = self.basicClient->get(finalPath);
        json jsonResponse = check parseResponseToJson(httpResponse);

        return jsonResponse;
    }

    # Request a weather record from API
    #
    # + path - Path of request
    # + return - WeatherRecord or an error
    public function requestWeatherRecord(string path) returns WeatherRecord|error{
        return check mapJsonToWeatherRecord(check self.doGetRequest(path));
    }

    # Request multi weather record from API
    #
    # + path - Path of request
    # + return - MultiWeatherRecord or an error
    public function requestMultiWeatherRecord(string path) returns MultiWeatherRecord|error{
        return check mapJsonToMultiWeatherRecord(check self.doGetRequest(path));
    }

    # Get weather of a city by name
    #
    # + city - City name 
    # + return - WeatherRecord of city or error
    public remote function getWeatherByCityName(string city) returns WeatherRecord|error {
        string reqPath = string `{{WEATHER}}?q={{city}}`;

        return check self.requestWeatherRecord(reqPath);
    }

    # Get weather of a city by name and country code
    #
    # + city - City name  
    # + countryCode - Country code
    # + return - WeatherRecord or an error
    public remote function getWeatherByCityAndCountryCode(string city, string countryCode) returns WeatherRecord|error {
        string reqPath = string `{{WEATHER}}?q={{city}},{{countryCode}}`;

        return check self.requestWeatherRecord(reqPath);
    }

    # Get weather of a city ID
    #
    # + id - City ID 
    # + return - WeatherRecord or an error
    public remote function getWeatherByCityID(int id) returns WeatherRecord|error {
        string reqPath = string `{{WEATHER}}?id={{id}}`;

        return check self.requestWeatherRecord(reqPath);
    }

    # Get weather of a city by ZIP code
    #
    # + zip - ZIP code of city
    # + return - WeatherRecord or an error
    public remote function getWeatherByZipcode(int zip) returns WeatherRecord|error {
        string reqPath = string `{{WEATHER}}?zip={{zip}}`;

        return check self.requestWeatherRecord(reqPath);
    }

    # Get weather record of a geographical location by Latitude and Longitude
    #
    # + lat - Latitude of location
    # + lon - Longitude of location
    # + return - WeatherRecord or an error
    public remote function getWeatherByCityCoordinates(float lat, float lon) returns WeatherRecord|error {
        if (lat < -90 || lat > 90) {
            error err = error("20", { message: "Latitude is out of range(-90 <= lat <= 90)" });
            return err;
        }

        if (lon < -180 || lon > 180) {
            error err = error("20", { message: "Longitude is out of range(-180 <= lat <= 180)" });
            return err;
        }

        string reqPath = string `{{WEATHER}}?lat={{lat}}&lon={{lon}}`;
        return check self.requestWeatherRecord(reqPath);
    }

    # Get the weather data from cities within the defined rectangle specified by the geographic coordinates.
    #
    # + bbox - bounding box [lon-left,lat-bottom,lon-right,lat-top,zoom]
    # + useServerClusteringOfPoints - use server clustering of points.
    # + return - MultiWeatherRecord or an error
    public remote function getWeatherByCitiesWithinRectangleZone(BoundingBox bbox, boolean useServerClusteringOfPoints = true) returns MultiWeatherRecord|error {
        string reqPath = string `{{RECT}}?bbox={{bbox.lon_left}},{{bbox.lat_bottom}},{{bbox.lon_right}},{{bbox.lat_top}},{{bbox.zoom}}`;
        if(!useServerClusteringOfPoints){
            reqPath = string `{{reqPath}}&cluster=no`;
        }

        return check self.requestMultiWeatherRecord(reqPath);
    }

    # returns data from cities laid within definite circle that is specified by center point ('lat', 'lon') and expected number of cities ('cnt') around this point. The default number of cities is 10, the maximum is 50.
    #
    # + lat - latitude of circle center point
    # + lon - longitude og circle center point
    # + cnt - number of cities around the point that should be returned
    # + useServerClusteringOfPoints - use server clustering of points.
    # + return - MultiWeatherRecord or an error
    public remote function getWeatherByCitiesWithinCircle(float lat, float lon, int cnt, boolean useServerClusteringOfPoints = true) returns MultiWeatherRecord|error {
        string reqPath = string `{{FIND}}?lat={{lat}}&lon={{lon}}&cnt={{cnt}}`;
        if(!useServerClusteringOfPoints){
            reqPath = string `{{reqPath}}&cluster=no`;
        }
        
        return check self.requestMultiWeatherRecord(reqPath);
    }

    # Get weather data for several cities at once by IDs. The limit of locations is 20.  A single ID counts as a one API call! So, the above example is treated as a 3 API calls.
    #
    # + ids - ids List of IDs need to be proceed
    # + return - MultiWeatherRecord or an error
    public remote function getWeatherByIDs(int... ids) returns MultiWeatherRecord|error {
        string base = string `{{GROUP}}?id=`;

        foreach var id in ids {
            base += string.convert(id) + ",";
        }
        var reqPath = base.substring(0,  base.length() - 1);
        
        return check self.requestMultiWeatherRecord(reqPath);
    }
};
