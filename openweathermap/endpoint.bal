import ballerina/http;
import ballerina/io;
// Defines endpoints for client

public type OpenWeatherMapClient client object {
    OpenWeatherMapConfig config;
    http:Client basicClient;

    public function __init(OpenWeatherMapConfig config){
        self.config = config;
        self.basicClient = new (API_BASE);
    }

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

    public function requestWeatherRecord(string path) returns WeatherRecord|error{
        return check mapJsonToWeatherRecord(check self.doGetRequest(path));
    }

    public function requestMultiWeatherRecord(string path) returns MultiWeatherRecord|error{
        return check mapJsonToMultiWeatherRecord(check self.doGetRequest(path));
    }

    public remote function getWeatherByCity(string city) returns WeatherRecord|error {
        string reqPath = string `{{WEATHER}}?q={{city}}`;

        return check self.requestWeatherRecord(reqPath);
    }

    public remote function getWeatherByCityAndCountryCode(string city, string locale) returns WeatherRecord|error {
        string reqPath = string `{{WEATHER}}?q={{city}},{{locale}}`;

        return check self.requestWeatherRecord(reqPath);
    }

    public remote function getWeatherByCityID(int id) returns WeatherRecord|error {
        string reqPath = string `{{WEATHER}}?id={{id}}`;

        return check self.requestWeatherRecord(reqPath);
    }

    public remote function getWeatherByZipcode(int zip) returns WeatherRecord|error {
        string reqPath = string `{{WEATHER}}?zip={{zip}}`;

        return check self.requestWeatherRecord(reqPath);
    }

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

    public remote function getWeatherByCitiesWithinRectangleZone(BoundingBox bbox, boolean useServerClusteringOfPoints = true) returns MultiWeatherRecord|error {
        string reqPath = string `{{RECT}}?bbox={{bbox.lon_left}},{{bbox.lat_bottom}},{{bbox.lon_right}},{{bbox.lat_top}},{{bbox.zoom}}`;
        if(!useServerClusteringOfPoints){
            reqPath = string `{{reqPath}}&cluster=no`;
        }

        return check self.requestMultiWeatherRecord(reqPath);
    }

    public remote function getWeatherByCitiesWithinCircle(float lat, float lon, int cnt, boolean useServerClusteringOfPoints = true) returns MultiWeatherRecord|error {
        string reqPath = string `{{FIND}}?lat={{lat}}&lon={{lon}}&cnt={{cnt}}`;
        if(!useServerClusteringOfPoints){
            reqPath = string `{{reqPath}}&cluster=no`;
        }
        
        return check self.requestMultiWeatherRecord(reqPath);
    }

    public remote function getWeatherByIDs(int... ids) returns MultiWeatherRecord|error {
        string base = string `{{GROUP}}?id=`;

        foreach var id in ids {
            base += string.convert(id) + ",";
        }
        var reqPath = base.substring(0,  base.length() - 1);
        
        return check self.requestMultiWeatherRecord(reqPath);
    }
};
