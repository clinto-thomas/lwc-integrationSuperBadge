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
    if(Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate){
            for(Project__c project : Trigger.new){
                if(project.Status__c = 'Billable'){
                    BillingCalloutService.callBillingService(Trigger.new);
                }
            }
        }
    }
}