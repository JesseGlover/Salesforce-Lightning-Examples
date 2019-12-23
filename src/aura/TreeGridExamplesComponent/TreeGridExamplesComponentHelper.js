/**
 * Created by Jesse Glover on 12/23/19.
 */

({
    // Helper methods to components do not get directly called by the component. They are called by the client side controller.
    getData : function (cmp) {
        // action is getting the data from the Apex method called getTreeData
        var action = cmp.get("c.getTreeData");
        // Welcome to Web development and javascript hell. Callback functions are... fun...
        // A callback function is essentially passing code around within our code to help deal with Asynchronous requests and Client/Server exchanges.
        action.setCallback(this, function(response) {
            // returns an ERROR if the server-side action fails to execute.
            var state = response.getState();
            // If the state's response is success, do something.
            if (state === "SUCCESS") {
                // returns a JavaScript object - the JSON has already been parsed for you.
                var data = response.getReturnValue();
                // set the attribute of gridData to be the parsed JSON data.
                cmp.set('v.gridData', data);
            }
            // error handling when state is "INCOMPLETE" or "ERROR"
        });
        // Sends the function call to the server to be executed at some point.
        $A.enqueueAction(action);
    },

    getRowActions: function(cmp,row,cb){
        //handler function to build actions dynamically
        var actions = [];
        if(row.statusText === 'Completed'){
            actions = [{label:'Proceed',name:'proceed_action'}];
        }else{
            actions = [{label:'Redo', name:'redo_action'}];
        }
        cb(actions);
    }
});