public with sharing class PNR_AgreementChannelSelector extends PNR_SObjectSelector {

    public PNR_AgreementChannelSelector() {
        this(false);
    }

    public PNR_AgreementChannelSelector(Boolean includeFieldSetFields) {
        this(includeFieldSetFields, true, false);
    }

    public PNR_AgreementChannelSelector(Boolean includeFieldSetFields, Boolean enforceCRUD, Boolean enforceFLS) {
        super(includeFieldSetFields, enforceCRUD, enforceFLS);
    }
      
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            AgreementChannel__c.Id,
            AgreementChannel__c.Name,
            AgreementChannel__c.Agreement__c,
            AgreementChannel__c.ChannelID__c,
            AgreementChannel__c.ChannelName__c,
            AgreementChannel__c.EffectiveDateTerm__c,
            AgreementChannel__c.EffectiveDateFrom__c,
            AgreementChannel__c.EffectiveDateTo__c
           
        };
    }
    
    public Schema.SObjectType getSObjectType() {
        return AgreementChannel__c.sObjectType;
    }
    
    public List<AgreementChannel__c> selectByAgreementId(Set<Id> agId,Set<Id> channelId) {
        assertIsAccessible();
        PNR_AgreementSelector agreementSelector = new PNR_AgreementSelector();
        String agreementquery=agreementSelector.selectByAggId('Agreement__r');
        
        String query = String.format(
                ' SELECT {0}' + ','+'{2}'+
                        ' FROM {1}' +
                        ' WHERE Agreement__c =: agId'+
                        ' AND ID=: channelId',                   
                new List<String> {
                        getFieldListString(),
                        getSObjectName(),
                        agreementquery
                     
                }
        );
        system.debug('channel query' +query);
        return Database.query(query);
    }
}