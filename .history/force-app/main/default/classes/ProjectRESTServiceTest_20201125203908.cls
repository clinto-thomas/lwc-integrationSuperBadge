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
@isTest
private class ProjectRESTServiceTest {
  @isTest static void validatePostProjectData(){
    Opportunity opportunity = new Opportunity();
    opportunity.Name = 'new Opportunity';
    insert opportunity;

    Project__c project = new Project__c();
    project.Name = 'project Name';
    project.End_Date__c = date.today();
    project.Start_Date__c = date.today();
    project.Billable_Amount__c = 100.10;
    project.Opportunity__c = opportunity.id;
    insert project;
    String serializedProjectRecord = JSON.serialize(project);
    RestRequest request = new RestRequest();
    request.requestURI = '/services/apexrest/project';
    request.httpMethod = 'POST';  
    request.addHeader('Content-Type', 'application/json');
    request.addHeader('Accept', 'application/json');
    request.requestBody = Blob.valueOf(serializedProjectRecord);
    Test.startTest();
    String responseStatus = ProjectRESTService.postProjectData();

  }
}