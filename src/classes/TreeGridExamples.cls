/**
 * Created by gamedevmadeeasy on 12/23/19.
 */

// Server-side controller class
public class TreeGridExamples {

    @AuraEnabled
    // @AuraEnabled - Marks the code as being able to be accessed by the Client-side controller
    // SObject is the base type above Object in Salesforce, most generic you can get in the ecosystem.
    public static List<SObject> getTreeData() {
        // Doing a nested SOQL query for Account and Contact information.
        // Where the contact information is a child of Account in this query.
        return [SELECT Id, Name,(SELECT Id, Name FROM Contacts) FROM Account];
    }
}