/**
 * Created by gamedevmadeeasy on 1/2/20.
 */

public with sharing class ContactController {
    @AuraEnabled(Cacheable=true)
    public static List<Contact> getContactList() {
        return [
                SELECT Id, Name, Title, Phone, Email
                FROM Contact
                LIMIT 10
        ];
    }

    @AuraEnabled(Cacheable=true)
    public static List<Contact> findContacts(String searchKey) {
        String key = '%' + searchKey + '%';
        return [
                SELECT Id, Name, Title, Phone, Email
                FROM Contact
                WHERE Name LIKE :key
                LIMIT 10
        ];
    }

    @AuraEnabled(Cacheable=true)
    public static Contact getSingleContact() {
        return [
                SELECT Id, Name, Title, Phone, Email
                FROM Contact
                LIMIT 1
        ];
    }
}