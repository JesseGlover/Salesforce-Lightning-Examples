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
}