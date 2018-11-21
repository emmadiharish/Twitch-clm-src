/*
 * Test class for PNR_AgreementRevisionHistory 
*/
@isTest
public class PNR_AgreementRevisionHistory_Test {

    @isTest
    public static void setupData() {
        List<Account> streamers = PNR_TestDataFactory.createStreamers(1);
        Opportunity contentOppty = PNR_TestDataFactory.initContentAcquisitionOpportunity( streamers[0].Id );
        insert contentOppty;
        
        Opportunity oppty = [Select Id, Name from Opportunity where Name = 'Test'];
        Apttus__APTS_Agreement__c agreement = PNR_TestDataFactory.initTwitchContentLicenseAgrmnt(oppty.Id);
        insert agreement;
        List<Agreement_Revision_History__c> preRevList = PNR_AgreementRevisionHistory.getAgreements(agreement.id);
        
        system.assertEquals(43, preRevList.size());
        
        PNR_TestDataFactory.insertAgrmntChannel(agreement.Id,streamers[0].Id);        
        List<Agreement_Revision_History__c> postRevList = PNR_AgreementRevisionHistory.getAgreements(agreement.id);
               
        system.assertEquals(47, postRevList.size());
    }
}