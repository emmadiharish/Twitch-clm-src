public with sharing class PNR_AgreementSelector extends PNR_SObjectSelector {

    public PNR_AgreementSelector() {
        this(false);
    }
   
    public PNR_AgreementSelector(Boolean includeFieldSetFields) {
        this(includeFieldSetFields, true, false);
    }
    
    public PNR_AgreementSelector(Boolean includeFieldSetFields, Boolean enforceCRUD, Boolean enforceFLS) {
        super(includeFieldSetFields, enforceCRUD, enforceFLS);
    }
   
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
                Apttus__APTS_Agreement__c.Id,
                Apttus__APTS_Agreement__c.Name,
                Apttus__APTS_Agreement__c.Apttus__Related_Opportunity__c,
                Apttus__APTS_Agreement__c.Apttus__Contract_Start_Date__c,
                Apttus__APTS_Agreement__c.Apttus__Contract_End_Date__c,
                Apttus__APTS_Agreement__c.Apttus__Status__c,
                Apttus__APTS_Agreement__c.Apttus__Term_Months__c,
                Apttus__APTS_Agreement__c.Apttus_Approval__Approval_Status__c,
                Apttus__APTS_Agreement__c.Apttus__Status_Category__c,
                Apttus__APTS_Agreement__c.Apttus__Account__c,
                Apttus__APTS_Agreement__c.AdDensityRequirementMinHr__c,
                Apttus__APTS_Agreement__c.VODExclusivity__c,
                Apttus__APTS_Agreement__c.CustomAdDensityRequirement__c

        };
    }


    public Schema.SObjectType getSObjectType() {
        return Apttus__APTS_Agreement__c.sObjectType;
    }

  
    public override String getOrderBy() {
        return 'CreatedDate';
    }
    
    public override String getLimitClause(){
        return 'DESC LIMIT 1';
    }
    public List<Apttus__APTS_Agreement__c> selectByOpportunityId(Set<Id> opptyIdSet) {
        assertIsAccessible();

        String query = String.format(
                ' SELECT {0}' +
                        ' FROM {1}' +
                        ' WHERE Apttus__Related_Opportunity__c =: opptyIdSet' +
                        ' ORDER BY {2}' +
                        ' {3}',
                new List<String> {
                        getFieldListString(),
                        getSObjectName(),
                        getOrderBy(),
                        getLimitClause()
                }
        );
        
        return Database.query(query);
    }
    public String selectByAggId(String relationshipFieldPath) {
        assertIsAccessible();

        String query='';
        
            String strTest = getFieldListString();
            String[] arrTest = strTest.split(',');

            for(String s:arrTest){
                query+= relationshipFieldPath+'.'+s+',';
            }
           query=query.removeEnd(',');
         
        system.debug('Agreement Selector -query'+query);
        return query;
    }
}