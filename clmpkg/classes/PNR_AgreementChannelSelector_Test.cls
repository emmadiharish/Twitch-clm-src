/*
 * Test class for PNR_AgreementChannelSelector
*/
@isTest
private class PNR_AgreementChannelSelector_Test {
    
    @isTest
    private static void test_getAgreementChannelList() {
        Account acct = PNR_TestDataFactory.createStreamers(1)[0];
        Opportunity opp= PNR_TestDataFactory.initPartnerAcquisitionOpportunity( acct.Id );   
        insert opp;
        
        List<Apttus__APTS_Agreement__c> agrmnts=PNR_TestDataFactory.insertTwitchContentLicenseAgrmnts(new List<Id> {opp.Id},1);
        insert agrmnts;

        AgreementChannel__c channel =PNR_TestDataFactory.insertAgrmntChannel(agrmnts[0].Id,acct.Id);
        System.assertEquals(1, (new PNR_AgreementChannelSelector().selectByAgreementId((new Set<Id> {agrmnts[0].Id}),(new Set<Id> {channel.Id}))).size());
                         
  }
}