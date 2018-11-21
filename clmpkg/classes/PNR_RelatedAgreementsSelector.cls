public with sharing class PNR_RelatedAgreementsSelector extends PNR_SObjectSelector {

    public PNR_RelatedAgreementsSelector() {
        this(false);
    }
   
    public PNR_RelatedAgreementsSelector(Boolean includeFieldSetFields) {
        this(includeFieldSetFields, true, false);
    }
    
    public PNR_RelatedAgreementsSelector(Boolean includeFieldSetFields, Boolean enforceCRUD, Boolean enforceFLS) {
        super(includeFieldSetFields, enforceCRUD, enforceFLS);
    }
   
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
                Apttus__APTS_Related_Agreement__c.Id,
                Apttus__APTS_Related_Agreement__c.Name,
                Apttus__APTS_Related_Agreement__c.Apttus__APTS_Contract_From__c,
                Apttus__APTS_Related_Agreement__c.Apttus__Relationship_From_Type__c,
                Apttus__APTS_Related_Agreement__c.Apttus__APTS_Contract_To__c,
                Apttus__APTS_Related_Agreement__c.Apttus__Relationship_To_Type__c
                
        };
    }


    public Schema.SObjectType getSObjectType() {
        return Apttus__APTS_Related_Agreement__c.sObjectType;
    }

  
    
    public List<Apttus__APTS_Related_Agreement__c> selectByAgreementId(Id aggIdSet) {
      //  assertIsAccessible();
        system.debug('SELECTOR CLASS$$$'+aggIdSet);
        String query = String.format(
                ' SELECT {0}' +
                        ' FROM {1}' +
                        ' WHERE Apttus__APTS_Contract_To__c=:aggIdSet',
                       // ' AND Apttus__APTS_Contract_From__c =: aggIdSet',
                new List<String> {
                        getFieldListString(),
                        getSObjectName()
                }
        );
        system.debug('SELECT CLASS QUERY'+query);
        return Database.query(query);
    }
}