/**
 * Created by gamedevmadeeasy on 1/27/20.
 */

public inherited sharing class ImportRelatedContacts {

    @AuraEnabled
    public static List<Contact> readCSVFile(Id idContentDocument, String recordId) {
        // Needed to associate the Contact with the Account.
        Account account = [SELECT Name FROM Account WHERE Id =: recordId];
        List<Contact> contactsToInsert = new List<Contact>();

        if(idContentDocument != null) {
            // getting File Data based on file id
            ContentVersion objVersion = [SELECT Id, VersionData
            FROM ContentVersion WHERE ContentDocumentId =:idContentDocument];
            // split the file data
            List<String> lstCSVLines = objVersion.VersionData.toString().split('\n');

            for(Integer i = 1; i < lstCSVLines.size(); i++){
                Contact contact = new Contact();
                List<String> csvRowData = lstCSVLines[i].split(',');
                System.debug('csvRowData: ' + csvRowData);
                contact.Salutation = csvRowData[0];
                contact.FirstName = csvRowData[1];
                contact.LastName = csvRowData[2];
                contact.Title = csvRowData[3];
                // Sets the contact's Account Id to be the Account's Id value.
                contact.AccountId = account.Id;
                contact.MailingStreet = csvRowData[5];
                contact.MailingCity = csvRowData[6];
                //contact.MailingState = csvRowData[7]; // Picklist value nulled in SF
                contact.MailingPostalCode = csvRowData[8];
                //contact.MailingCountry = csvRowData[9]; // Picklist value nulled in SF
                contact.Phone = csvRowData[10];
                contact.Fax = csvRowData[11];
                contact.MobilePhone = csvRowData[12];
                contact.Email = csvRowData[13];
                contactsToInsert.add(contact);
            }

            try {
                if(!contactsToInsert.isEmpty()) {
                    insert contactsToInsert;
                }
            }
            catch (Exception ex) {
                throw new AuraHandledException(ex.getMessage());
            }
        }
        return contactsToInsert;
    }
}