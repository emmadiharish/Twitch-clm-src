//
// (c) 2018 Appirio, Inc.
//
// Test Class Name: Twitch_RelatedAgreementHandler_Test.cls
// For Apex Class: Twitch_RelatedAgreementTriggerHandler.cls
// Description: This apex class is Test class for Twitch_RelatedAgreementTriggerHandler.cls
//
// 27th Apr 2018  Abhimanyu Tanwar   Original (Task # T-XXXXX) - Please see the task description for more details.
//
@isTest
private class Twitch_RelatedAgreementHandler_Test {
  
  //Test setup method
  @testSetup static void setup() {
    Id oppISCARecType = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Label.OPP_IS_CA_REC_TYPE).getRecordTypeId(); 
    List<Account> listAccounts = Twitch_TestUtils.createAccountRecords('Test Account', 1, true);
    
    List<Opportunity> opportunities = Twitch_TestUtils.createOpportunityRecords('Test Opportunity',
                                    'New-Single', System.Today(), listAccounts.get(0).Id, 200, false);
                                    
    for(Opportunity opp: opportunities) {
      opp.BroadcastStartDate__c = System.today();
      opp.RecordTypeId = oppISCARecType;
      opp.StageName = 'Contract';
      opp.Category__c = 'Gaming';
      opp.Country__c = 'IN';
      opp.Region__c = 'APAC';
      opp.EstimatedMinutesWatched__c = 123;
      opp.PrimaryContentType__c = 'Live';
      opp.BusinessJustification__c = '123';
      opp.PartnerTier__c = '3';
      opp.YouTubeExists__c = 'No';
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
      agreements.get(i).Apttus__Status_Category__c = 'In Effect';
      agreements.get(i).Apttus__Status__c = 'Being Amended';
      agreements.get(i).Apttus__Contract_End_Date__c = System.today();
      agreements.get(i).Apttus_Approval__Approval_Status__c = 'Approved';
    }
    insert agreements;
    
    for(Opportunity opp: opportunities) {
      opp.StageName = 'Contract';
    }
    update opportunities;
    
    List<Apttus__APTS_Agreement__c> agreements2 = Twitch_TestUtils.createAgreementRecords('Agreement # 2-',null, 200,false);
    for(integer i = 0; i< 200; i++) {
      agreements2.get(i).Apttus__Related_Opportunity__c = opportunities.get(i).Id;
      agreements2.get(i).RecordTypeId = agreementTwitchCLTecType;
      agreements2.get(i).Apttus__Contract_Start_Date__c = System.today();
      agreements2.get(i).Apttus__Status_Category__c = 'In Effect';
      agreements2.get(i).Apttus__Status__c = 'Activated';
      agreements2.get(i).Apttus__Contract_End_Date__c = System.today();
      agreements2.get(i).Apttus_Approval__Approval_Status__c = 'Approved';
    }
    insert agreements2;
    
    List<Apttus__APTS_Related_Agreement__c> relatedAgreement = new List<Apttus__APTS_Related_Agreement__c>();
    for(integer i = 0; i< 100; i++) {
      Apttus__APTS_Related_Agreement__c agreementRel = new Apttus__APTS_Related_Agreement__c();
      agreementRel.Apttus__APTS_Contract_To__c = agreements.get(i).Id;
      agreementRel.Apttus__APTS_Contract_From__c = agreements2.get(i).Id;
      agreementRel.Apttus__Relationship_From_Type__c = 'Is Renewed By';
      relatedAgreement.add(agreementRel);
    }
    for(integer i = 100; i< 200; i++) {
      Apttus__APTS_Related_Agreement__c agreementRel = new Apttus__APTS_Related_Agreement__c();
      agreementRel.Apttus__APTS_Contract_To__c = agreements.get(i).Id;
      agreementRel.Apttus__APTS_Contract_From__c = agreements2.get(i).Id;
      agreementRel.Apttus__Relationship_From_Type__c = 'Is Amended By';
      relatedAgreement.add(agreementRel);
    }
    insert relatedAgreement;
  }
  
  // Test Method
  @isTest static void testMethod1() {
    System.assertEquals(200, [SELECT Id from Apttus__APTS_Agreement__c WHERE Apttus__Status__c = 'Superseded'].size());
    System.assertEquals(200, [SELECT Id from Apttus__APTS_Related_Agreement__c WHERE Apttus__Relationship_From_Type__c = 'Is Superceded By'].size());
  }
}