public with sharing class PNR_AgreementRevHistorySelector extends PNR_SObjectSelector {

    public PNR_AgreementRevHistorySelector() {
        this(false);
    }

    public PNR_AgreementRevHistorySelector(Boolean includeFieldSetFields) {
        this(includeFieldSetFields, true, false);
    }

    public PNR_AgreementRevHistorySelector(Boolean includeFieldSetFields, Boolean enforceCRUD, Boolean enforceFLS) {
        super(includeFieldSetFields, enforceCRUD, enforceFLS);
    }
    
    
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Agreement_Revision_History__c.Id,
            Agreement_Revision_History__c.FieldAPI__c,
            Agreement_Revision_History__c.FieldLabel__c,
            Agreement_Revision_History__c.From__c,
            Agreement_Revision_History__c.To__c,
            Agreement_Revision_History__c.Channel_SF_ID__c
          
          
        };
    }
    
    public Schema.SObjectType getSObjectType() {
        return Agreement_Revision_History__c.sObjectType;
    }
    
    public List<Agreement_Revision_History__c> selectAgreementRevision(Set<Id> agId) {
        assertIsAccessible();
        
        String agreement='Agreement';
        
        String query = String.format(
                ' SELECT {0}' +
                        ' FROM {1}' +
                        ' WHERE Agreement__c =: agId'+
                        ' AND Type__c=:agreement',
                                    
                new List<String> {
                        getFieldListString(),
                        getSObjectName()  
                }
        );
        
        system.debug('agreement query' +query);
        return Database.query(query);
        
    }
    
    public List<Agreement_Revision_History__c> selectAgrmntChnlRev(Set<Id> agId) {
        assertIsAccessible();
        
        String channel='Agreement Channel';
        
        String query = String.format(
                ' SELECT {0}' +
                        ' FROM {1}' +
                        ' WHERE Agreement__c =: agId'+
                        ' AND Type__c=: channel',
                                      
                new List<String> {
                        getFieldListString(),
                        getSObjectName()
                                            
                }
        );
        
        system.debug('agreement channel query' +query);
        return Database.query(query);
        
    }
    
    public List<Agreement_Revision_History__c> selectByAgrmntChnl(Set<Id> agId,Set<Id> channelId) {
        assertIsAccessible();
          
        String channel='Agreement Channel';
        
        String query = String.format(
                ' SELECT {0}' +
                        ' FROM {1}' +
                        ' WHERE Agreement__c =: agId'+
                        ' AND Type__c=: channel'+
                        ' AND Channel_SF_ID__c=: channelId',               
                new List<String> {
                        getFieldListString(),
                        getSObjectName()
                                           
                }
        );
        
        system.debug('channel query' +query);
        return Database.query(query);
        
    }

}