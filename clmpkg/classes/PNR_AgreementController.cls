public class PNR_AgreementController { 
    
    @auraEnabled
    public static List<Apttus__APTS_Agreement__c> getAgreements(Id opptId) {
        return PNR_AgreementService.getAgreementList(opptId);
    }

}