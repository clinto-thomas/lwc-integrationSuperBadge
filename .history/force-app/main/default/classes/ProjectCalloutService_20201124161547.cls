/**
 * @description       : 
 * @author            : CLINTO THOMAS
 * @group             : 
 * @last modified on  : 11-24-2020
 * @last modified by  : CLINTO THOMAS
 * Modifications Log 
 * Ver   Date         Author          Modification
 * 1.0   11-24-2020   CLINTO THOMAS   Initial Version
**/
public class ProjectCalloutService {
    //Complete the implementation for business and callout logic
    @InvocableMethod
    public static void PostOpportunityToPMS(List<id> opportunityIds){
        List<Opportunity> opportunityList = [SELECT Account.Name, Id, Name, CloseDate, Amount FROM Opportunity 
                                            where id in : opportunityIds];
    }

    class WrapperClass{
        public String opportunityId;
        public String opportunityName;
        public String accountName;
        public String closeDate;
        public String amount;
        public WrapperClass(String opportunityId,String opportunityName,String accountName,
                                                            String closeDate,String amount){
            this.opportunityId = opportunityId;
            this.opportunityName = opportunityName;
            this.accountName = accountName;
            this.closeDate = closeDate
            this.amount = amount;
        }
    }
}