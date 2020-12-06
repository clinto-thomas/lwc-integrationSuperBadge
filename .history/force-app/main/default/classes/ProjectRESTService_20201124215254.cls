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
@RestResource(urlMapping='/project/*')
global class ProjectRESTService {
    @HttpPost
    global static string postProjectData(String projectRef,String projectName,String opportunityId,
    String startDate,String endDate,String amount,String status){
        Savepoint sp = Database.setSavePoint();
        Project__c project = new Project__c(); 
        project.ProjectRef__c = projectRef;
        project.Name__c = projectName;
        project.Opportunity__c = opportunityId;
        project.Start_Date__c = Date.valueOf(startDate);
        project.End_Date__c = Date.valueOf(endDate);
        project.Billable_Amount__c = Double.valueOf(amount);
        project.Status__c = status;
        try{
            insert project;
            return 'OK';
        }catch(Exception e){
            System.debug(e.getMessage());
        }
    }
}