/**
 * Created by gamedevmadeeasy on 12/24/19.
 */

public with sharing class TreeGridWrapperExample {
    @AuraEnabled
    public static List<SObject> getTreeData() {
        List<Account> accountContact = [SELECT Id, Name,(SELECT Id, Name FROM Contacts) FROM Account];
        List<ContentDocument> docList = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        Set<SObject> allData = new Set<SObject>();

        for (Account acc : accountContact) {
            for (ContentDocument doc : docList) {
                    allData.add(acc);
                    allData.add(doc);
            }
        }
        return [SELECT Id, LinkedEntityId FROM ContentDocumentLink WHERE ContentDocumentId IN :allData];
    }
}