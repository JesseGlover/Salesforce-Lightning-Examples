/**
 * Created by gamedevmadeeasy on 12/23/19.
 */

({
    doInit: function (component, event, helper) {
        // set's the data to be displayed in the columns portion.
        component.set('v.gridColumns', [
            {label: 'Id', fieldName: 'Id', type: 'text'},
            // sortable allows a developer to sort the results
            {label: 'Account Name', fieldName: 'IdURL', type: 'url', sortable: true,
                // type attributes allow for setting specific types
                // (for example) setting the target for URL to be _blank
                typeAttributes: {
                    label: { fieldName: "Name" },
                    target:"_blank"
                }},
            {label: 'Billing City', fieldName: 'BillingCity', type: 'text'},
            {label: 'Phone', fieldName: 'Phone', type: 'phone'},
        ]);
        helper.getAcctContacts(component);
    },

    handleRowAction: function(component, event, helper) {
        // action event
        var action = event.getParam("action");
        // row event
        var row = event.getParam("row");

        //row actions and what should happen upon the action being activated
        if (action.name === "viewPage") {
            // specifies that when viewPage is the action's name
            // to call the helper method and specify the parameter to follow
            // a certain structure. In this case, it will be format for URL parsing.
            helper.goToURL('/'+ row.Id);
        }
    }
});