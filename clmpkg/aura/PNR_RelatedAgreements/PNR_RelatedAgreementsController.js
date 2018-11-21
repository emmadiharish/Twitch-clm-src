({
    loadAgreements : function(component, event, helper) {
        var opptyId=component.get("v.recordId");       
        
        var action = component.get("c.getAgreements");
        action.setParams({ "opptId" : opptyId});
        action.setCallback(this, function(response){
            if(response.getState()==="SUCCESS" && component.isValid()){
                var result= response.getReturnValue();
                var data=JSON.stringify(result, null, 2);
                console.log('data: ' + JSON.stringify(result, null, 2));
                component.set("v.agreements",response.getReturnValue());                               
                
            }
        });
        $A.enqueueAction(action);
    },
    
})