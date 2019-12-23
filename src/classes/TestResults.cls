/**
 * Created by gamedevmadeeasy on 12/22/19.
 */

public with sharing class TestResults {
    public static void seeResults(){
        List<Account> acc = [SELECT Id FROM Account LIMIT 10];
        delete acc;
        Database.emptyRecycleBin(acc);
        System.debug(Limits.getDmlStatements() + ',' + Limits.getLimitDmlStatements());
    }
}