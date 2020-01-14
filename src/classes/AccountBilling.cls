/**
 * Created by gamedevmadeeasy on 1/9/20.
 */

public with sharing class AccountBilling {
    @AuraEnabled(Cacheable=true)
    public static void saveAccountRecord(Account accountObject){
        try{
            insert accountObject;
        }
        catch(Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }
}