public with sharing class PNR_AgreementService {
    

    public static void createAgreementRevisions(List<Apttus__APTS_Agreement__c> agList) {      
        List<Agreement_Revision_History__c> revisionInsertList=new List<Agreement_Revision_History__c>();
        Schema.FieldSet fieldSetObj = Schema.SObjectType.Apttus__APTS_Agreement__c.fieldSets.Agreement_Revisions_History;
        
        for(Apttus__APTS_Agreement__c agreement:agList){
            for(Schema.FieldSetMember fsMember:fieldSetObj.getFields()){
                Agreement_Revision_History__c revisionTo=new Agreement_Revision_History__c();
                revisionTo.Agreement__c=agreement.Id;
                revisionTo.FieldLabel__c=fsMember.getLabel();
                revisionTo.FieldAPI__c=fsMember.getFieldPath();              
                revisionTo.From__c=String.valueof(agreement.get(fsMember.getFieldPath()));
                revisionTo.Type__c='Agreement';

                revisionInsertList.add(revisionTo);

            }
        }
        system.debug('revisionInsertList:::'+revisionInsertList.size());
        insert revisionInsertList;
    }

    
    public static void createChannelRevisions(Set<Id> agreementIds,Set<Id> channelIds){
        List<AgreementChannel__c> channelList=new List<AgreementChannel__c>();
        channelList=new PNR_AgreementChannelSelector().selectByAgreementId(agreementIds,channelIds);
        List<Agreement_Revision_History__c> revisionChannelInsertList=new List<Agreement_Revision_History__c>();
        
        system.debug('channelList-create method:::'+channelList.size());

        Schema.FieldSet fieldSetObj = Schema.SObjectType.AgreementChannel__c.fieldSets.Channel_Revision_History;
        for(AgreementChannel__c channel:channelList){
            for(Schema.FieldSetMember fsMember:fieldSetObj.getFields()){
                Agreement_Revision_History__c channelRevisionTo=new Agreement_Revision_History__c();
                    if(channel.Agreement__r.Apttus__Status__c=='In Amendment' && channel.Agreement__r.Apttus__Status_Category__c=='Request'){
                        channelRevisionTo.Agreement__c=channel.Agreement__c;
                        channelRevisionTo.FieldLabel__c=fsMember.getLabel();
                        channelRevisionTo.FieldAPI__c=fsMember.getFieldPath();
                        
                        channelRevisionTo.From__c=String.valueof(channel.get(fsMember.getFieldPath()));
                        channelRevisionTo.Type__c='Agreement Channel';
                        channelRevisionTo.Channel_Action__c='Create';
                        channelRevisionTo.Channel_SF_ID__c=channel.ID;

                        revisionChannelInsertList.add(channelRevisionTo);
                    }
            }
        }

        system.debug('revisionChannelInsertList:::'+revisionChannelInsertList.size());
        insert revisionChannelInsertList;

    }

    //Update Agreement Channel to Revision Histroy
    @TestVisible
    public static void updateAgreementChannelRevisions(Set<Id> agreementIds,Set<Id> channelIds,Map<Id,String> channelMap) { 
       List<Agreement_Revision_History__c> revisionChannelUpdateListFinal=new List<Agreement_Revision_History__c>();
       
       List<AgreementChannel__c> channelList=new List<AgreementChannel__c>();
       channelList=new PNR_AgreementChannelSelector().selectByAgreementId(agreementIds,channelIds);
        
       List<Agreement_Revision_History__c> revisionChannelUpdateList= new PNR_AgreementRevHistorySelector(). selectAgrmntChnlRev(agreementIds);
       system.debug('%%%revisionChannelUpdateListNEW - Update method%%%'+revisionChannelUpdateList);
        
        //List<Agreement_Revision_History__c> revisionChannelUpdateList=[select id,FieldAPI__c,To__c,FieldLabel__c,From__c,Channel_SF_ID__c from Agreement_Revision_History__c where Agreement__c=:agreementIds AND Type__c='Agreement Channel'];
        
        for(AgreementChannel__c agChannels:channelList){
            for(Agreement_Revision_History__c revisionChannelHistory:revisionChannelUpdateList){
                               
                if((revisionChannelHistory.From__c != string.valueof(agChannels.get(revisionChannelHistory.FieldAPI__c)))&& (String.valueof(revisionChannelHistory.FieldAPI__c)==channelMap.get(agChannels.Id)) && (String.valueof(agChannels.Id)==String.valueof(revisionChannelHistory.Channel_SF_ID__c))){
                    
                    revisionChannelHistory.To__c=string.valueof(agChannels.get(revisionChannelHistory.FieldAPI__c));
                    revisionChannelHistory.Type__c='Agreement Channel';
                    revisionChannelHistory.Channel_Action__c='Update';
                    revisionChannelUpdateListFinal.add(revisionChannelHistory);

                }                  
            }

        }
        system.debug('revisionChannelUpdateListFinal:::'+revisionChannelUpdateListFinal.size());
        update revisionChannelUpdateListFinal;
        
    }

    @TestVisible
    public static void deletedChannelRevisions(Set<Id> aggIds, Set<Id> channelId){
    List<Agreement_Revision_History__c> revisionChannelDelListFinal=new List<Agreement_Revision_History__c>();   
    List<Agreement_Revision_History__c> revisionChannelDelList= new PNR_AgreementRevHistorySelector().selectByAgrmntChnl(aggIds,channelId);
        system.debug('%%%revisionChannelDelListNEW - Update method%%%'+revisionChannelDelList);
 
    //List<Agreement_Revision_History__c> revisionChannelDelList=[select id,FieldAPI__c,To__c,FieldLabel__c,From__c,Channel_SF_ID__c from Agreement_Revision_History__c where Agreement__c=:aggIds AND Type__c='Agreement Channel' AND Channel_SF_ID__c=:channelId];
        for(Agreement_Revision_History__c deletedRevChannels:revisionChannelDelList){
            deletedRevChannels.Channel_Action__c='Delete';
            revisionChannelDelListFinal.add(deletedRevChannels);
        }

        system.debug('DELETED CHANNELS%%%'+revisionChannelDelListFinal.size());
        update revisionChannelDelListFinal;
    }

    public static void updateAgreementRevisions(List<Apttus__APTS_Agreement__c> agList) {   
         
        Set<Id> revSet=new Set<Id> ();
        for(Apttus__APTS_Agreement__c ag:agList){
            revSet.add(ag.Id);
        }
        List<Agreement_Revision_History__c> revisionUpdateList= new PNR_AgreementRevHistorySelector().selectAgreementRevision(revSet);
        system.debug('%%%revisionChannelUpdateList22NEW - Update method%%%'+revisionUpdateList);
    
        //List<Agreement_Revision_History__c> revisionUpdateList=[select id,FieldAPI__c,To__c,FieldLabel__c,From__c from Agreement_Revision_History__c where Agreement__c=:revSet AND Type__c='Agreement'];
        Schema.FieldSet fieldSetAgreement = Schema.SObjectType.Apttus__APTS_Agreement__c.fieldSets.Agreement_Revisions_History;
        Map<String,String> fsfieldsMap=new Map<String,String>();

        List<Agreement_Revision_History__c> revisionUpdateListFinal=new List<Agreement_Revision_History__c>();
        List<Agreement_Revision_History__c> revisionDeleteListFinal=new List<Agreement_Revision_History__c>();
        for(Schema.FieldSetMember fsMember:fieldSetAgreement.getFields()){
            fsfieldsMap.put(fsMember.getLabel(),fsMember.getFieldPath());
        }
              
        
        for(Apttus__APTS_Agreement__c chngdAgg:agList){
            for(Agreement_Revision_History__c revisionUpdate:revisionUpdateList){            
                if(revisionUpdate.From__c != string.valueof(chngdAgg.get(revisionUpdate.FieldAPI__c))){                                    
                   revisionUpdate.To__c=string.valueof(chngdAgg.get(revisionUpdate.FieldAPI__c));
                   revisionUpdateListFinal.add(revisionUpdate);                 
                }
                else{
                    revisionDeleteListFinal.add(revisionUpdate);                    
                }
            }
        }
       
        system.debug('revisionUpdateList:::'+revisionUpdateListFinal.size());
        system.debug('revisionDeleteListFinal::'+revisionDeleteListFinal.size());
        if(revisionUpdateListFinal.size()<=10000){
            update revisionUpdateListFinal;
        }
        if(revisionDeleteListFinal.size()<=10000){
         delete revisionDeleteListFinal;
       }
    }
    
    
   public static List<Apttus__APTS_Agreement__c> getAgreementList(Id oppId) {
        List<Apttus__APTS_Agreement__c> agreementList=[select id,Apttus__Contract_Start_Date__c,Apttus__Contract_End_Date__c,Apttus_Approval__Approval_Status__c, Apttus__Status__c,Apttus__Term_Months__c,Apttus__Related_Opportunity__c from Apttus__APTS_Agreement__c where Apttus__Related_Opportunity__c=:oppId ORDER BY CreatedDate DESC LIMIT 1];
        system.debug('agreementList: ' + agreementList.size());      
        return agreementList;
    }
    
    public static List<Agreement_Revision_History__c> getAgreements(Id agreement) {
        List<Agreement_Revision_History__c> agreementList=[select id,Name,CreatedDate, From__c,To__c,FieldAPI__c,FieldLabel__c,Channel_Action__c,Type__c from Agreement_Revision_History__c where Agreement__c=:agreement and (Type__c = 'Agreement Channel' OR Type__c = 'Agreement') ORDER BY CreatedDate DESC];
        system.debug('agreementList: ' + agreementList.size());      
        return agreementList;
    }
}