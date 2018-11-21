//
// (c) 2018 Appirio, Inc.
//
// Apex Class Name : Twitch_OpportunityTriggerHandler.cls
// For Apex Trigger: Twitch_OpportunityTrigger.trigger
// For sObject: Opportunity
// Description: This apex class is a handler class for  Twitch_OpportunityTrigger.trigger
//
// 15th Mar 2018  Abhimanyu Tanwar   Original (Task # T-XXXXX) - Please see the task description for more details.
//
public class Twitch_OpportunityTriggerHandler {
    
  public void afterUpdate(List<Opportunity> newList, Map<Id,Opportunity> oldMap) {
      changeAgreementStatus(newList,oldMap);
  }
  
  private void changeAgreementStatus(List<Opportunity> newList, Map<Id,Opportunity> oldMap) {
      
    Id agreementTwitchCLTecType = Schema.SObjectType.Apttus__APTS_Agreement__c.getRecordTypeInfosByName().get(Label.AGREEMENT_REC_TYPE_TWITCH_CL).getRecordTypeId(); 
    
    Set<Id> OpportunityIds = new Set<Id>();
    List<Apttus__APTS_Agreement__c> agreementList = new List<Apttus__APTS_Agreement__c>();
    
    for(Opportunity opp : newList){
      if(opp.StageName == 'Dropped' && oldMap.get(opp.Id).StageName != 'Dropped' ) {
        OpportunityIds.add(opp.Id);
      }
    }
    
    for(Apttus__APTS_Agreement__c agreement : [ SELECT Id FROM Apttus__APTS_Agreement__c 
                                                WHERE Apttus__Related_Opportunity__c IN : OpportunityIds
                                                AND RecordTypeId =: agreementTwitchCLTecType]){
      agreement.Apttus__Status_Category__c = 'Cancelled';
      agreement.Apttus__Status__c = 'Cancelled Request';
      agreementList.add(agreement);
    }

    if(!agreementList.isEmpty()) {
      update agreementList;
    }
  }
  
  
  
  
}