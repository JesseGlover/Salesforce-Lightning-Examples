/**
 * Created by Jesse Glover on 12/19/19.
 */

public with sharing class AccountContactTableController {
    // AuraEnabled allows this server-side code to be exposed to Aura Components
    // Cacheable = true allows this server-side code to be exposed to LWC
    @AuraEnabled(Cacheable = true)
    public static List<AccountContactWrapper> getAccountContact() {
        // gets the Account and Contact information
        // the Id, Name, Billing City, Phone, Email and Department data
        // returns the information as a list.
        List<Account> accountContacts = [
                SELECT Id, Name, (
                        SELECT Contact.Name, Contact.Id
                        FROM Contacts
                )
                FROM Account
        ];
        // list of accountContactWrapper that will be returned
        List<AccountContactWrapper> accountContactWrapper =
                new List<AccountContactWrapper>();

        for (Account account : accountContacts) {
            // add the basic items from account to the AccountContactWrapper
            AccountContactWrapper wrapper = new AccountContactWrapper();
            wrapper.queriedName = account.Name;
            wrapper.queriedId = account.Id;
            // list of the subqueries for child elements
            List<AccountContactSubQuery> accountContactSubQueries =
                    new List<AccountContactSubQuery>();

            for (Contact contact : account.Contacts) {
                // add the contact items to the child elements, then
                // add it to the subquery list that was made above
                AccountContactSubQuery subQuery = new AccountContactSubQuery();
                subQuery.queriedId = contact.Id;
                subQuery.queriedName = contact.Name;
                accountContactSubQueries.add(subQuery);
            }
            // add the subquery items to the actual subquery list
            wrapper.subQueries = accountContactSubQueries;
            // add all data to the main list to be returned
            accountContactWrapper.add(wrapper);
        }
        // a debug statement which showcases that the data we want is returned
        // can be tested in Anonymous Apex to showcase this is true
        System.debug('Results for account contact wrapper is '
                + accountContactWrapper);
        return accountContactWrapper;
    }

    public class AccountContactWrapper {
        // The main class that sends and receives the name, id and subquery list
        // data to the above class
        @AuraEnabled
        public String queriedName {get; set;}
        @AuraEnabled
        public String queriedId {get; set;}
        @AuraEnabled
        public List<AccountContactSubQuery> subQueries {get; set;}
        // Use the name of the list as the separator in our JSON parse
        // and join statement on the client side.
    }

    public class AccountContactSubQuery {
        // class that handles pulling the subquery information from
        // our child elements.
        @AuraEnabled
        public String queriedName {get; set;}
        @AuraEnabled
        public String queriedId {get; set;}
    }
}