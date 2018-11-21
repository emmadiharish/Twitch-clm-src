public with sharing class PNR_OpportunitiesController {

    @AuraEnabled
    public static List<OpportunityChannel__c> getOpportunityChannels(Id opportunityId) {
        return PNR_OpportunityService.getOpportunityChannels(opportunityId);
    }

    @AuraEnabled
    public static OpportunityChannel__c addOpportunityChannel(Id opportunityId, String twitchUsername) {
        try {
            return PNR_OpportunityService.addOpportunityChannel(opportunityId, twitchUsername);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void removeOpportunityChannel(Id opportunityChannelId) {
        PNR_OpportunityService.removeOpportunityChannel(opportunityChannelId);
    }
}