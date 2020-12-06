/**
 * @description       : 
 * @author            : CLINTO THOMAS
 * @group             : 
 * @last modified on  : 11-25-2020
 * @last modified by  : CLINTO THOMAS
 * Modifications Log 
 * Ver   Date         Author          Modification
 * 1.0   11-25-2020   CLINTO THOMAS   Initial Version
**/
global class BillingCalloutService {
    //Implement business and callout logic methods here
    @future(callout=true)
    global void callBillingService(List<Project__c> projectList){
        for(Project__c project : projectList){
            BillingServiceProxy.project projectParams = getDetailsForCallout(project);
            BillingServiceProxy.InvoicesPortSoap11 proxy = new BillingServiceProxy.InvoicesPortSoap11();
            String response = proxy.billProject(projectParams);
            if(response == 'OK'){
                project.Status__c = 'Billed';
            }
    }
}
        public BillingServiceProxy.project getDetailsForCallout(Project__c proj){
        BillingServiceProxy.project bp = new BillingServiceProxy.project();
        bp.username = 'bsUser1';
        bp.password = 'bsPass1';
        bp.billAmount = proj.Billable_Amount__c;
        bp.projectid = proj.ProjectRef__c ;
        return bp;
    }
}