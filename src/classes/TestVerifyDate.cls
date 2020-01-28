/**
 * Created by jglov on 12/24/2019.
 */

@IsTest
private class TestVerifyDate {
    @IsTest
    static void testOldDate(){
        Date dateTest = VerifyDate.CheckDates(Date.today(), Date.today().addDays(-1));
        System.assertEquals(Date.newInstance(2016, 4, 30), dateTest);
    }

    @IsTest
    static void testLessThan30Days(){
        Date dateTest = VerifyDate.CheckDates(Date.today(), Date.today().addDays(20));
        System.assertEquals(Date.today().addDays(20), dateTest);
    }

    @IsTest
    static void testMoreThan30Days(){
        Date dateTest = VerifyDate.CheckDates(Date.today(), Date.today().addDays(31));
        System.assertEquals(Date.newInstance(2016, 4, 30), dateTest);
    }
}