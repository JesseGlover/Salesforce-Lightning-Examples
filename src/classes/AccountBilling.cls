/**
 * Created by gamedevmadeeasy on 1/9/20.
 */

public with sharing class AccountBilling {
    @AuraEnabled(Cacheable=true)
    public static String[] getAllCountryCodes() {
        String[] values = new List<String>();
        Schema.DescribeFieldResult fieldResult = User.Countrycode.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        System.debug('Picklist::' + ple);
        for( Schema.PicklistEntry f : ple){
            values.add(f.getLabel());
        }
        return values;
    }

    @AuraEnabled(Cacheable=true)
    public static String[] getAllStateCodes() {
        String[] stateCodes = new List<String>();
        Schema.DescribeFieldResult fieldResult = User.statecode.getDescribe();
        List<Schema.PicklistEntry> picklistEntries = fieldResult.getPicklistValues();
        System.debug('Picklist::' + picklistEntries);

        for (Schema.PicklistEntry fEntry : picklistEntries) {
            stateCodes.add(fEntry.getLabel());
        }

        return stateCodes;
    }

    @AuraEnabled(Cacheable=true)
    public static Contact createContact(Contact records) {
        Contact contact = new Contact();
        contact.LastName = records.LastName;
        contact.FirstName = records.FirstName;
        contact.Email = records.Email;
        contact.Phone = records.Phone;
        contact.MailingStreet = records.MailingStreet;
        contact.MailingCity = records.MailingCity;
        contact.MailingCountry = records.MailingCountry;
        contact.MailingState = records.MailingState;
        contact.MailingPostalCode = records.MailingPostalCode;
        contact.OtherStreet = records.OtherStreet;
        contact.OtherState = records.OtherState;
        contact.OtherCity = records.OtherCity;
        contact.OtherCountry = records.OtherCountry;
        contact.OtherPostalCode = records.OtherPostalCode;

        upsert contact;
        return contact;
    }
}