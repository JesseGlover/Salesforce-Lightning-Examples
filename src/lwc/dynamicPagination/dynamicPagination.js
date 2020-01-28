/**
 * Created by gamedevmadeeasy on 1/24/20.
 */

import {LightningElement, wire, track} from 'lwc';
import salesforceData from '@salesforce/apex/GetSalesforceData.getAccounts';

export default class DynamicPagination extends LightningElement {
    @track startingPage = 1;
    @track startingRecord = 1;
    @track endingRecord = 0;
    @track pageSize = 5;
    @track totalNumRecount = 0;
    @track totalPageCount = 0;
    @track paginationList;
    @track error;
    @track dataSource;
    @track columns = [
        // SELECT Id, Name, Phone, Industry FROM Account
        {label: 'Id', fieldName: 'Id'},
        {label: 'Name', fieldName: 'Name'},
        {label: 'Phone Number', fieldName: 'Phone'},
        {label: 'Industry', fieldName: 'Industry'}
    ];

    @wire(salesforceData)
    wiredSalesforceData({error, data}) {
        if (data) {
            this.pageSize = 5;
            this.dataSource = data;
            this.totalNumRecount = data.length;
            this.totalPageCount = Math.ceil(this.totalNumRecount / this.pageSize);
            this.paginationList = this.dataSource.slice(0, this.pageSize);
            this.endingRecord = this.pageSize;
            this.error = undefined;
        }
        else {
            this.error = error;
            this.dataSource = undefined;
        }
    }

    displayRecordPage(page) {
        this.totalPageCount = Math.ceil(this.totalNumRecount / this.pageSize);
        this.startingRecord = ((page - 1) * this.pageSize);
        this.endingRecord = (this.pageSize * page);

        this.endingRecord = (this.endingRecord > this.totalNumRecount)
            ? this.totalNumRecount : this.endingRecord;

        this.paginationList = this.dataSource.slice(this.startingRecord, this.endingRecord);
        this.startingRecord = this.startingRecord + 1;
    }

    previousHandler() {
        if (this.startingPage > 1) {
            this.startingPage = this.startingPage - 1; //decrease page by 1
        }

        // creates a custom event to call the displayRecordPerPage method
        const selectedEvent = new CustomEvent('selected',
            { detail: this.displayRecordPage(this.startingPage)});
        // sends the event to the dom to be handled by the page
        dispatchEvent(selectedEvent);
    }

    nextHandler() {
        if((this.startingPage < this.totalPageCount) && this.startingPage !== this.totalPageCount){
            this.startingPage = this.startingPage + 1; //increase page by 1
        }

        // creates a custom event to call the displayRecordPerPage method
        const selectedEvent = new CustomEvent('selected',
            { detail: this.displayRecordPage(this.startingPage)});
        // sends the event to the dom to be handled by the page
        dispatchEvent(selectedEvent);
    }

    onValueChanged(event) {
        if (isNaN(event.target.value)) {
            alert("Please use a valid number");
        }
        if (event.target.value !== null) {
            this.pageSize = event.target.value;
            this.displayRecordPage(this.startingPage);
        }
    }
}