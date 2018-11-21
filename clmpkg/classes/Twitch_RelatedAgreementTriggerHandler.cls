//
// (c) 2018 Appirio, Inc.
//
// Apex Class Name : Twitch_RelatedAgreementTriggerHandler.cls
// For Apex Trigger: Twitch_RelatedAgreementTrigger.trigger
// For sObject: Apttus__APTS_Agreement__c
// Description: This apex class is a handler class for  Twitch_RelatedAgreementTrigger.trigger
//
// 27th Apr 2018  Abhimanyu Tanwar   Original (Task # T-XXXXX) - Please see the task description for more details.
//
public class Twitch_RelatedAgreementTriggerHandler  {
  
  private Id agreementTwitchCLRecType = Schema.SObjectType.Apttus__APTS_Agreement__c.getRecordTypeInfosByName().get(Label.AGREEMENT_REC_TYPE_TWITCH_CL).getRecordTypeId();
  private Id oppISCARecType = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Label.OPP_IS_CA_REC_TYPE).getRecordTypeId(); 
  
  //Method called After Insert
  public void afterInsert(List<Apttus__APTS_Related_Agreement__c> newList) {
      updateRelatedAgreementStages(newList);
  }
  
  private void updateRelatedAgreementStages(List<Apttus__APTS_Related_Agreement__c> newList) {
    
    Set<Id> relationToSupersued = new Set<Id>();
    Map<Id,List<Id>> AgreementIDAmendFromAgreementMap = new Map<Id,List<Id>>();
    Map<Id,List<Id>> AgreementIDRenewedFromAgreementMap = new Map<Id,List<Id>>();
    
    List<Apttus__APTS_Agreement__c> amendedAgreementList = new List<Apttus__APTS_Agreement__c>();
    List<Apttus__APTS_Agreement__c> renewedAgreementList = new List<Apttus__APTS_Agreement__c>();
    List<Apttus__APTS_Related_Agreement__c> updateRelationList = new List<Apttus__APTS_Related_Agreement__c>();

    for( Apttus__APTS_Related_Agreement__c agreementRelation: [ SELECT  Id,
                                                                        Apttus__Relationship_From_Type__c,
                                                                        Apttus__APTS_Contract_To__c,
                                                                        Apttus__APTS_Contract_From__c
                                                                FROM Apttus__APTS_Related_Agreement__c 
                                                                WHERE ID IN : newList
                                                                AND ( Apttus__Relationship_From_Type__c = 'Is Amended By' OR Apttus__Relationship_From_Type__c = 'Is Renewed By' )
                                                                AND Apttus__APTS_Contract_To__r.Apttus__Related_Opportunity__r.RecordTypeId =: oppISCARecType ]) {
     
      if(agreementRelation.Apttus__Relationship_From_Type__c == 'Is Amended By') {
        Apttus__APTS_Agreement__c agreement = new Apttus__APTS_Agreement__c();
        agreement.Id = agreementRelation.Apttus__APTS_Contract_From__c;
        agreement.Apttus__Status__c = 'Superseded';
        agreement.Apttus__Status_Category__c = 'Amended';
        amendedAgreementList.add(agreement);
        
        
        Apttus__APTS_Related_Agreement__c agreementRel = new Apttus__APTS_Related_Agreement__c();
        agreementRel.Id = agreementRelation.Id;
        agreementRel.Apttus__Relationship_From_Type__c = 'Is Superceded By';
        updateRelationList.add(agreementRel);
      }
      else if(agreementRelation.Apttus__Relationship_From_Type__c == 'Is Renewed By') {
        Apttus__APTS_Agreement__c agreement = new Apttus__APTS_Agreement__c();
        agreement.Id = agreementRelation.Apttus__APTS_Contract_From__c;
        agreement.Apttus__Status__c = 'Superseded';
        agreement.Apttus__Status_Category__c = 'Renewed';
        amendedAgreementList.add(agreement);
        
        
        Apttus__APTS_Related_Agreement__c agreementRel = new Apttus__APTS_Related_Agreement__c();
        agreementRel.Id = agreementRelation.Id;
        agreementRel.Apttus__Relationship_From_Type__c = 'Is Superceded By';
        updateRelationList.add(agreementRel);
      }
    }
    
    if(!amendedAgreementList.isEmpty()) {
      update amendedAgreementList;
      System.debug(amendedAgreementList);
    }
    
    if(!updateRelationList.isEmpty()) {
      update updateRelationList;
      System.debug(updateRelationList);
    }
  }
}