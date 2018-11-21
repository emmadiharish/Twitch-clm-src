({
    loadRevisions : function(component, event, helper) {
        /*  component.set('v.columns', [
            {label: 'Field Name', fieldName: 'FieldLabel__c', type: 'text',sortable:true },
            {label: 'From Value', fieldName: 'From__c', type: 'text',sortable:true},
            {label: 'To Value', fieldName: 'To__c', type: 'text',sortable:true},
           
        ]);*/
               
        
    var columns=	 [
            {label: 'Field Name', fieldName: 'FieldLabel__c', type: 'text',sortable:true },
            {label: 'From Value', fieldName: 'From__c', type: 'text',sortable:true},
            {label: 'To Value', fieldName: 'To__c', type: 'text',sortable:true},
        ];
       var columns2= [
            {label: 'Field Name', fieldName: 'FieldLabel__c', type: 'text',sortable:true },
            {label: 'From Value', fieldName: 'From__c', type: 'text',sortable:true},
            {label: 'To Value', fieldName: 'To__c', type: 'text',sortable:true},
            {label: 'Action', fieldName: 'Channel_Action__c', type: 'text',sortable:true},
         ];
          
          component.set('v.chanlcolumns', columns2);
		  component.set('v.columns', columns);
        
          helper.getAgreementData(component);
        
   },
        
    
})