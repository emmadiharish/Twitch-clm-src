public with sharing class PNR_Agreements extends PNR_SObjectDomain {
    @TestVisible
    private static Boolean triggerDisabled = false;
    public integer count2=0;
    public integer count=0;
    public PNR_Agreements(List<Apttus__APTS_Agreement__c> sObjectList) {
        super(sObjectList);
    }
    
  
    public override void onApplyDefaults() {
        for(Apttus__APTS_Agreement__c agr :(List<Apttus__APTS_Agreement__c>)getRecords()){
            if (agr.Apttus__Status__c == 'In Amendment') {
                agr.Apttus_Approval__Approval_Status__c = 'Not Submitted';
            }
        }
    }

    public override void onAfterInsert() {

        Savepoint sp = Database.setSavePoint();
        
        try {                      
           createAgreementRevisions(null);         
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


    @TestVisible
    private void createAgreementRevisions(Map<Id, SObject> existingRecords) { 
        List<Apttus__APTS_Agreement__c> agreementFromValues=new List<Apttus__APTS_Agreement__c>();
       
            
        for(Apttus__APTS_Agreement__c agrmnt:(List<Apttus__APTS_Agreement__c>)getRecords()){         
            if(agrmnt.Apttus__Status__c=='In Amendment' && agrmnt.Apttus__Status_Category__c=='Request'){            
               agreementFromValues.add(agrmnt);
             
            }                      
        }
         System.debug('agreementFromValues::'+agreementFromValues);
        if(!agreementFromValues.IsEmpty()){
            PNR_AgreementService.createAgreementRevisions(agreementFromValues);
        }
    }

    @TestVisible
    private void updateAgreementRevisions(Map<Id, SObject> existingRecords) { 
        Map<Id, Apttus__APTS_Agreement__c> existingAgreements = (Map<Id, Apttus__APTS_Agreement__c>)existingRecords;
        List<Apttus__APTS_Agreement__c> agreementToValues=new List<Apttus__APTS_Agreement__c>();
        Apttus__APTS_Agreement__c oldAgr;
        Map<String,Apttus__APTS_Agreement__c> changedAggs=new Map<String,Apttus__APTS_Agreement__c>();

        
        //Field sets
        Schema.FieldSet fieldSetAgreement = Schema.SObjectType.Apttus__APTS_Agreement__c.fieldSets.Agreement_Revisions_History;
       
        for(Apttus__APTS_Agreement__c agrmnt:(List<Apttus__APTS_Agreement__c>)getRecords()){
            
            if(existingAgreements.containsKey(agrmnt.Id)){               
                oldAgr =existingAgreements.get(agrmnt.Id);
            }

            
            for( Schema.FieldSetMember fsMember:fieldSetAgreement.getFields()){
                if( oldAgr != null  &&
                ((
                    String.valueof(oldAgr.get(fsMember.getFieldPath())) != String.valueof(agrmnt.get(fsMember.getFieldPath()))                  
                ) &&
                (   agrmnt.Apttus__Status__c=='Submitted Request' && agrmnt.Apttus__Status_Category__c=='Request'))
                )
                         
                {
                    agreementToValues.add(agrmnt);
                    break;
                }
      
            }
            if(agreementToValues.isEmpty() && agrmnt.Apttus__Status__c=='Submitted Request' && agrmnt.Apttus__Status_Category__c=='Request' ){                  
                    agreementToValues.add(agrmnt);
            }
            system.debug('agreementToValues%%'+agreementToValues);
          //  PNR_AgreementService.updateAgreementRevisions(agreementToValues);
        }
        
        if(!agreementToValues.isEmpty()){
             PNR_AgreementService.updateAgreementRevisions(agreementToValues);
        }
    }
   

    public class Constructor implements PNR_SObjectDomain.IConstructable {

        public PNR_SObjectDomain construct(List<SObject> sObjectList) {
            return new PNR_Agreements(sObjectList);
        }
    }
}