/**
 * Created by gamedevmadeeasy on 1/21/20.
 */

public with sharing class LinkedinConnection {
    public static String BASE_URL = 'https://www.linkedin.com/oauth/v2/';
    public String requestEndpoint {get;set;}
    public String requestMethod {get;set;}
    public String requestBody {get;set;}
    public String state {get; set;}
    public String responseStatus {get;set;}
    public String redirectURL = 'https://jescoincplayground-dev-ed.my.salesforce.com/services/auth/oauth/linkedin_login';
    public Integer responseStatusCode {get;set;}
    public String responseBody {get;set;}
    public static final String CLIENT_SECRET = 'caRJRQICBSKVEuLf';
    public static final String CLIENT_ID = '81cxnbg3rmzibj';

    public PageReference getCallout() {
        requestMethod = 'GET';
        requestEndpoint = BASE_URL + 'authorization';
        HttpResponse res = Auth.callout(requestMethod, requestEndpoint, requestBody, CLIENT_ID, redirectURL, state);
        responseStatus = res.getStatus();
        responseStatusCode = res.getStatusCode();
        responseBody = res.getBody();
        state = '760iz0bjh9gy71asfFqa';
        PageReference reference =
                new PageReference(GetCalloutEndpoint(requestEndpoint, CLIENT_ID, redirectURL, state));
        System.debug(reference);
        System.debug(state);
        return reference;
    }

    public String GetCalloutEndpoint(String endpoint, String clientId, String redirect, String stateParam) {
        String result = endpoint + '?response_type=code'
                + '&client_id=' + clientId +
                '&redirect_uri=' + redirect
                + '&state=' + stateParam + '&scope=r_liteprofile';
        return result;
    }

    public String PostCalloutEndpoint(String redirect, String clientId, String clientSecret) {
        String result =
                'grant_type=' + 'authCodeResult' + '&redirect_url=' + redirect
                + 'client_id=' + clientId + '&client_secret=' + clientSecret;
        /*
        POST /oauth/v2/accessToken HTTP/1.1
Host: www.linkedin.com
Content-Type: application/x-www-form-urlencoded

grant_type=authorization_code&code=
{authorization_code_from_step2_response}
&redirect_uri=hhttps%3A%2F%2Fdev.example.com%2Fauth%2Flinkedin%2Fcallback&
client_id={your_client_id}&client_secret={your_client_secret}
         */
        return null;
    }
}