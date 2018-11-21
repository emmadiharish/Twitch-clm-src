public class PNR_AgreementRevisionHistory {
    
    @auraEnabled
    public static List<Agreement_Revision_History__c> getAgreements(Id agreement) {
        return PNR_AgreementService.getAgreements(agreement);
    }
}