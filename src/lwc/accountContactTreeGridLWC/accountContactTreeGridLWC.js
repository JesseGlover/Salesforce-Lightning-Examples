/**
 - Created by Jesse Glover on 12/31/19.
 */

/** Lightning Element is a reference to our Lightning Web Component
 *  track is for our private property and marks it as reactive
 *  api is for our public property and marks it as reactive
 *  wire is for sending and receiving data from our Apex Method
 **/
import {LightningElement, track, wire} from 'lwc';
/** imports a method from an apex class */
import getTreeGridData from '@salesforce/apex/AccountContactTableController.getAccountContact';

export default class AccountContactTreeGridLwc extends LightningElement {
    @track page = 1; //this is initialize for 1st page
    @track startingRecord = 1; //start record position per page
    @track endingRecord = 0; //end record position per page
    @track pageSize = 5; //default value we are assigning
    @track totalRecountCount = 0; //total record count received from all retrieved records
    @track totalPage = 0; //total number of page is needed to display all records
    @track previousIsDisabled = false;
    @track nextIsDisabled = false;
    @track error;
    @track sourceData;
    /** @track is used to rerender a property's value when it changes */
    @track paginationList;
    /** Setup for grid columns is very similar in approach to Aura components
     * just needs the @track to work for the most part
     * be absolutely certain that the fieldName matches the
     * Server-side code's AuraEnabled properties */
    @track gridColumns = [{
        label: 'Id', fieldName: 'queriedId', type: 'text'},
        {label: 'Name', fieldName: 'queriedName', type: 'text'}
    ];

    /** @wire is calling the server side function from our Apex Class
     * wireTreeData is a method that is tied to the @wire server side call
     * (name can be whatever you want)
     * This works by taking the JSON value and parsing
     * it behind the scenes to display on the page
     * */
    @wire(getTreeGridData)
    wireTreeData({ error, data }) {
        if (data) {
            /** Parsing the JSON results and turning
             * them into string results from the data
             * then split the data by the list of
             * subQueries from the AccountContactTableController class
             * then join the results by the children,
             * which will display the child elements underneath the
             * appropriate tree item */
            var source =
                JSON.parse(JSON.stringify(data).split
                ('subQueries').join('_children'));
            this.sourceData = source;
            this.totalRecountCount = source.length;
            this.totalPage = Math.ceil(this.totalRecountCount / this.pageSize); //here it is 5

            //initialize data to be displayed ----------->
            //slice will take 0th element and ends with 5, but it doesn't include 5th element
            //so 0 to 4th rows will be display in the table
            this.paginationList = this.sourceData.slice(0, this.pageSize);
            this.endingRecord = this.pageSize;

        }
        else if (error) {
            // if there is an error, throw an error and set the paginationList
            // to be undefined.
            this.error = error;
            console.log(error);
            this.paginationList = undefined;
        }
    }

    //clicking on previous button this method will be called
    previousHandler(event) {
        if (this.page > 1) {
            this.page = this.page - 1; //decrease page by 1
        }
        if (this.page <= 1) {
            this.previousIsDisabled = true;
        }

        const selectedEvent = new CustomEvent('selected',
            { detail: this.displayRecordPerPage(this.page)});
        dispatchEvent(selectedEvent);
    }

    //clicking on next button this method will be called
    nextHandler(event) {
        if((this.page < this.totalPage) && this.page !== this.totalPage){
            this.page = this.page + 1; //increase page by 1

        }
        this.nextIsDisabled = this.page === this.endingRecord;
        const selectedEvent = new CustomEvent('selected',
            { detail: this.displayRecordPerPage(this.page)});
        dispatchEvent(selectedEvent);
    }

    //this method displays records page by page
    displayRecordPerPage(page){

        /*let's say for 2nd page, it will be => "Displaying 6 to 10 of 23 records. Page 2 of 5"
        page = 2; pageSize = 5; startingRecord = 5, endingRecord = 10
        so, slice(5,10) will give 5th to 9th records.
        */
        this.startingRecord = ((page -1) * this.pageSize) ;
        this.endingRecord = (this.pageSize * page);

        this.endingRecord = (this.endingRecord > this.totalRecountCount)
            ? this.totalRecountCount : this.endingRecord;

        this.paginationList = this.sourceData.slice(this.startingRecord, this.endingRecord);

        //increment by 1 to display the startingRecord count,
        //so for 2nd page, it will show "Displaying 6 to 10 of 23 records. Page 2 of 5"
        this.startingRecord = this.startingRecord + 1;
    }


}