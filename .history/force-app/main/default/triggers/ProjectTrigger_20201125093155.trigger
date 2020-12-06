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
trigger ProjectTrigger on Project__c (after update,before update,before insert) {
    //Call the Billing Service callout logic here
    List<Project__c> projectInTheScope = new List<Project__c>();
    if(Trigger.isBefore && Trigger.isUpdate || Trigger.isBefore && Trigger.isInsert) {
        for(Project__c proj : Trigger.new){
            if(proj.Status__c == 'Billable'){
                projectInTheScope.add(proj);
            }
        }
    }
    if(!projectInTheScope.isEmpty()){
        BillingCalloutService.callBillingService(JSON.serialize(projectInTheScope));
    }
}