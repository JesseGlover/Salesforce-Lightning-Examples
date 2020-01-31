/**
 * Created by gamedevmadeeasy on 1/29/20.
 */

import {LightningElement, track, wire} from 'lwc';
import customFilter from '@salesforce/apex/UITableCustomClass.filterAllData';

export default class UiTableLwc extends LightningElement {
    @track testData;
    @track error;
    @track labelName = 'Load Data';
    @track columns = [
        {label: 'Owner', fieldName: 'OwnerName', type: 'text', cellAttributes: { alignment: 'left' }},
        {label: 'Total Leads', fieldName: 'LeadAmount', type: 'number', cellAttributes: { alignment: 'left' }},
        {label: 'Total Opps.', fieldName: 'OpportunityAmount' , type: 'number', cellAttributes: { alignment: 'left' }},
        {label: 'Conv Rate', fieldName: 'ConversionRate' , type: 'percent', typeAttributes:{maximumFractionDigits: 2}, cellAttributes: { alignment: 'left' }},
        {label: 'Max Created Date (Opp)', fieldName: 'MaxCreatedDate' , type: 'text', cellAttributes: { alignment: 'left' }},
        {label: 'Total Val (Opp)', fieldName: 'TotalValue' , type: 'number', cellAttributes: { alignment: 'left' }}
    ];

    @wire(customFilter)
    WiredCustom ({error, data}) {
        if (data) {
            this.testData = data;
            window.console.log(JSON.stringify(this.testData));
        }
        else if (error) {
            this.error = error;
            window.console.log('error: ' + JSON.stringify(error));
        }
    }

}