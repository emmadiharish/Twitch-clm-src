@isTest
private class PNR_AgreementController_Test {

   @isTest
    private static void setupData() {
        Account acct = PNR_TestDataFactory.createStreamers(1)[0];
        Opportunity opp= PNR_TestDataFactory.initPartnerAcquisitionOpportunity( acct.Id );   
        insert opp;
        
        PNR_TestDataFactory.createOpportunityChannels(new Set<Id> { opp.Id }, new Set<String> {'Test_Channel'});      
        PNR_TestDataFactory.initTwitchContentLicenseAgrmnt( opp.Id );
        
        Test.startTest();

        PNR_AgreementController.getAgreements(opp.Id);

        Test.stopTest();

       
    }
      
   

 }