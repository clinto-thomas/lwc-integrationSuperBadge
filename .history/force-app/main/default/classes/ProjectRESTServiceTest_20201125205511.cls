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
  @TestSetup
  static void makeData(){
    Opportunity opp = new Opportunity();
    opp.name = 'Opp Name';
    opp.StageName = 'Prospecting';
    opp.closeDate = date.today();
    insert opp;
  }
  @isTest void validateRestService(){
    Opportunity opp = [SELECT id FROM Opportunity WHERE Name = 'Opp Name'];
    String projectRef  = 'i am projectRef';
    String projectName = 'i am projectName';
    String opportunityId = opp.Id;
    String startDate = String.valueOf(date.today());
    String endDate = String.valueOf(date.today());
    String amount = String.valueOf('100.5');
    String status = 'Running';

  }
}