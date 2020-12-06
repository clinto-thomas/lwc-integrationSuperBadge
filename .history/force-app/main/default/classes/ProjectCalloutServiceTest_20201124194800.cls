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
@isTest private class ProjectCalloutServiceTest {
  //Implement mock callout tests here
  @testSetup
  static void makeData(){
    Account account = new Account();
    account.Name = 'Test Account';
    insert account;
    Opportunity opp = new Opportunity();
    opp.Name='i am opportunity';
    opp.accountId = account.id;
    opp.closeDate = date.today();
    opp.amount = 100;
    opp.StageName='Prospecting';
    insert opp;
  }
  
  @isTest static void validatePostOpportunityToPMS(){
    // Opportunity opp = [SELECT Account.Name, Id, Name, CloseDate, Amount FROM Opportunity 
    //                     where Name = 'i am opportunity'];
    // opp.Type = 'New Project';
    // opp.StageName = 'Closed Won';
    Account acc = [SELECT id FROM Account where name='Test Account'];
    List<Opportunity> opportunityListToInserted = new List<Opportunity>();
    for (Integer i = 0; i < 100; i++) {
      Opportunity opp = new Opportunity();
      opp.Name='i am opportunity'+i;
      opp.accountId = acc.id;
      opp.closeDate = date.today();
      opp.amount = 100;
      opp.StageName='Prospecting';
    }
    insert opportunityListToInserted;
    Test.startTest();
    Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMock());
    system.enqueueJob(newProjectCalloutService.QueueablePMSCall(opportunityListToInserted));
    ProjectCalloutService.makeCallout( JSON.serialize( opportunityListToInserted ) );        
    Test.stopTest();
  }
}