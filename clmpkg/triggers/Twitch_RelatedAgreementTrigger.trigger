//
// (c) 2018 Appirio, Inc.
//
// Apex Trigger Name: Twitch_RelatedAgreementTrigger .trigger
// For sObject: Apttus__APTS_Related_Agreement__c 
// Description: This is Apex Trigger for Apttus__APTS_Related_Agreement__c .
//
// 27th Apr 2018  Abhimanyu Tanwar   Original (Task # T-XXXXX) - Please see the task description for more details.
//
trigger Twitch_RelatedAgreementTrigger on Apttus__APTS_Related_Agreement__c (after insert) {

    Twitch_RelatedAgreementTriggerHandler handler = new Twitch_RelatedAgreementTriggerHandler();
    
    if(Trigger.isafter && Trigger.isInsert) {
        handler.afterInsert(Trigger.new);
    }

}