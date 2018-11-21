@isTest
private class PNR_AgreementSelector_Test {
    
    @isTest
    private static void test_getAgreementsList() {
        Account acct = PNR_TestDataFactory.createStreamers(1)[0];
        Opportunity opp= PNR_TestDataFactory.initPartnerAcquisitionOpportunity( acct.Id );   
        insert opp;
        PNR_TestDataFactory.createOpportunityChannels(new Set<Id> { opp.Id }, new Set<String> {'Test_Channel'});      
    
        List<Apttus__APTS_Agreement__c> agrmnts = [SELECT Id FROM Apttus__APTS_Agreement__c];		      
        System.assertEquals(agrmnts.size(), (new PNR_AgreementSelector().selectByOpportunityId(new Set<Id> {opp.Id})).size());
                          
	}
}