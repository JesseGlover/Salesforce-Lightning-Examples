/**
 * Created by gamedevmadeeasy on 2/3/20.
 */

public with sharing class Generation {
    private static String generateRandomString(Integer len) {
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
        String randStr = '';
        while (randStr.length() < len) {
            Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            randStr += chars.substring(idx, idx+1);
        }
        return randStr;
    }

    public static String getRandomUsers() {
        String result;
        Id validIDOne = '0056g000003aDuHAAU';
        Id validIDTwo = '0056g000003aDu2AAE';
        Id validIDThree = '0056g000003aDtxAAE';
        Id validIDFour = '0056g000003ZO9UAAW';
        Id validIDFive = '0056g000003aDtnAAE';
        return result;
    }

    private static Date randomDate(Date minDate, Date maxDate) {
        Integer rangeSize = minDate.daysBetween(maxDate) + 1;
        Decimal daysToAdd = rangeSize * Math.random();
        Date result = minDate.addDays(daysToAdd.intValue());
        return result;
    }

    public static void GenerateLeads(String Id) {
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 25; i++) {
            Lead lead = new Lead();
            lead.LastName = generateRandomString(10);
            lead.Company = generateRandomString(20);
            lead.OwnerId = Id;
            leads.add(lead);
        }
        Database.insert(leads);
    }

    public static Double GenerateRandomAmount() {
        Double result;
        Double finalDouble = 10000.00;
        result = finalDouble * Math.random();
        System.debug(result);
        return result;
    }

    public static void GenerateOpportunities(String Id) {
        Date today = Date.today();
        Date endDate = Date.newInstance(2020,02,18);
        List<Opportunity> opportunities = new List<Opportunity>();
        for (Integer i = 0; i < 5; i++) {
            Opportunity opportunity = new Opportunity();
            opportunity.Name = generateRandomString(20);
            Opportunity.CloseDate = randomDate(today, endDate);
            opportunity.StageName = 'Closed Won';
            opportunity.Amount = GenerateRandomAmount();
            opportunity.OwnerId = Id;
            opportunities.add(opportunity);
        }

        Database.insert(opportunities);
    }
}