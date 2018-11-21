//
// (c) 2018 Appirio, Inc.
//
// Apex Trigger Name: Twitch_AgreementTrigger.trigger
// For sObject: Apttus__APTS_Agreement__c
// Description: This is Apex Trigger for Apttus__APTS_Agreement__c.
//
// 15th Mar 2018  Abhimanyu Tanwar   Original (Task # T-XXXXX) - Please see the task description for more details.
//
trigger Twitch_AgreementTrigger on Apttus__APTS_Agreement__c (before insert,after insert,before update,after update) {
    Twitch_AgreementTriggerHandler handler = new Twitch_AgreementTriggerHandler();
    
    if(Trigger.isBefore && Trigger.isInsert) {
        handler.beforeInsert(Trigger.new);
    }
    
    if(Trigger.isAfter && Trigger.isInsert) {
        handler.afterInsert(Trigger.new);
    }
    
    if(Trigger.isBefore && Trigger.isUpdate) {
        handler.beforeUpdate(Trigger.new,Trigger.oldMap);
    }
    
    if(Trigger.isAfter && Trigger.isUpdate) {
        List<ID> relatedOpportunities =new List<ID>();
       // handler.afterUpdate(Trigger.new,Trigger.oldMap);
        
        //new logic
        for(Apttus__APTS_Agreement__c agreement:Trigger.new){
         system.debug('&&&after update&&&- Twitch_AgreementTrigger'+Trigger.oldMap.get(agreement.Id).Apttus_Approval__Approval_Status__c +'&&&:'+agreement.Apttus_Approval__Approval_Status__c);
            if(agreement.Apttus_Approval__Approval_Status__c != 
            Trigger.oldMap.get(agreement.Id).Apttus_Approval__Approval_Status__c ||
            agreement.Apttus__Status_Category__c !=
            Trigger.oldMap.get(agreement.Id).Apttus__Status_Category__c ||
            agreement.Apttus__Status__c !=
            Trigger.oldMap.get(agreement.Id).Apttus__Status__c
                       
            ){
                system.debug('&&&after update-if condition met&&&- Twitch_AgreementTrigger');
                relatedOpportunities.add(agreement.Apttus__Related_Opportunity__c);
             
            }
        }
        if(!relatedOpportunities.isEmpty()){
            system.debug('&&&after update-relatedOpportunities&&&- Twitch_AgreementTrigger');          
            handler.updateOpportunityStatuses(relatedOpportunities,Trigger.new);
        }
       
    }
}