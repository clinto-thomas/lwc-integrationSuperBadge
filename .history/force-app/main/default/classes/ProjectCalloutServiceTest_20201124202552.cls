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
  
  public static final Integer BULK_COUNT = 100;

  @TestSetup
  static void makeData(){
    ServiceTokens__c  serviceToken = new  ServiceTokens__c ();
    serviceToken.Name = 'ProjectService';
    serviceToken.Token__c='gdgdd';
    insert ServiceToken;
  }

  @isTest
  public static void testProjectCalloutSuccess() {
    List<Account> testAccountsTobeCreated = new List<Account>();
    List<Opportunity> testOpportunitiesTobeCreated = new List<Opportunity>();
    for (Integer i = 0; i < BULK_COUNT; i++) {
      Account acc = new Account();
      acc.name='Test Account'+i;
      testAccountsTobeCreated.add(acc);
    }

    insert testAccountsTobeCreated;

    For(Account acc : testAccountsTobeCreated){
      Opportunity opp = new Opportunity();
      opp.AccountId = acc.id;
      opp.Name = 'Test opportunity'+' '+acc.Name;
      opp.Amount = 100;
      opp.StageName = 'Closed Won';
      opp.CloseDate = date.today();
      testOpportunitiesTobeCreated.add(opp);
    }
    insert testOpportunitiesTobeCreated;

    List<id> opportunityIds = new List<id>();
    for(Opportunity opp : testOpportunitiesTobeCreated){
      opportunityIds.add(opp.id);
    }

    ProjectCalloutService.PostOpportunityToPMS(opportunityIds);
    Test.startTest();
    Test.setMock(HTTPCalloutMock.class, new ProjectCalloutServiceMock());
    system.enqueueJob(new ProjectCalloutService.QueueablePMSCall(testOpportunitiesTobeCreated));
    ProjectCalloutService.makeCallout(JSON.serialize(testOpportunitiesTobeCreated));
    Test.stopTest();
  }
}