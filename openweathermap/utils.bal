import ballerina/io;
# Parse a HTTP response to json
# + httpResponse - HTTP response or HTTP Connector error with network related errors
# + return - `json` payload or `error` if anything wrong happen when HTTP client invocation or parsing response to `json`
function parseResponseToJson(http:Response|error httpResponse) returns json|error {
    if (httpResponse is http:Response) {
        var jsonResponse = httpResponse.getJsonPayload();
        if (jsonResponse is json) {
            if (httpResponse.statusCode != http:OK_200) {
                string errMsg = jsonResponse.message.toString();
                int errCode = check int.convert(jsonResponse.cod);
                error err = error(string.convert(errCode), { message: errMsg });
                return err;
            }
            return jsonResponse;
        } else {
            error err = error("10",
            { message: "Error occurred while accessing the JSON payload of the response" });
            return err;
        }
    } else {
        error err = error("11", { message: "Error occurred while invoking the REST API" });
        return err;
    }
}