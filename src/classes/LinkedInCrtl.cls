/**
 * Created by gamedevmadeeasy on 1/23/20.
 *
 * https://docs.microsoft.com/en-us/linkedin/shared/references/v2/profile/lite-profile?context=linkedin/consumer/context
 *
 */

public class LinkedInCrtl{
    public String EmailAddress {get; set;}
    public LinkedInParser lwrapper{get;set;}

    public LinkedInCrtl() {
        lwrapper = new LinkedInParser();
        fetchLinkedInDetails();
        fetchLinkedInEmailDetails();
    }

    public static void test() {
        LinkedInParser lwrapper = new LinkedInParser();
        LinkedInCrtl crtl = new LinkedInCrtl();
        crtl.fetchLinkedInDetails();
        crtl.fetchLinkedInEmailDetails();
    }

    /**
    * Grabs the Email details for Linkedin from the OAuth2 connection
    * Utilizes callout and OAuth2 for the Linkedin API V2
    * @param empty
    * @return void.
    */
    private void fetchLinkedInEmailDetails() {
        HttpRequest req = new HttpRequest();
        req.setHeader('accept', 'application/json');
        String email = 'callout:Linkedin_Connection/' +
                'clientAwareMemberHandles?q=members&projection=' +
                '(elements*(primary,type,handle~))';
        req.setEndpoint(email);
        req.setMethod('GET');
        Http http = new Http();
        HttpResponse res = http.send(req);
        if (res.getStatusCode() == 200) {
            JSONParser parser = JSON.createParser(res.getBody());
            while (parser.nextToken() != null) {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&
                        (parser.getText() == 'emailaddress')) {
                parser.nextToken();
                EmailAddress = parser.getText();
                }
            }
        }
    }

    // Parsing the JSON data via wrapper class
    private void fetchLinkedInDetails() {
        HttpRequest req = new HttpRequest();
        req.setHeader('accept', 'application/json');
        /*
*********************************************************************************************
         */
        // The V2 url has changed with Linkedin's OAuth2 request. This was
        // the main source of headache for the last 2 days.
        // https://forum.bubble.io/t/linkedin-oauth-profile-data/54422/24
        // https://developer.linkedin.com/docs/ref/v2/digital-media-asset

        // Note: With v2; id, firstname, lastname and profile picture are the
        // only items able to be returned with the lite profile. Email can be gained from
        // another call that is specific to the email, you need to provide the id.
        String uri = 'callout:Linkedin_Connection/me?projection=' +
                '(id,firstName,lastName,profilePicture(displayImage~:privatePlayableStreams(elements*(*))))';
        // the api link to attached to the named credential is https://api.linkedin.com/v2
        // scope should be r_liteprofile with the consumer key and secrets from Linkedin app
        // The Auth Providers needs to be configured for Linkedin. Attach the urls to the
        // linkedin application.
        // To do the same call without the callout, use
        // https://api.linkedin.com/v2/me?projection=(id,profilePicture(displayImage~:playableStreams))&oauth2_access_token=HERE PASS ACCESS TOKEN.
        req.setEndpoint(uri);
        /*
*********************************************************************************************
        */
        req.setMethod('GET');
        System.debug('http request: ' + req);
        Http http = new Http();
        HttpResponse res = http.send(req);
        System.debug('http res val: ' + res);
        String responsestr = res.getBody();
        System.debug('http response: ' + res.getBody());
        lwrapper = (LinkedInParser) System.JSON.deserialize(responsestr, LinkedInParser.class);
        System.debug('lwrapper call: ' + lwrapper);
    }
}