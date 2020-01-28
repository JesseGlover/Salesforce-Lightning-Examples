/**
 * Created by gamedevmadeeasy on 1/20/20.
 */

public with sharing class GetSalesforceData {
    @AuraEnabled(Cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name, Phone, Industry FROM Account LIMIT 50000];
    }

    @AuraEnabled(Cacheable=true)
    public static List<Contact> getContacts() {
        return [SELECT Name FROM Contact LIMIT 50000];
    }

    @AuraEnabled(Cacheable=true)
    public static List<Opportunity> getOpportunities() {
        return [SELECT Name FROM Opportunity LIMIT 50000];
    }

    @AuraEnabled(Cacheable=true)
    public static List<User> getUsers() {
        return [SELECT Name FROM User LIMIT 50000];
    }

    @AuraEnabled(Cacheable=true)
    public static List<Lead> getLeads() {
        return [SELECT Name FROM Lead LIMIT 50000];
    }

    @AuraEnabled(Cacheable=true)
    public static List<Contact> getContactOpportunities() {
        return [SELECT Id, Name, (SELECT Id, Name FROM Opportunities) FROM Contact LIMIT 50000];
    }
}