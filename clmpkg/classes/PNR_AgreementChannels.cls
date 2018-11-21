public with sharing class PNR_AgreementChannels extends PNR_SObjectDomain {

    public PNR_AgreementChannels(List<AgreementChannel__c> sObjectList) {
        super(sObjectList);
    }
    
    
    public override void onAfterInsert() {
        
        Savepoint sp = Database.setSavePoint();      
        try {                    
            createAgreementChannelRevisions();         
        } catch (Exception e) {
            System.debug(LoggingLevel.Error, e);
            System.debug(LoggingLevel.Error, e.getLineNumber());
                        
            Database.rollback(sp);
        }
    }
    
    public override void onAfterUpdate(Map<Id, SObject> existingRecords) {
        
        Savepoint sp = Database.setSavePoint();
        
        try {
            updateAgreementRevisions(existingRecords);      
        } catch (Exception e) {
            System.debug(LoggingLevel.Error, e.getLineNumber());            
            System.debug(LoggingLevel.Error, e.getMessage());
            
            Database.rollback(sp);
        }
    }
    
    public override void onAfterDeleteNew(Map<Id, SObject> existingRecords) {
        
        Savepoint sp = Database.setSavePoint();
        
        try {
            deleteAgreementRevisions(existingRecords);      
        } catch (Exception e) {
            System.debug(LoggingLevel.Error, e.getLineNumber());
            System.debug(LoggingLevel.Error, e.getMessage());
            
            Database.rollback(sp);
        }
    }
    
    @TestVisible
    private void createAgreementChannelRevisions() { 
        Set<Id> agreementIds=new Set<Id>();
        Set<Id> channelIds=new Set<Id>();
        for(AgreementChannel__c agChannel:(List<AgreementChannel__c>)getRecords()){   
            if(agChannel.Agreement__c != null){
                agreementIds.add(agChannel.Agreement__c);
                channelIds.add(agChannel.Id);
            }      
        }
        PNR_AgreementService.createChannelRevisions(agreementIds,channelIds);         
   }
   
   @TestVisible
   private void updateAgreementRevisions(Map<Id, SObject> existingRecords){
        Schema.FieldSet fieldSetAgChannel = Schema.SObjectType.AgreementChannel__c.fieldSets.Channel_Revision_History;
        Map<Id, AgreementChannel__c> existingAgreements = (Map<Id, AgreementChannel__c>)existingRecords;
        Set<Id> agreementIds=new Set<Id>();
        Map<Id,string> channelMap=new Map<Id,String>(); 
        Set<Id> channelID=new set<Id>();
        AgreementChannel__c oldAgrChannel;
        
        for(AgreementChannel__c agChannelUpdate:(List<AgreementChannel__c>)getRecords()){
            if(existingAgreements.containsKey(agChannelUpdate.Id)){
                 oldAgrChannel =existingAgreements.get(agChannelUpdate.Id);
            }
        
        
        
            for(Schema.FieldSetMember fsMember:fieldSetAgChannel.getFields()){
               if( oldAgrChannel!=null && (String.valueof(oldAgrChannel.get(fsMember.getFieldPath()))) != String.valueof(agChannelUpdate.get(fsMember.getFieldPath())) ){
                   channelID.add(agChannelUpdate.Id);
                   agreementIds.add(agChannelUpdate.Agreement__c);
                   channelMap.put(agChannelUpdate.Id,fsMember.getFieldPath());                  
               }     
                              
            }
        }
        
        PNR_AgreementService.updateAgreementChannelRevisions(agreementIds,channelID,channelMap);
   }
   
   @TestVisible
    private void deleteAgreementRevisions(Map<Id, SObject> deletedRecords) { 
     Map<Id, AgreementChannel__c> deletedChannel = (Map<Id, AgreementChannel__c>)deletedRecords;
        Set<Id> agreementIds=new Set<Id>();
        Set<Id> delchannelIds=new Set<Id>();
        for(AgreementChannel__c delChannel:deletedChannel.values()){
            if(delChannel.Agreement__c != null){
                agreementIds.add(delChannel.Agreement__c);
                delchannelIds.add(delChannel.Id);
            }      
        }       
        PNR_AgreementService.deletedChannelRevisions(agreementIds,delchannelIds);         
    }
   
  

    public class Constructor implements PNR_SObjectDomain.IConstructable {

        public PNR_SObjectDomain construct(List<SObject> sObjectList) {
            return new PNR_AgreementChannels(sObjectList);
          
        }
    }

}