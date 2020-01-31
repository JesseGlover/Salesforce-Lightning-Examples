/**
 * Created by gamedevmadeeasy on 1/29/20.
 */

@IsTest
private class LeadOpportunityTableTest {
    /**
     * Generates all the data we will utilize in the test.
     * Users, Accounts, Opportunities and Leads. As well as sets the profile
     * type that we will need to use.
     */
    @TestSetup
    static void GenerateTestData() {

        Profile pf= [SELECT Id FROM Profile WHERE Name='Standard User'];

        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueOf(Datetime.now())
                .replace(' ','').replace(':','').replace('-','') ;
        Integer RandomId = Integer.valueOf
                (Math.rint(Math.random() * 1000000));
        String uniqueName = orgId + dateString+RandomId;
        User dan = new User(
                FirstName = 'Dan',
                LastName = 'Cook',
                Email = uniqueName + '@playground' + orgId + '.org',
                Username = uniqueName + '@playground' + orgId + '.org',
                EmailEncodingKey = 'ISO-8859-1',
                Alias = uniqueName.substring(18, 23),
                TimeZoneSidKey = 'America/Los_Angeles',
                LocaleSidKey = 'en_US',
                LanguageLocaleKey = 'en_US',
                ProfileId = pf.Id
        );

        insert dan;

        Account account = new Account();
        account.Name = 'Walmart';
        account.Phone = '757-777-3322';
        insert account;

        Lead newLead = new Lead();

        newLead.FirstName = 'Cole';
        newLead.LastName = 'Swain';
        newLead.Company = 'BlueWave';
        newLead.Status = 'contacted';
        newLead.PostalCode = '02052';

        insert newLead;

        Lead lead2 = new Lead();
        lead2.FirstName = 'James';
        lead2.LastName = 'Sullivan';
        lead2.Company = 'Walmart';
        lead2.Status = 'contacted';
        lead2.PostalCode = '02052';

        insert lead2;

        Opportunity opportunityToCreate = new Opportunity();
        opportunityToCreate.StageName = 'Prospect';
        opportunityToCreate.CloseDate = Date.today();
        opportunityToCreate.Account = [SELECT Id FROM Account LIMIT 1];
        opportunityToCreate.Name = 'Test';

        insert opportunityToCreate;
    }

    /**
     * Tests whether the created user is not equal to the user value
     * This will pass as not equals as one returns more data than just the Id
     */
    @IsTest
    static void TestGetUserData() {
        List<User> user = UITableCustomClass.getUsers();
        List<User> createdUser = [SELECT Id FROM User LIMIT 1];
        System.assertNotEquals(createdUser, user);
        System.debug('created user: ' + createdUser);
        System.debug('user: ' + user);
    }

    /**
     * The size is 6 due to the number of fields that is returned with
     * the user object.
     */
    @IsTest
    static void TestGetUserDataCount() {
        List<User> user = UITableCustomClass.getUsers();
        System.assertEquals(6, user.size());
        System.debug('user value: ' + user);
    }
}