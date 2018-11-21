/*
 * Test class for PNR_AgreementService 
*/
@isTest
private class PNR_AgreementService_Test {
    @isTest
    private static void test_getAgreementsList() {
        List<Account> acctlst = PNR_TestDataFactory.createStreamers(5);
        Account acct = PNR_TestDataFactory.createStreamers(1)[0];
        Opportunity opp= PNR_TestDataFactory.initPartnerAcquisitionOpportunity( acctlst[0].Id );     
        insert opp;
        Set<Id> accIds=new Set<Id>();
        List<Id> oppIds=new List<Id>();
        Set<Id> oppIdset=new Set<Id>();
        for(Account acc:acctlst){
            accIds.add(acc.Id);
        }
        
        
        PNR_TestDataFactory.createPartnerContentAcquisitionOpportunities(accIds,5);
        List<Opportunity> opptys= [select id from Opportunity where accountId IN :accIds];
        for(Opportunity opps:opptys){oppIds.add(opps.Id);oppIdset.add(opps.Id);}
        PNR_TestDataFactory.createOpportunityChannels(new Set<Id> { opptys[0].Id }, new Set<String> {'Test_Channel'});      
        
        
        //insert single agreement
        Apttus__APTS_Agreement__c ags=PNR_TestDataFactory.initTwitchContentLicenseAgrmnt( oppIds[0] );
        insert ags;
       
        //insert multiple agreements
        List<Apttus__APTS_Agreement__c> agrs=PNR_TestDataFactory.insertTwitchContentLicenseAgrmnts( oppIds, 5);     
        insert agrs;               
        
        //insert channels
        AgreementChannel__c agrchnl=PNR_TestDataFactory.insertAgrmntChannel(agrs[0].Id,acctlst[0].Id);
        
        PNR_TestDataFactory.updateAgrmntChannel(agrchnl,agrs[1].Id,acctlst[1].Id);
        PNR_TestDataFactory.updateagreement(ags);  
        List<Agreement_Revision_History__c> agr=PNR_TestDataFactory.insertAgreementRevisions(agrs[1].Id,1);       
        set<Id> chnlId=new Set<Id>();
        for(Agreement_Revision_History__c ag:agr){
            if(ag.Channel_SF_ID__c !=null){
                Id temp=Id.valueof(ag.Channel_SF_ID__c);
                chnlId.add(temp);
            }
        }
       
        List<Schema.FieldSetMember> fsMembers=PNR_TestDataFactory.createFieldSet();
        
        Test.startTest();
        PNR_AgreementService.createAgreementRevisions(agrs);       
        PNR_AgreementService.createChannelRevisions(new Set<Id> {ags.Id},new Set<Id> {acct.Id});
        
        Set<Id> filterags=new Set<Id>();
        for(Apttus__APTS_Agreement__c ag: agrs){
         filterags.add(ag.Id);
        }
        List<Apttus__APTS_Agreement__c> aglist=new PNR_AgreementSelector().selectByOpportunityId(oppIdset); 
        PNR_AgreementService.deletedChannelRevisions(filterags,chnlId);
        Test.stopTest();

    }
     
      


}