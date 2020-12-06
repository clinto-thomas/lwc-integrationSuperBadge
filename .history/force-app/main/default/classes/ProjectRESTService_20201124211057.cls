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
        String projectRef = req.params.get('projectRef');
        String projectName = req.params.get('projectName');
        String opportunityId = req.params.get('opportunityId');
        String startDate = req.params.get('startDate');
        String endDate = req.params.get('endDate');
        String amount = req.params.get('amount');
        String status  = req.params.get('status');
    }
    public static void listProjectRecords(String projectRef,String projectName,String opportunityId,
                                         String startDate,String endDate,String amount,String status){
                                            
    }
}