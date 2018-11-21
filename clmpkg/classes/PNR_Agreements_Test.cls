/*
 * Test class for PNR_Agreements 
*/
@isTest
private class PNR_Agreements_Test {

    @isTest
    private static void test_agreement_insert() {

    List<Account> acclist=PNR_TestDataFactory.createStreamers(1,false);
    Set<Id> accountsIds=(new Map<Id,Account> (acclist)).keyset();
    
    
    PNR_TestDataFactory.createPartnerContentAcquisitionOpportunities(accountsIds,1);
    List<Opportunity> opp=[select Id from Opportunity];
    List<Id> oppIds= new List<Id>();
    for(Opportunity op: opp){
        oppIds.add(op.Id);
    }
    
    List<Apttus__APTS_Agreement__c> agglist=PNR_TestDataFactory.insertTwitchContentLicenseAgrmnts(oppIds,1);
    
   
   }
 }