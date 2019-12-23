/**
 * Created by gamedevmadeeasy on 12/23/19.
 */

({
    getAcctContacts : function (component, event, helper) {
        // make sure the parameter matches the Apex Server side controller method
        // name exactly
        var action = component.get("c.getTreeData");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var data = response.getReturnValue();
                // loop through all the base data that gets returned
                for(var i = 0; i < data.length; i++) {
                    // check if the data in the array is of type contacts
                    if(data[i].Contacts){
                        // loop through the contact data
                        for(var j = 0; j < data[i].Contacts.length; j++){
                            // set the IdURL to have the correct format for URL
                            data[i].Contacts[j].IdURL='/'+ data[i].Contacts[j].Id;
                        }
                    }
                    // set the IdURL to the data's Id
                    data[i].IdURL='/'+data[i].Id;
                    // set the data's children elements in the tree to be contact data
                    data[i]._children = data[i].Contacts;
                    // by doing the above steps and below steps, the url is now
                    // clickable and will allow for navigation to the lightning pages
                    // associated.
                }
            }
            // store the results in the gridData attribute
            component.set('v.gridData', data);
            // error handling when state is "INCOMPLETE" or "ERROR"
        });
        $A.enqueueAction(action);
    },

    goToURL: function(theURL) {
        //opens the url in a new window
        var urlEvent = $A.get("e.force:navigateToURL");
        // if there is a urlEvent
        if (urlEvent) {
            // set the event params to be the url and target we want
            urlEvent.setParams({
                url: theURL,
                target: "_blank"
            });
            // fire the event
            urlEvent.fire();
        } else {
            // if the event can't fire or is not of the urlEvent type, then open a
            // new window with the url we want and set it to be a blank target
            window.open(theURL, "_blank");
        }
    },

    // OpenTab comes from the WorkspaceAPI
    openTab: function(component, event, Id, name) {
        // find the workspace component on the component
        var workspaceAPI = component.find("workspace");
        console.log(Id);
        // Determines if the page is in the Salesforce console.
        if (sforce.console.isInConsole()) {
            // Opens a new primary tab to display the content of the specified URL,
            // which can be relative or absolute. You can also override an existing tab.
            sforce.console.openPrimaryTab(null, "/" + Id, true, name);
        }
        else {
            // if it isn't in the salesforce console, then call the helper method
            // goToURL to access the page anyways.
            this.goToURL("/" + Id);
        }
    }
});