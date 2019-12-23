/**
 * Created by gamedevmadeeasy on 12/22/19.
 */

public with sharing class TestResults {
    /*
    Question 2 on the flash cards asks:
    "A developer runs the following anonymous code block. What is the result?"
    The answer says 2150.
    However, when copying the code to use on a fresh developer edition with default
    Salesforce data and running it in IntelliJ with Illuminated Cloud 2, the
    Developer Console and Visual Studio Code with the proper extensions,
    you actually get:
    Error on line 2, column 1: System.DmlException: Delete failed.
    First exception on row 0 with id 0016g000006pPoSAAU;
    first error: DELETE_FAILED, Your attempt to delete Edge Communications could
    not be completed because it is associated with the following cases.:
     00001000, 00001017, 00001018
    Your attempt to delete Edge Communications could not be completed
    because some opportunities in that account were closed won.
    The opportunities that could not be deleted are shown below.:
    Edge Emergency Generator, Edge Installation, Edge SLA
    : []
    AnonymousBlock: line 2, column 1
    So, there is no way to verify that answer is correct and understanding
    why that it is the correct answer.
     */
    public static void seeResults(){
        List<Account> acc = [SELECT Id FROM Account LIMIT 10];
        delete acc;
        Database.emptyRecycleBin(acc);
        System.debug(Limits.getDmlStatements() + ',' + Limits.getLimitDmlStatements());
    }
}