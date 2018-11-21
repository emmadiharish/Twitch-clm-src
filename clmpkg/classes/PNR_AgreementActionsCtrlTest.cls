@isTest
private class PNR_AgreementActionsCtrlTest {
    static testMethod void testgetCreateEnvelopeURL(){
        Apttus__APTS_Agreement__c testAgr = new Apttus__APTS_Agreement__c();
        testAgr.Signatory__c = 'testsigner@gmail.com';
        testAgr.SignatoryName__c = 'Test Signatory';
        testAgr.Twitch_Signatory__c = 'testtwitchsigner@twitch.tv';
        testAgr.TwitchSignatoryName__c = 'Test Twitch Signer';
        String res = PNR_AgreementActionsCtrl.getCreateEnvelopeURL(testAgr);
        System.assert(res.containsIgnoreCase('dsfs__DocuSign_CreateEnvelope'));
    }
}