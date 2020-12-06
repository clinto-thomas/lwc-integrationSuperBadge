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
}