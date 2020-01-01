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
    @track error;
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
            // Logging to the console to showcase that the data is there
            console.log('Data Source results ' + source);
            // set's the paginationList value to be our source value
            this.paginationList = source;

        }
        else if (error) {
            // if there is an error, throw an error and set the paginationList
            // to be undefined.
            this.error = error;
            console.log(error);
            this.paginationList = undefined;
        }
    }
}