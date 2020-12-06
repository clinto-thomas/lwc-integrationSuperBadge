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
        //String username = 'pmsUser1';
        //String password = 'pmsPass1';
        //Blob headerValue = Blob.valueOf(username+':'+password);
        //String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
        //req.setHeader('Authorization', authorizationHeader);
        req.setHeader('Accept', 'application/json');
        HttpResponse res = new HttpResponse();
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