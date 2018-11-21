//
// (c) 2018 Appirio, Inc.
//
// Test Class Name: Twitch_AgreementTriggerHandler_Test.cls
// For Apex Class: Twitch_AgreementTriggerHandler.cls
// Description: This apex class is Test class for Twitch_AgreementTriggerHandler.cls
//
// 15th Mar 2018  Abhimanyu Tanwar   Original (Task # T-XXXXX) - Please see the task description for more details.
//
@isTest
private class Twitch_AgreementTriggerHandler_Test {
  
  //Test setup method
  @testSetup static void setup() {
    
    Id oppISCARecType = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Label.OPP_IS_CA_REC_TYPE).getRecordTypeId(); 
    List<Account> listAccounts = Twitch_TestUtils.createAccountRecords('Test Account', 1, true);
    
    List<Opportunity> opportunities = Twitch_TestUtils.createOpportunityRecords('Test Opportunity',
                                    'New-Single', System.Today(), listAccounts.get(0).Id, 200, false);
                                    
    for(Opportunity opp: opportunities) {
        opp.BroadcastStartDate__c = System.today();
    }
    insert opportunities;   
    
    List<OpportunityChannel__c> channelList = new List<OpportunityChannel__c>();
    for(Opportunity opp: opportunities) {
        opp.RecordTypeId = oppISCARecType;
        OpportunityChannel__c channel = new OpportunityChannel__c();
        channel.Opportunity__c = opp.Id;
        channel.Streamer__c = listAccounts.get(0).Id;
        channel.TwitchUserIDManualEntry__c = 'x123345';
        channel.TwitchUsernameManualEntry__c = 'x123345';
        channelList.add(channel);
    }
    insert channelList;
    
    Id agreementTwitchCLTecType = Schema.SObjectType.Apttus__APTS_Agreement__c.getRecordTypeInfosByName().get(Label.AGREEMENT_REC_TYPE_TWITCH_CL).getRecordTypeId(); 
    List<Apttus__APTS_Agreement__c> agreements = Twitch_TestUtils.createAgreementRecords('Agreement #',null, 200,false);
    
    for(integer i = 0; i< 200; i++) {
      agreements.get(i).Apttus__Related_Opportunity__c = opportunities.get(i).Id;
      agreements.get(i).RecordTypeId = agreementTwitchCLTecType;
      agreements.get(i).Apttus__Contract_Start_Date__c = System.today();
      agreements.get(i).Apttus__Version_Number__c = 1;
    }
    
    insert agreements;
    
    for(integer i = 0; i< 200; i++) {
      agreements.get(i).Apttus__Status_Category__c = Label.AGREEMENT_CATEGORY_IN_EFFECT ;
      agreements.get(i).Apttus__Status__c = Label.AGREEMENT_STATUS_ACTIVATED;
      agreements.get(i).Apttus__Contract_End_Date__c = System.today();
      agreements.get(i).Apttus_Approval__Approval_Status__c = 'Approved';
    }
    update agreements;
  }
  
  // Test Method
  @isTest static void testMethod1() {
    Id agreementTwitchCLRecType = Schema.SObjectType.Apttus__APTS_Agreement__c.getRecordTypeInfosByName().get(Label.AGREEMENT_REC_TYPE_TWITCH_CL).getRecordTypeId(); 
    Id oppISCARecType = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Label.OPP_IS_CA_REC_TYPE).getRecordTypeId(); 
    
    System.assertEquals(200,[SELECT Id FROM Opportunity WHERE StageName =:Label.OPP_STAGE_SIGNED ].size());
    
    List<Account> listAccounts = Twitch_TestUtils.createAccountRecords('Test Account', 1, true);
  
    List<Opportunity> opportunities = Twitch_TestUtils.createOpportunityRecords('Test Opportunity', 
                                      'New-Single', System.Today(), listAccounts.get(0).Id, 200, false);
                                    
    for(Opportunity opp: opportunities) {
        opp.BroadcastStartDate__c = System.today();
    }
    insert opportunities;

    List<Apttus__APTS_Agreement__c> agreements = Twitch_TestUtils.createAgreementRecords('Agreement2 #',null, 200,false);
    
    for(integer i = 0; i< 200; i++) {
      agreements.get(i).Apttus__Status_Category__c = Label.AGREEMENT_CATEGORY_IN_EFFECT;
      agreements.get(i).Apttus__Status__c = Label.AGREEMENT_STATUS_ACTIVATED;
      agreements.get(i).Apttus__Contract_End_Date__c = System.today();
      agreements.get(i).Apttus_Approval__Approval_Status__c = 'Approved';
      agreements.get(i).Apttus__Related_Opportunity__c = opportunities.get(i).Id;
      agreements.get(i).RecordTypeId = agreementTwitchCLRecType;
      agreements.get(i).Apttus__Contract_Start_Date__c = System.today();
    }
    
    try{
      insert agreements;
    }
    catch(Exception e) {
      System.assertEquals(true,e.getMessage().contains(Label.ONE_ACTIVE_AGREEMENT_ERROR));
    }
  }
}