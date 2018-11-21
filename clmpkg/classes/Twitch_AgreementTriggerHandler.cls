//
// (c) 2018 Appirio, Inc.
//
// Apex Class Name : Twitch_AgreementTriggerHandler.cls
// For Apex Trigger: Twitch_AgreementTrigger.trigger
// For sObject: Apttus__APTS_Agreement__c
// Description: This apex class is a handler class for  Twitch_AgreementTrigger.trigger
//
// 15th Mar 2018  Abhimanyu Tanwar   Original (Task # T-XXXXX) - Please see the task description for more details.
//
public class Twitch_AgreementTriggerHandler {
  
  private Id agreementTwitchCLRecType = Schema.SObjectType.Apttus__APTS_Agreement__c.getRecordTypeInfosByName().get(Label.AGREEMENT_REC_TYPE_TWITCH_CL).getRecordTypeId();
  private Id oppISCARecType = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(Label.OPP_IS_CA_REC_TYPE).getRecordTypeId(); 

  //Method called before Insert
  public void beforeInsert(List<Apttus__APTS_Agreement__c> newList) {
      updateAccountNameFromOpportunity(newList);
      updateAgreementName(newList);
  }
  
  //Method called After Insert
  public void afterInsert(List<Apttus__APTS_Agreement__c> newList) {
      validateActiveAgreement(newList);
  }

  //Method called Before Update
  public void beforeUpdate(List<Apttus__APTS_Agreement__c> newList, Map<Id,Apttus__APTS_Agreement__c> oldMap) {
      validateActiveAgreement(newList);
      updateAgreementName(newList);
  }
  
  //Method called After Update
  public void afterUpdate(List<Apttus__APTS_Agreement__c> newList, Map<Id,Apttus__APTS_Agreement__c> oldMap) {
    //  updateOpporunityStage(newList,oldMap);
  }

  private void validateActiveAgreement(List<Apttus__APTS_Agreement__c> newList){
    
    Map<Id,List<Apttus__APTS_Agreement__c>> oppIdToAgreementMap = new Map<Id,List<Apttus__APTS_Agreement__c>>();
    Set<Id> agreementIds = new Set<Id>();
    
    for(Apttus__APTS_Agreement__c agreement : newList) {
      if( agreement.RecordTypeId == agreementTwitchCLRecType && 
          agreement.Apttus__Related_Opportunity__c != null && 
          agreement.Apttus__Status_Category__c == Label.AGREEMENT_CATEGORY_IN_EFFECT && 
          agreement.Apttus__Status__c == Label.AGREEMENT_STATUS_ACTIVATED ) {
        oppIdToAgreementMap.put(agreement.Apttus__Related_Opportunity__c,new List<Apttus__APTS_Agreement__c>() );
        agreementIds.add(agreement.Id);
      }
    }
    
    for(Apttus__APTS_Agreement__c agreement : [ SELECT Id,Apttus__Related_Opportunity__c
                                                FROM Apttus__APTS_Agreement__c 
                                                WHERE Apttus__Related_Opportunity__c IN : oppIdToAgreementMap.keySet()
                                                AND Apttus__Related_Opportunity__r.RecordTypeId =: oppISCARecType
                                                AND Apttus__Status_Category__c =: Label.AGREEMENT_CATEGORY_IN_EFFECT 
                                                AND Apttus__Status__c =: Label.AGREEMENT_STATUS_ACTIVATED])
    {
      if(!oppIdToAgreementMap.containsKey(agreement.Apttus__Related_Opportunity__c)) {
        oppIdToAgreementMap.put(agreement.Apttus__Related_Opportunity__c,new List<Apttus__APTS_Agreement__c>());
      }
      oppIdToAgreementMap.get(agreement.Apttus__Related_Opportunity__c).add(agreement);
    }
    
    for(Apttus__APTS_Agreement__c agreement : newList) {
      if( agreementIds.contains(agreement.Id) && 
          oppIdToAgreementMap.containsKey(agreement.Apttus__Related_Opportunity__c) && 
          oppIdToAgreementMap.get(agreement.Apttus__Related_Opportunity__c) != null && 
          oppIdToAgreementMap.get(agreement.Apttus__Related_Opportunity__c).size() > 0 ) {
            
        //Check if we are not comparing same records
        for(Apttus__APTS_Agreement__c agreementOppChild : oppIdToAgreementMap.get(agreement.Apttus__Related_Opportunity__c)) {
          if(agreementOppChild.Id != agreement.Id ) {
            agreement.addError(Label.ONE_ACTIVE_AGREEMENT_ERROR); 
          }
        }
      }
    }
  }
  
 /* private void updateOpporunityStage(List<Apttus__APTS_Agreement__c> newList, Map<Id,Apttus__APTS_Agreement__c> oldMap) {
    
    Map<Id,Opportunity> oppIdToOppMap = new Map<Id,Opportunity>();
 
    for(Apttus__APTS_Agreement__c agreement : newList){
      if( agreement.RecordTypeId == agreementTwitchCLRecType && 
          agreement.Apttus__Related_Opportunity__c != null && 
          agreement.Apttus__Status_Category__c == Label.AGREEMENT_CATEGORY_IN_EFFECT && 
          agreement.Apttus__Status__c == Label.AGREEMENT_STATUS_ACTIVATED ) {
        oppIdToOppMap.put(agreement.Apttus__Related_Opportunity__c,null);
      }
    }
    
    for(Opportunity opp : [ SELECT Id,Name FROM Opportunity WHERE Id IN : oppIdToOppMap.keySet()])
    {
      opp.StageName = Label.OPP_STAGE_SIGNED;
      oppIdToOppMap.put(opp.Id,opp);
    }
    
    if(!oppIdToOppMap.values().isEmpty()) {
      update oppIdToOppMap.values();
    }
  }*/
  
  private void updateAgreementName(List<Apttus__APTS_Agreement__c> newList) {

    Map<Id,String> accountIdToNameMap = new Map<Id,String>();
 
    for(Apttus__APTS_Agreement__c agreement : newList){
      if(agreement.RecordTypeId == agreementTwitchCLRecType && agreement.Apttus__Account__c != null ) {
        accountIdToNameMap.put(agreement.Apttus__Account__c,null);
      }
    }
    
    for(Account acc : [ SELECT Id,Name FROM Account WHERE Id IN : accountIdToNameMap.keySet()])
    {
      accountIdToNameMap.put(acc.Id,acc.Name);
    }

    for(Apttus__APTS_Agreement__c agreement : newList) {
      if( agreement.RecordTypeId == agreementTwitchCLRecType && 
          agreement.Apttus__Version_Number__c == 0 &&
          agreement.Apttus__Account__c != null &&  
          accountIdToNameMap.containsKey(agreement.Apttus__Account__c) &&
          accountIdToNameMap.get(agreement.Apttus__Account__c) != null ) {
            
          if(agreement.Apttus__Contract_Start_Date__c != null) {
            agreement.Name =  accountIdToNameMap.get(agreement.Apttus__Account__c)+'__Content License__'+
                              agreement.Apttus__Contract_Start_Date__c.month()+'/'+
                              agreement.Apttus__Contract_Start_Date__c.day()+'/'+
                              agreement.Apttus__Contract_Start_Date__c.year();
          }
          else {
            agreement.Name = accountIdToNameMap.get(agreement.Apttus__Account__c)+'__Content License';
          }
      }
    }
  }

  private void updateAccountNameFromOpportunity(List<Apttus__APTS_Agreement__c> newList) {

    Map<Id,Id> opportunityIdToAccIdMap = new Map<Id,Id>();
 
    for(Apttus__APTS_Agreement__c agreement : newList){
      if(agreement.Apttus__Version_Number__c == 0 && agreement.Apttus__Account__c == null ) {
        opportunityIdToAccIdMap.put(agreement.Apttus__Related_Opportunity__c,null);
      }
    }
    
    for(Opportunity opp : [ SELECT Id,AccountId FROM Opportunity 
                                                WHERE Id IN : opportunityIdToAccIdMap.keySet()]
    ){
      opportunityIdToAccIdMap.put(opp.Id,opp.AccountId);
    }

    for(Apttus__APTS_Agreement__c agreement : newList){
      if( agreement.Apttus__Version_Number__c == 0 && 
          agreement.Apttus__Account__c == null &&  
          opportunityIdToAccIdMap.containsKey(agreement.Apttus__Related_Opportunity__c) &&
          opportunityIdToAccIdMap.get(agreement.Apttus__Related_Opportunity__c) != null ) {
            agreement.Apttus__Account__c = opportunityIdToAccIdMap.get(agreement.Apttus__Related_Opportunity__c);
      }
    }
  }
  
  /*
  * Opportunity Stage Advancement Logic
  *
  */
  public void updateOpportunityStatuses(List<Id> relatedOpportunities,List<Apttus__APTS_Agreement__c> agreements){
      Id agreementTwitchCLTecType = Schema.SObjectType.Apttus__APTS_Agreement__c.getRecordTypeInfosByName().get(Label.AGREEMENT_REC_TYPE_TWITCH_CL).getRecordTypeId(); 
      List<Opportunity> updatedOpportunities=new List<Opportunity>();
      List<OpportunityStagesLookup__mdt> opportunitylookup =new List<OpportunityStagesLookup__mdt>([Select Agreement_Status__c, Approval_Status__c, StatusCheckRequired__c, Opportunity_Stage__c, Status_Category__c from OpportunityStagesLookup__mdt]);
      Map<Id,Opportunity> relatedOpptys=new Map<Id,Opportunity>([Select Id,Name,stageName from Opportunity where Id IN: relatedOpportunities]); 
        for(Apttus__APTS_Agreement__c agreement:agreements){
            if(agreement.RecordTypeId==agreementTwitchCLTecType && agreement.Apttus__Related_Opportunity__c!=null){
                for(OpportunityStagesLookup__mdt opp:opportunitylookup)   {  
                  if(agreement.Apttus_Approval__Approval_Status__c==opp.Approval_Status__c && agreement.Apttus__Status_Category__c == opp.Status_Category__c) {     
                        if(opp.StatusCheckRequired__c){
                            if(agreement.Apttus__Status__c==opp.Agreement_Status__c){
                                //Update only if Oppty Stage is not the same value we want to update
                                if(relatedOpptys.get(agreement.Apttus__Related_Opportunity__c).StageName!=opp.Opportunity_Stage__c){
                                    system.debug('entered 1st IF:'+relatedOpptys.get(agreement.Apttus__Related_Opportunity__c).StageName +' , '+opp.Opportunity_Stage__c);
                                     relatedOpptys.get(agreement.Apttus__Related_Opportunity__c).StageName=opp.Opportunity_Stage__c;
                                     updatedOpportunities.add(relatedOpptys.get(agreement.Apttus__Related_Opportunity__c));
                                }
                               
                            } 
                        }
                        else
                        {
                        //Update only if Oppty Stage is not the same value we want to update
                         if(relatedOpptys.get(agreement.Apttus__Related_Opportunity__c).StageName!=opp.Opportunity_Stage__c){                       
                            system.debug('entered 2nd IF:'+relatedOpptys.get(agreement.Apttus__Related_Opportunity__c).StageName +','+opp.Opportunity_Stage__c);
                             relatedOpptys.get(agreement.Apttus__Related_Opportunity__c).StageName=opp.Opportunity_Stage__c;
                             updatedOpportunities.add(relatedOpptys.get(agreement.Apttus__Related_Opportunity__c));
                            }
                        }
                        
                        system.debug('test-updateoppstatus' +agreement.Apttus_Approval__Approval_Status__c +'&&'+opp.Approval_Status__c);        
                        system.debug('updatedOpportunitiess'+updatedOpportunities);
                   }  
               } 


            }

        }
        if(!updatedOpportunities.IsEmpty()){
            update updatedOpportunities;
       }
  }
}