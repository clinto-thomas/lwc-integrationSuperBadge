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
@RestResource(urlMapping='/project/')
global class ProjectRESTService {
    //Implement service logic here
    List<Project__c> projectRecordTobeCreated = new List<Project__c>();
    @HttpPost
    global static void postProjectData(){
        RestRequest req = RestContext.request;
        RestResonse res = RestContext.response;
        String ProjectRef = req.params.get('projectRef');
        String ProjectName = req.params.get('projectName');
        String OpportunityId = req.params.get('opportunityId');
        String StartDate = req.params.get('startDate');
        String EndDate = req.params.get('endDate');
        String Amount = req.params.get('amount');
        String Status  = req.params.get('status');
    }
    global static void createProjectRecord(String projectRef, String projectName, 
                                        String opportunityId, String startDate, String){
        Project__c project = new Project();                              

    }
}