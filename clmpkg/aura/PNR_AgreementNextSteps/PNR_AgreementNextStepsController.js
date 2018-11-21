({
    handleRecordUpdated: function(component, event, helper) {
        var eventParams = event.getParams();
        console.log(eventParams.changeType);
        if(eventParams.changeType === "LOADED") {
           // record is loaded (render other component which needs record data value)
            helper.setContextVariables(component);
        } else if(eventParams.changeType === "CHANGED") {
            // record is changed
            helper.setContextVariables(component);
        } else if(eventParams.changeType === "REMOVED") {
            // record is deleted
        } else if(eventParams.changeType === "ERROR") {
            // there’s an error while loading, saving, or deleting the record
        }
    }
})