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
    insert opp;
  }
  static void validatePostOpportunityToPMS(){
    Opportunity opp = [SELECT Account.Name, Id, Name, CloseDate, Amount FROM Opportunity 
                        where Name = 'i am opportunity'];
    opp.Type = 'New Project';
    opp.StageName = 'Closed Won';
    update opp; 
  }
}