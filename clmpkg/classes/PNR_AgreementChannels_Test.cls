/*
 * Test class for PNR_AgreementChannels 
*/
@isTest   
private class PNR_AgreementChannels_Test {
    
    @isTest
    private static void test_getAgreementChannelList() {
        Account acct = PNR_TestDataFactory.createStreamers(1)[0];
        Opportunity opp= PNR_TestDataFactory.initPartnerAcquisitionOpportunity( acct.Id );   
        insert opp;
        
        List<Apttus__APTS_Agreement__c> agrmnts=PNR_TestDataFactory.insertTwitchContentLicenseAgrmnts(new List<Id> {opp.Id},1);
        insert agrmnts;
      
        
        AgreementChannel__c channel =PNR_TestDataFactory.insertAgrmntChannel(agrmnts[0].Id,acct.Id);
        List<AgreementChannel__c> channelList=new List<AgreementChannel__c>();
        channelList.add(channel);
        PNR_AgreementChannels agreement = new PNR_AgreementChannels(channelList);
        agreement.createAgreementChannelRevisions();
        
         AgreementChannel__c channelupdate =PNR_TestDataFactory.updateAgrmntChannel(channel,acct.Id);
         List<AgreementChannel__c> channelListUpdate=new List<AgreementChannel__c>();
         channelListUpdate.add(channelupdate);
         PNR_AgreementChannels agreementUpdate = new PNR_AgreementChannels(channelListUpdate);
         agreementUpdate.updateAgreementRevisions(new Map<Id,AgreementChannel__c>(channelListUpdate));
         
         delete channelListUpdate;
         PNR_AgreementChannels agreementDelete = new PNR_AgreementChannels(channelListUpdate);
         agreementDelete.deleteAgreementRevisions(new Map<Id,AgreementChannel__c>(channelListUpdate));
        
  }
}