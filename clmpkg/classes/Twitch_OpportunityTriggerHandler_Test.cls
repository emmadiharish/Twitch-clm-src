//
// (c) 2018 Appirio, Inc.
//
// Test Class Name: Twitch_OpportunityTriggerHandler_Test.cls
// For Apex Class: Twitch_OpportunityTriggerHandler.cls
// Description: This apex class is Test class for Twitch_OpportunityTriggerHandler.cls
//
// 15th Mar 2018  Abhimanyu Tanwar   Original (Task # T-XXXXX) - Please see the task description for more details.
//
@isTest
private class Twitch_OpportunityTriggerHandler_Test {
  
  //Test setup method
  @testSetup static void setup() {
    
    List<Account> listAccounts = Twitch_TestUtils.createAccountRecords('Test Account', 1, true);
    
    List<Opportunity> opportunities = Twitch_TestUtils.createOpportunityRecords('Test Opportunity',
                                    'New-Single', System.Today(), listAccounts.get(0).Id, 200, false);
    insert opportunities;
    
    Id agreementTwitchCLTecType = Schema.SObjectType.Apttus__APTS_Agreement__c.getRecordTypeInfosByName().get(Label.AGREEMENT_REC_TYPE_TWITCH_CL).getRecordTypeId(); 
    List<Apttus__APTS_Agreement__c> agreements = Twitch_TestUtils.createAgreementRecords('Agreement #',null, 200,false);
    
    for(integer i = 0; i< 200; i++) {
      agreements.get(i).Apttus__Related_Opportunity__c = opportunities.get(i).Id;
      agreements.get(i).RecordTypeId = agreementTwitchCLTecType;
      agreements.get(i).Apttus__Contract_Start_Date__c = System.today();
    }
    insert agreements;
  }
  
  // Test Method
  @isTest static void testMethod1() {
      
      List<Opportunity> opportunities = [SELECT Id FROM Opportunity LIMIT 200];
      for(Opportunity opp : opportunities) {
        opp.StageName = 'Dropped';
      }
      update opportunities;
      
      System.assertEquals(200,[SELECT Id FROM Apttus__APTS_Agreement__c WHERE Apttus__Status_Category__c = 'Cancelled' AND Apttus__Status__c = 'Cancelled Request'].size());
  }
}