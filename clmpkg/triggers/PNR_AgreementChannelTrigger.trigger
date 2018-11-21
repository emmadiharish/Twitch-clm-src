trigger PNR_AgreementChannelTrigger on AgreementChannel__c (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    PNR_SObjectDomain.triggerHandler(PNR_AgreementChannels.class);
}