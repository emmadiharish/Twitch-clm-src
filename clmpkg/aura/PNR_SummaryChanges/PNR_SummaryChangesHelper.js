({
	getAgreementData : function(component) {
    	//create list for agreement type
    	//create list for agreement channel type
    	var agreement = [];
        var agreementChannel = [];
        
        var agId=component.get("v.recordId");       
        
        var action = component.get("c.getAgreements");
        action.setParams({ "agreement" : agId});
        action.setCallback(this, function(response){
            if(response.getState()==="SUCCESS" ){
               // && component.isValid()
                var result= response.getReturnValue();
                console.log('result length: ' + result.length);
                var data=JSON.stringify(result, null, 2);
                console.log('data: ' + JSON.stringify(result, null, 2));
                  
                for(var i=0;i<result.length;i++){
                    console.log('record type: ' + result[i].Type__c);
                        if(result[i].Type__c == 'Agreement'){
                            agreement.push(result[i]);
                            
                        }
                    	if (result[i].Type__c == 'Agreement Channel') {
                            agreementChannel.push(result[i]);
                        }
                }
                // component.set("v.revisions",data);   
                component.set('v.revisions', agreement); 
                component.set('v.revisionsChannel', agreementChannel); 
                component.set('v.showChannels',true);
                console.log('agreements: ' + agreement);
                console.log('agreement channels: ' + agreementChannel);
                    var parsed = JSON.parse(data);
					var results = parsed.Name;
					//component.set("v.listings", results); 
					 console.log('parseddata@@: ' + results );         
                
            }
            else{component.set('v.showChannels',false);}
        });
        $A.enqueueAction(action);
    },
    
    getChannelAgreementData: function(component) {
    var agId=component.get("v.recordId");       
        
        var action = component.get("c.getChannelRevisions");
        action.setParams({ "agreement" : agId});
        action.setCallback(this, function(response){
            if(response.getState()==="SUCCESS" ){       
                //&& component.isValid()
                var result= response.getReturnValue();
                var data=JSON.stringify(result, null, 2);
                console.log('channeldata: ' + JSON.stringify(result, null, 2));
                component.set('v.revisionsChannel',response.getReturnValue());  
                component.set('v.showChannels',true);
            }
            else{component.set('v.showChannels',false);}
        });
        $A.enqueueAction(action);
    },
})