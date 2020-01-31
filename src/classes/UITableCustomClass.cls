/**
 * Created by gamedevmadeeasy on 1/30/20.
 */

public with sharing class UITableCustomClass {
    public class DataWrapper {
        @AuraEnabled public String OwnerName { get; set; }
        @AuraEnabled public Double OpportunityAmount { get; set; }
        @AuraEnabled public Double LeadAmount { get; set; }
        @AuraEnabled public Double ConversionRate { get; set; }
        @AuraEnabled public Datetime MaxCreatedDate { get; set; }
        @AuraEnabled public Double TotalValue { get; set; }

        public DataWrapper(String ownerName, Double opportunityAmount, Double leadAmount,
                Double conversionRate, Datetime maxCreatedDate, Decimal totalValue) {
            this.OwnerName = ownerName;
            this.OpportunityAmount = opportunityAmount;
            this.LeadAmount = leadAmount;
            this.ConversionRate = conversionRate;
            this.MaxCreatedDate = maxCreatedDate;
            this.TotalValue = totalValue;
        }
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
    public static List<DataWrapper> filterAllData() {
        String name;
        Double oppAmount;
        Double leadAmount;
        Double convRate;
        Datetime mCreatedDate;
        Decimal count = 0.0;

        List<DataWrapper> filteredData = new List<DataWrapper>();
        // Notes: In order to reduce the lines of code per function,
        // I have opted to break it up to make it more readable.
        List<User> users = getUsers();
        List<Lead> leads;
        List<Opportunity> opportunities;

        // Not a fan of deeply nested for loops, but in this case, it is needed
        // so we can accurately filter our results
        for(User user : users) {
            leads = getLeads(user.Id);
            opportunities = getOpportunities(user.Id);
            for (Opportunity opportunity : opportunities) {
                for (Lead lead : leads) {
                    // Notes: If statements follow for filtering down further.
                    if (user.Id == opportunity.OwnerId && user.Id == lead.OwnerId) {
                        // the filter result should now only have
                        // users, opportunities and leads that
                        // actually correspond to one another.
                        if (opportunity.StageName == 'Closed Won') {
                            // the filter result should also only have
                            // Opportunities where the stage is Closed Won.
                            count = count + opportunity.Amount;
                            name = user.Name;
                            oppAmount = opportunities.size() + 0.0;
                            leadAmount = leads.size() + 0.0;
                            convRate = (oppAmount / leadAmount);
                            mCreatedDate = lead.CreatedDate;
                        }
                    }
                }
            }
        }
        DataWrapper wrapper = new DataWrapper(name, oppAmount, leadAmount,
                convRate, mCreatedDate, count);
        filteredData.add(wrapper);
        return filteredData;
    }
}