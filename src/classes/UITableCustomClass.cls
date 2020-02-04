/**
 * Created by gamedevmadeeasy on 1/30/20.
 */

public with sharing class UITableCustomClass {
    public class DataWrapper {
        public String OwnerId {get; set;}
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
        List<DataWrapper> filteredResults = new List<DataWrapper>();
        // Notes: In order to reduce the lines of code per function,
        // I have opted to break it up to make it more readable.
        List<User> users = getUsers();
        List<Lead> leads;
        List<Opportunity> opportunities;
        // Not a fan of deeply nested for loops, but in this case, it is needed
        // so we can accurately filter our results
        for(Integer i = 0; i < users.size(); i++) {
            wrapper = new DataWrapper();
            leads = getLeads(users[i].Id);
            opportunities = getOpportunities(users[i].Id);
            for (Lead lead : leads) {
                for (Opportunity opportunity : opportunities) {
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

                                    wrapper.OwnerId = users[i].Id;
                                    count += opportunity.Amount;
                                    name = users[i].Name;
                                    oppAmount += 1;
                                    leadAmount += 1;
                                    convRate = (oppAmount / leadAmount);
                                    mCreatedDate = lead.CreatedDate.date();
                                    // having wrapper and adding the filterData here causes
                                    // all data for Rebecca and Wesker to show up.
                                    // Should only have a single instance of Rebecca's and Wesker's data
                                    wrapper.OwnerName = name;
                                    wrapper.OpportunityAmount = oppAmount;
                                    wrapper.LeadAmount = leadAmount;
                                    wrapper.ConversionRate = (oppAmount / leadAmount);
                                    wrapper.MaxCreatedDate = lead.CreatedDate.date();
                                    wrapper.TotalValue = count;
                                    filteredData.add(wrapper);
                                }
                            }
                        }
                    }
                }
            }
        }

        // Creating a set to remove all duplicates.
        Set<DataWrapper> dataSet = new Set<DataWrapper>();

        // loop through the filtered data to add the non duplicates to the set.
        for (DataWrapper dWrapper : filteredData) {
            dataSet.add(dWrapper);
        }

        // loop through the set to add to our displayable list.
        for (DataWrapper finalData : dataSet) {
            filteredResults.add(finalData);
        }

        System.debug('filtered Data size: ' + filteredData.size());
        System.debug('filtered Data: ' + filteredData);
        System.debug('dataSet size: ' + dataSet.size());
        System.debug('dataSet Data: ' + dataSet);
        System.debug('filtered Results size: ' + filteredResults.size());
        System.debug('filtered Results: ' + filteredResults);
        return filteredResults;
    }
}