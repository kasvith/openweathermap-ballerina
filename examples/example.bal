import kasvith/openweathermap;
import ballerina/config;
import ballerina/io;

// An example API Call

public function main(string... args) {
    openweathermap:OWMCurrentWeatherClient owmClient = new({
        appid: config:getAsString("APPID")
    });

    var result = owmClient->getWeatherByCityName("Colombo");
    io:println(result);
}