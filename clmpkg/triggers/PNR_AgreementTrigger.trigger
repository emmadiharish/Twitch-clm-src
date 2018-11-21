trigger PNR_AgreementTrigger on Apttus__APTS_Agreement__c (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    PNR_SObjectDomain.triggerHandler(PNR_Agreements.class);
}