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
	@InvocableMethod(label='call REST' description='' category='Opportunity')
    public static void postOpportunityToPMS(List<id> opportunityIdList){
        List<Opportunity> opportunityList = [SELECT Id, Name, CloseDate, AccountId, Amount 
                                             FROM Opportunity where id in :opportunityIdList];
        HttpRequest req =  New Httprequest();
        Http http = new Http();
        req.setEndpoint('callout:ProjectService');
        req.setMethod('POST');
        req.setHeader('Accept', 'application/json');
        HttpResponse res = new HttpResponse();
        req.setBody(JSON.serialize(getBodyString(opportunityList[0])));
        System.debug(res.getBody());
        res = http.send(req);      
    }
    
    
    public static Body getBodyString(Opportunity opp){
        Body body = new Body();
        body.opportunityId = opp.id;
        body.opportunityName = opp.Name;
        body.accountName = opp.Name;
        body.closeDate = String.valueOf(opp.CloseDate);
        body.amount = String.valueOf(opp.Amount);
        return body;
    }
    
    class Body{
        String opportunityId;
        String opportunityName;
        String accountName;
        String closeDate;
        String amount;
    }
}