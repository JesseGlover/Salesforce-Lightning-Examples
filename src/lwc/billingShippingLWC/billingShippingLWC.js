/**
 * Created by gamedevmadeeasy on 1/10/20.
 */

import {LightningElement, track, wire} from 'lwc';
import getStateData from "@salesforce/apex/AccountBilling.getAllStateCodes";
import getCountryData from "@salesforce/apex/AccountBilling.getAllCountryCodes";

export default class BillingShippingLwc extends LightningElement {

    @track shippingStreet;
    @track shippingCity;
    @track shippingPostalCode;
    @track shippingCountry;
    @track shippingProvince;

    @track billingCity;
    @track billingStreet;
    @track billingPostalCode;
    @track billingCountry;
    @track billingProvince;

    @track provinceOptions = [];
    @track countryOptions = [];

    @track isFilled = false;
    @track isComplete = false;
    @track error;

    @wire(getStateData)
    wireStateOptions({error, data}) {
        if(data) {
            let options = [];
            data.forEach(function(element) {
                options.push({value: element, label: element});
            });
            this.provinceOptions = options;
        }
        else {
            this.provinceOptions = undefined;
            this.error = error;
        }
    }

    @wire(getCountryData)
    wireCountryDataOptions({error, data}) {
        if(data) {
            let options = [];
            data.forEach(function(element) {
                options.push({value: element, label: element});
            });
            this.countryOptions = options;
        }
        else {
            this.countryOptions = undefined;
            this.error = error;
        }
    }

    checkChanged(event) {
        this.isFilled = event.target.checked;
    }

    buttonClick(event) {

    }

    completeContact() {
        var data = this.template.querySelector('lightning-input-address');
        var isValid = data.checkValidity();
        if (isValid) {
            this.isComplete = true;
        }
    }
}
// Todo:  First name, Last name, email, phone, Street, City, State and Zipcode
// Todo: proper validations for all fields for addresses.
// Todo: have submit button save the details on Contact. Submit button should
// Todo: (continued) be greyed out until all the information is filled and valid.