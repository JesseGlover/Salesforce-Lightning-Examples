/**
 * Created by gamedevmadeeasy on 1/30/20.
 */

import {LightningElement, track, wire} from 'lwc';
import parsedData from '@salesforce/apex/UITableData.filterOpportunities';
const columns = [
    {label: 'Owner', fieldName: 'Name'},
    {label: 'Total Leads', fieldName: 'amount'},
    {label: 'Total Opps.', fieldName: 'contact'},
    {label: 'Conv Rate', fieldName: 'phone'},
    {label: 'Max Created Date (Opp)', fieldName: 'Opportunity.CreatedDate'},
    {label: 'Total Val (Opp)', fieldName: 'Opportunity.Amount'}
];
export default class TestLwc extends LightningElement {
    @track data;
    @track error;
    @track columns = columns;

    @wire(parsedData)
    WiredData({error, data}) {
        if (data) {
            this.data = data;
            window.console.log('data ==> '+ JSON.stringify(data));
        }
        else if (error) {
            this.error = error;
        }
    }
}