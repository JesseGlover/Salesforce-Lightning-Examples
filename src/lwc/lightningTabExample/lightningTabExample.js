/**
 * Created by gamedevmadeeasy on 1/20/20.
 */

import {LightningElement, track, wire} from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import OPPORTUNITY_OBJECT from '@salesforce/schema/Opportunity';
import USER_OBJECT from '@salesforce/schema/User';
import LEAD_OBJECT from '@salesforce/schema/Lead';
import getOpportunities from '@salesforce/apex/GetSalesforceData.getOpportunities';
import getUsers from '@salesforce/apex/GetSalesforceData.getUsers';
import getAccounts from '@salesforce/apex/GetSalesforceData.getAccounts';
import getContacts from '@salesforce/apex/GetSalesforceData.getContacts';
import getLeads from '@salesforce/apex/GetSalesforceData.getLeads';

export default class LightningTabExample extends LightningElement {
    @track accountData = [];
    @track contactData = [];
    @track opportunityData = [];
    @track userData = [];
    @track leadData = [];

    @wire(getAccounts,{ objectApiName: ACCOUNT_OBJECT })
    wiredAccounts({error, data}) {
        if (data) {
            this.accountData = data;
            this.error = undefined;
        }
        else if (error) {
            this.error = error;
            this.accountData = undefined;
        }
    }

    @wire(getContacts,{ objectApiName: CONTACT_OBJECT })
    wiredContacts({error, data}) {
        if (data) {
            this.contactData = data;
            this.error = undefined;
        }
        else if (error) {
            this.error = error;
            this.contactData = undefined;
        }
    }

    @wire(getOpportunities,{ objectApiName: OPPORTUNITY_OBJECT })
    wiredContracts({error, data}) {
        if (data) {
            this.opportunityData = data;
            this.error = undefined;
        }
        else if (error) {
            this.error = error;
            this.opportunityData = undefined;
        }
    }

    @wire(getUsers,{ objectApiName: USER_OBJECT })
    wiredUsers({error, data}) {
        if (data) {
            this.userData = data;
            this.error = undefined;
        }
        else if (error) {
            this.error = error;
            this.userData = undefined;
        }
    }

    @wire(getLeads,{ objectApiName: LEAD_OBJECT })
    wiredLeads({error, data}) {
        if (data) {
            this.leadData = data;
            this.error = undefined;
        }
        else if (error) {
            this.error = error;
            this.leadData = undefined;
        }
    }
}