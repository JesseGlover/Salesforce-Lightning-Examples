/**
 * Created by gamedevmadeeasy on 1/27/20.
 */

import { LightningElement, track, api, wire } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import readCSV from '@salesforce/apex/ImportRelatedContacts.readCSVFile';

const columns = [
    { label: 'Salutation', fieldName: 'Salutation', editable: true },
    { label: 'FirstName', fieldName: 'FirstName', editable: true },
    { label: 'LastName', fieldName: 'LastName', editable: true},
    { label: 'Title', fieldName: 'Title', editable: true},
    { label: 'MailingStreet', fieldName: 'MailingStreet', editable: true},
    { label: 'MailingPostalCode', fieldName: 'MailingPostalCode', editable: true },
    { label: 'Phone', fieldName: 'Phone', editable: true},
    { label: 'Fax', fieldName: 'Fax', editable: true},
    { label: 'MobilePhone', fieldName: 'MobilePhone', editable: true },
    { label: 'Email', fieldName: 'Email', editable: true }
];

export default class RelatedContactsFromAccount extends LightningElement {
    @api recordId;
    @track error;
    @track columns = columns;
    @track draftValues = [];
    @track data;

    // accepted parameters
    get acceptedFormats() {
        return ['.csv'];
    }

    handleUploadFinished(event) {
        // Get the list of uploaded files
        const uploadedFiles = event.detail.files;

        // First parameter is the name of the parameter
        // after colon is the value you want it to have.
        // Comma separate for each parameter in the Apex method.
        readCSV({idContentDocument : uploadedFiles[0].documentId, recordId: this.recordId})
            .then(result => {
                window.console.log('result: '+ result);
                this.data = result;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success!!',
                        message: 'Contacts were created based on the CSV file.',
                        variant: 'success',
                    }),
                );
            })
            .catch(error => {
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'CSV failure: ',
                        message: JSON.stringify(error),
                        variant: 'error',
                    }),
                );
            })
    }

    handleSave(event) {
        const recordInputs = event.detail.draftValues.slice().map(draft => {
            const fields = Object.assign({}, draft);
            return { fields };
        });

        const promises = recordInputs.map(recordInput => updateRecord(recordInput));

        Promise.all(promises).then(contacts => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'All Contacts updated',
                    variant: 'success'
                })
            );

        }).catch(error => {
            this.error = error;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'CSV failure: ',
                    message: JSON.stringify(error),
                    variant: 'error',
                }),
            );
        });
    }
}