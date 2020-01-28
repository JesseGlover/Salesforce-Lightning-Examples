/**
 * Created by gamedevmadeeasy on 1/21/20.
 */

import {LightningElement, wire} from 'lwc';
import getCallout from '@salesforce/apex/HTTPCalloutLWC.returnLocationURL';

export default class LinkedinIntegrationExample extends LightningElement {

    onClick() {
        var xhttp = new XMLHttpRequest();
        const url = 'https://www.linkedin.com/oauth/v2/authorization?response_type'
            +'=code&client_id='
            +'81cxnbg3rmzibj'
            +'&redirect_uri=https%3A%2F%2Fgdme.com%2'
            +'Fauth%2Flinkedin%2Fcallback&state=fooobar&scope=r_liteprofile%20'
            +'r_emailaddress%20w_member_social';
        xhttp.onreadystatechange = function() {
            if (this.readyState === 4 && this.status === 200) {
                alert(this.responseText);
            }
        };
        xhttp.open("GET", url, true);
        xhttp.setRequestHeader("Content-type", "application/json");
        xhttp.send();
    }

}