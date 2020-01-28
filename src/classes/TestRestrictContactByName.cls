/**
 * Created by jglov on 12/24/2019.
 */

@IsTest
private class TestRestrictContactByName {

    @IsTest
    static void RestrictContactByNameTest()
    {
        List<Contact> listContact = new List<Contact>();
        Contact c1 = new Contact(FirstName ='Francesco', LastName ='Riggio' , Email ='Test@test.com');
        Contact c2 = new Contact(FirstName ='Francesco1', LastName = 'INVALIDNAME', Email ='Test@test.com');
        listContact.add(c1);
        listContact.add(c2);

        Test.startTest();

        try
        {
            insert listContact;
        }

        catch(Exception ee)
        {
        }

        Test.stopTest();
    }
}