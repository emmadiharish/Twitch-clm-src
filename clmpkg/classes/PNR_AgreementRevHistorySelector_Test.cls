/*
 * Test class for PNR_AgreementRevHistorySelector 
*/
@isTest
private class PNR_AgreementRevHistorySelector_Test {

    private final static Integer NUM_DEFAULT_STREAMERS = 1;

    @testSetup
    private static void setupData() {
        List<Account> accounts = PNR_TestDataFactory.createStreamers(NUM_DEFAULT_STREAMERS);
        Set<Id> accountIds = new Map<Id, Account>(accounts).keySet();       
               
        PNR_TestDataFactory.createPartnerContentAcquisitionOpportunities(accountIds, 1);
        List<Opportunity> opptys = [SELECT Id FROM Opportunity];
        List<Id> opIds=new List<Id>();
        for(Opportunity op:opptys){
            opIds.add(op.Id);
        }
        
        List<Apttus__APTS_Agreement__c> agg=PNR_TestDataFactory.insertTwitchContentLicenseAgrmnts(opIds,1);
        insert agg;       
       
        List<Agreement_Revision_History__c> agrev=PNR_TestDataFactory.insertAgreementRevisions(agg[0].Id,1);
        insert agrev;
    }

    @isTest
    private static void test_selectById() {
        Set<Id> agIds =new Set<Id>();
        Set<Id> chIds=new Set<Id> () ;
        List<Agreement_Revision_History__c> agrs = [SELECT Id,Channel_SF_ID__c, Agreement__c, Type__c, To__c FROM Agreement_Revision_History__c];
       
        for(Agreement_Revision_History__c arh:agrs){
            if(arh.Type__c=='Agreement'){             
               agIds.add(Id.valueof(arh.Agreement__c));
            }
            else if(arh.Type__c=='Agreement Channel'){                
                 agIds.add(Id.valueof(arh.Agreement__c));
                 chIds.add(Id.valueof(arh.Channel_SF_ID__c));
            }           
        }
        
        List<Agreement_Revision_History__c> agr = [SELECT Id,Channel_SF_ID__c, Agreement__c, Type__c FROM Agreement_Revision_History__c where Type__c='Agreement' ];
        List<Agreement_Revision_History__c> agrchnl = [SELECT Id,Channel_SF_ID__c, Agreement__c, Type__c FROM Agreement_Revision_History__c where Type__c='Agreement Channel'];
        List<Agreement_Revision_History__c> agrchnlr = [SELECT Id,Channel_SF_ID__c, Agreement__c, Type__c FROM Agreement_Revision_History__c where Type__c='Agreement Channel' and Channel_SF_ID__c IN:chIds ];
        
        
        System.assertEquals(agr.size(), new PNR_AgreementRevHistorySelector().selectAgreementRevision(agIds).size());
        System.assertEquals(agrchnl.size(), new PNR_AgreementRevHistorySelector().selectAgrmntChnlRev(agIds).size());
        System.assertEquals(agrchnlr.size(), new PNR_AgreementRevHistorySelector().selectByAgrmntChnl(agIds,chIds).size());
        
    }

    
}