import ballerina/io;
import kasvith/openweathermap;

public function main(string... args) {
    openweathermap:OpenWeatherMapClient owmClient = new({
        appid: "a46a1fc2d6f3b7be6e04ca86d508af40",
        units: "imperial"
    });

    var rec = owmClient->getWeatherByCitiesWithinRectangleZone({
        lon_left : 12,
        lat_bottom : 32,
        lon_right : 15,
        lat_top : 37,
        zoom : 10
    });
    io:println(rec);
}