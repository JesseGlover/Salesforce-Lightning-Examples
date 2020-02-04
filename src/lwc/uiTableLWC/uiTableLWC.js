/**
 * Created by gamedevmadeeasy on 1/29/20.
 */

import {LightningElement, track, wire} from 'lwc';
import customFilter from '@salesforce/apex/UITableCustomClass.filterAllData';

export default class UiTableLwc extends LightningElement {
    @track testData;
    @track error;
    @track createdDate;
    @track closedDate;
    @track labelName = 'Load Data';
    @track columns = [
        {label: 'Owner', fieldName: 'OwnerName', type: 'text', cellAttributes: { alignment: 'left' }},
        {label: 'Total Leads', fieldName: 'LeadAmount', type: 'number', cellAttributes: { alignment: 'left' }},
        {label: 'Total Opps.', fieldName: 'OpportunityAmount' , type: 'number', cellAttributes: { alignment: 'left' }},
        {label: 'Conv Rate', fieldName: 'ConversionRate' , type: 'percent', typeAttributes:{maximumFractionDigits: 2}, cellAttributes: { alignment: 'left' }},
        {label: 'Max Created Date (Opp)', fieldName: 'MaxCreatedDate' , type: 'text', cellAttributes: { alignment: 'left' }},
        {label: 'Total Val (Opp)', fieldName: 'TotalValue' , type: 'number', cellAttributes: { alignment: 'left' }}
    ];

    @wire(customFilter,
        {createdDate : '$createdDate', closedDate : '$closedDate'})
    WiredCustom ({error, data}) {
        if (data) {
            customFilter({createdDate : this.createdDate, closedDate : this.closedDate})
                .then (result => {
                    this.testData = result;
                    console.log(this.testData);
                })
                .catch (error => {
                    this.error = error;
                });
        }
    }


    onDateCreatedChange(event) {
        this.createdDate = event.target.value;
    }

    onDateClosedChange(event) {
        this.closedDate = event.target.value;
    }
}