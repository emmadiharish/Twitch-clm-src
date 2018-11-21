/**
 * Created by hemmadi on 10/4/18.
 */
({
    sendToDocuSign : function (component, event, helper) {
        var action = component.get("c.getCreateEnvelopeURL");
        action.setParams({
            agreementSO: component.get("v.agreementSO")
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                component.set("v.urlredirect", result);
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": result
                });
                urlEvent.fire();
            }
        });
        $A.enqueueAction(action);
    }
})