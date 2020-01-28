/**
 * Created by jglov on 12/24/2019.
 */

trigger AccountAddressTrigger on Account (before insert, before update) {
    // Loop through the Account that is tied to the new Trigger element
    for (Account account : Trigger.new) {
        // Match__Billing_Address__c is a custom field on the account object (Checkbox)
        // Check if MatchBillingAddress is true
        if (account.Match_Billing_Address__c == true) {
            // Set the shipping Postal Code to be the same as the Billing Postal Code
            // on the Account object.
            account.ShippingPostalCode = account.BillingPostalCode;
        }
    }
}