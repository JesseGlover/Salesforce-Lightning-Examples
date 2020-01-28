/**
 * Created by gamedevmadeeasy on 1/22/20.
 */

public class Auth {
    //Method to perform a callout and return an httpResponse
    public static HttpResponse callout(String httpMethod, String endpoint, String body, String clientId, String url, String stateParam){
        //Instantiate an httpRequest and set the required attributes
        HttpRequest req = new HttpRequest();
        req.setMethod(httpMethod);
        req.setEndpoint(endpoint);
        //Optional attributes are often required to conform to the 3rd Party Web Service Requirements
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        //You can adjust the timeout duration (in milliseconds) to deal with slow servers or large payloads
        req.setTimeout(120000);
        //Use the HTTP Class to send the httpRequest and receive an httpResponse
        HttpResponse res = new Http().send(req);

        System.debug(res.toString());
        System.debug(res.getBody());
        return res;
    }
}