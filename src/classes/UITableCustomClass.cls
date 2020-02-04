/**
 * Created by gamedevmadeeasy on 1/30/20.
 */

public with sharing class UITableCustomClass {
    public class DataWrapper {
        @AuraEnabled public String OwnerName { get; set; }
        @AuraEnabled public Double OpportunityAmount { get; set; }
        @AuraEnabled public Double LeadAmount { get; set; }
        @AuraEnabled public Double ConversionRate { get; set; }
        @AuraEnabled public Date MaxCreatedDate { get; set; }
        @AuraEnabled public Double TotalValue { get; set; }
    }

    /**
        * Gets all opportunities in the org
        * @return the following information regarding opportunities:
        * Id, OwnerId, TotalOpportunityQuantity,CreatedDate,
        * Amount, CloseDate, StageName
        */
    @TestVisible
    private static List<Opportunity> getOpportunities(String ownerId) {
            return [SELECT Id, OwnerId,TotalOpportunityQuantity, CreatedDate,
                    Amount, CloseDate, StageName
            FROM Opportunity WHERE OwnerId =: ownerId];
        }

    /**
    * Gets all Lead in the org
    * @return the following information regarding Leads:
    * Id, LeadSource, OwnerId, CreatedDate, IsConverted
    */
    @TestVisible
    private static List<Lead> getLeads(String ownerId) {
        return
        [SELECT Id, LeadSource, OwnerId, CreatedDate, IsConverted FROM Lead
        WHERE OwnerId =: ownerId];
    }

    /**
    * Gets all Users with a User License in the org
    * @return the following information regarding Users:
    * Id, Name, Profile.UserLicense.Name
    */
    @AuraEnabled(Cacheable = true)
    public static List<User> getUsers() {
        List<User> users = [SELECT Id, Name, Profile.UserLicense.Name FROM User];
        System.debug(users);
        System.debug(users.size());
        return users;
    }

    /**
     * Calls the userList, getLeads and getOpportunity functions.
     * @return a List of SObjects. Results of function is to:
     * filter down the data to display only the users, opportunities and leads
     * that correspond with one another.
     * This function is called in the LWC named uiTableLWC
     */
    @AuraEnabled(Cacheable = true)
    public static List<DataWrapper> filterAllData(String createdDate, String closedDate) {
        String name;
        DataWrapper wrapper;
        Double oppAmount = 0.0;
        Double leadAmount = 0.0;
        Double convRate = 0.0;
        Date mCreatedDate;
        Decimal count = 0.0;
        List<DataWrapper> filteredData = new List<DataWrapper>();
        // Notes: In order to reduce the lines of code per function,
        // I have opted to break it up to make it more readable.
        List<User> users = getUsers();
        List<Lead> leads;
        List<Opportunity> opportunities;
        // Not a fan of deeply nested for loops, but in this case, it is needed
        // so we can accurately filter our results
        for(Integer i = 0; i < users.size(); i++) {
            leads = getLeads(users[i].Id);
            opportunities = getOpportunities(users[i].Id);
            for (Opportunity opportunity : opportunities) {
                for (Lead lead : leads) {
                    // Notes: If statements follow for filtering down further.
                    if (users[i].Id == opportunity.OwnerId && users[i].Id == lead.OwnerId) {
                        // the filter result should now only have
                        // users, opportunities and leads that
                        // actually correspond to one another.
                        if (opportunity.StageName == 'Closed Won') {
                            String closeDate = String.valueOf(opportunity.CloseDate);
                            String createDate = String.valueOf(lead.CreatedDate.date());
                            if (createdDate == createDate) {
                                if (closedDate == closeDate) {
                                    // the filter result should also only have
                                    // Opportunities where the stage is Closed Won.
                                    count += opportunity.Amount;
                                    name = users[i].Name;
                                    oppAmount += 1;
                                    leadAmount += 1;
                                    convRate = (oppAmount / leadAmount);
                                    mCreatedDate = lead.CreatedDate.date();
                                    // having wrapper and adding the filterData here causes
                                    // all data for Rebecca and Wesker to show up.
                                    // Should only have a single instance of Rebecca's and Wesker's data
                                    wrapper = new DataWrapper();
                                    wrapper.OwnerName = name;
                                    wrapper.OpportunityAmount = oppAmount;
                                    wrapper.LeadAmount = leadAmount;
                                    wrapper.ConversionRate = convRate;
                                    wrapper.MaxCreatedDate = mCreatedDate;
                                    wrapper.TotalValue = count;
                                    filteredData.add(wrapper);
                                }
                            }
                        }
                    }
                }
            }
            // filterData and wrapper here causes a dual instance of Wesker's data to appear
            // and 7 instances of Rebecca's data to appear
        }
        // filterData here causes only a single instance of Wesker's data to appear
        // Rebecca's data does not appear at all.

        System.debug(filteredData);
        return filteredData;
    }
}