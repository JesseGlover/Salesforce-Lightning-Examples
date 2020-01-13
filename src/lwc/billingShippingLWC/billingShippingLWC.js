/**
 * Created by gamedevmadeeasy on 1/10/20.
 */

import {LightningElement, track, wire} from 'lwc';
import getStateData from "@salesforce/apex/AccountBilling.getAllStateCodes";
import getCountryData from "@salesforce/apex/AccountBilling.getAllCountryCodes";

export default class BillingShippingLwc extends LightningElement {
    @track billingStreet;
    @track shippingStreet;
    @track billingCity;
    @track shippingCity;
    @track billingPostalCode;
    @track shippingPostalCode;
    @track shippingCountry;
    @track billingCountry;
    @track shippingProvince;
    @track billingProvince;
    @track provinceOptions = [];
    @track countryOptions = [];
    @track isChecked = false;
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

    billingChanged() {

    }

    shippingChanged() {

    }

    buttonClick(event) {

    }
}