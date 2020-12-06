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
    ServiceToken__c serviceToken = new  ServiceToken__c();
    serviceToken.Name = "ProjectServiceToken";
    serviceToken.Token__c='Test service token';
    insert ServiceToken__c;
  }

  @isTest
  public static void testProjectCalloutSuccess() {

  }
}