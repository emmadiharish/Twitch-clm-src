//
// (c) 2018 Appirio, Inc.
//
// Apex Trigger Name: Twitch_OpportunityTrigger.trigger
// For sObject: Opportunity
// Description: This is Apex Trigger for Opportunity.
//
// 15th Mar 2018  Abhimanyu Tanwar   Original (Task # T-XXXXX) - Please see the task description for more details.
//
trigger Twitch_OpportunityTrigger on Opportunity (after update) {
    Twitch_OpportunityTriggerHandler handler = new Twitch_OpportunityTriggerHandler();
    if(Trigger.isAfter && Trigger.isUpdate) {
        handler.afterUpdate(Trigger.new,Trigger.oldMap);
    }
}