public with sharing class PNR_AgreementActionsCtrl {
    @AuraEnabled
    public static String getCreateEnvelopeURL(Apttus__APTS_Agreement__c agreementSO) {
        //recordId is the source id for the envelope which is mandatory
        String sId = agreementSO.Id;
        String ces = 'Please DocuSign: ' + agreementSO.Name;
        String cem = 'Please DocuSign ' + agreementSO.Name + '\\n\\nThank you,\\n' +
            UserInfo.getFirstName() + ' ' + UserInfo.getLastName();

        String la = '1';
        String lf = '0';
        String crl = '';
        String ccrm = '';
        String cctm = '';
        String sCount = '1';
        if (String.isNotBlank(agreementSO.Signatory__c)) {
            crl += 'Email~' + agreementSO.Signatory__c + ';LastName~' + agreementSO.SignatoryName__c +
                ';' + 'Role~Signer ' + sCount + ';' + 'RoutingOrder~' + sCount + ';,';
            ccrm += 'Signer ' + sCount + '~Signer ' + sCount + ';';
            cctm += 'Signer ' + sCount + '~Signer;';
            sCount = '2';
        }
        if (String.isNotBlank(agreementSO.Twitch_Signatory__c)) {
            crl += 'Email~' + agreementSO.Twitch_Signatory__c + ';LastName~' + agreementSO.TwitchSignatoryName__c +
                ';' + 'Role~Signer ' + sCount + ';' + 'RoutingOrder~' + sCount + ';,';
            ccrm += 'Signer ' + sCount + '~Signer ' + sCount + ';';
            cctm += 'Signer ' + sCount + '~Signer;';
            sCount = '3';
        }
        crl += 'LoadDefaultContacts~0';

        PageReference response = Page.dsfs__DocuSign_CreateEnvelope;
        response.getParameters().put('nw', '1');
        response.getParameters().put('SourceID', sId);
        response.getParameters().put('sId', sId);
        response.getParameters().put('CES', ces);
        response.getParameters().put('CEM', cem);
        response.getParameters().put('LA', la);
        response.getParameters().put('LF', lf);
        response.getParameters().put('CRL', crl);
        response.getParameters().put('CCRM', ccrm);
        response.getParameters().put('CCTM', cctm);
        return response.getUrl();
    }
}