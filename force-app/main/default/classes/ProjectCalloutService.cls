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

    @InvocableMethod(label='Post Opportunity To PMS')
    public static void PostOpportunityToPMS(List<id> opportunityIds){
        system.debug('inside PostOpportunityToPMS');
        List<Opportunity> opportunityList = [SELECT Account.Name, Id, Name, CloseDate, Amount FROM Opportunity 
                                            where id in : opportunityIds];
        system.enqueueJob(new QueueablePMSCall(opportunityList));
    }
    
    // future method can only support primitive datatypes so we are sending opp list in a serialized format
    @future( callout=true )
    public static void makeCallout(String serializedOpportunities){
        System.debug('inside makeCallout');
        List<Opportunity> opportunitiesToBeProcessed = (List<Opportunity>)
        (JSON.deserialize(serializedOpportunities, List<Opportunity>.class));
        System.debug(opportunitiesToBeProcessed);
        ServiceTokens__c serviceToken = ServiceTokens__c.getvalues('ProjectServiceToken');
        Map<HttpRequest,id> requests = new Map<HttpRequest,id>();
        HttpRequest req ;
        for(Opportunity opp : opportunitiesToBeProcessed){
            System.debug('inside opportunitiesToBeProcessed loop');
            req = new HttpRequest();
            req.setEndpoint('callout:callout:ProjectService');
            req.setMethod('POST');
            req.setHeader('Content-Type','application/json');
            req.setHeader('Token',serviceToken.token__c);
            req.setBody(JSON.serialize(new WrapperClass(opp.Id,opp.Name,opp.Account.Name,
                                                        String.valueOf(opp.closeDate),String.valueOf(opp.amount))));
            requests.put(req,opp.id);
        }

            Http http = new Http();
            HttpResponse res = new HttpResponse();
            List<Opportunity> opportunitiesToBeUpdated = new List<Opportunity>();

        for(HttpRequest reqt : requests.keySet()){
            try{
                res = http.send(reqt);
                Opportunity opp = new Opportunity(id=requests.get(req));
                if(res.getStatusCode()==201){
                    opp.StageName = 'Submitted Project';
                }
                else{
                    opp.StageName = 'Resubmit Project';
                }
                opportunitiesToBeUpdated.add(opp);
            }
            catch(Exception e){
                System.debug(e.getMessage());
            }
            if(opportunitiesToBeUpdated.size()>0){
                update opportunitiesToBeUpdated;
            }
        }
}

    public class QueueablePMSCall implements Queueable,Database.AllowsCallouts{
        List<Opportunity> oppList;
        public QueueablePMSCall(List<Opportunity> oppList){
            this.oppList = oppList;
        }
        public void execute(QueueableContext qc){
            System.debug('inside execute QueueablePMScall');
            makeCallout(JSON.serialize(oppList));
            System.debug('json serialized---->'+JSON.serialize(oppList));
        }
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
            this.closeDate = closeDate;
            this.amount = amount;
        }
    }
}