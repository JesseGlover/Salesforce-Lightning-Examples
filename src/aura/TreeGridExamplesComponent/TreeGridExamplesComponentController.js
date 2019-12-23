/**
 * Created by Jesse Glover on 12/23/19.
 */

({
    // The client side controller calls helper methods and is directly called by the webpage / component.
    doInit: function(cmp,event,helper){
        //call actions from handler function
        var actions = helper.getRowActions.bind(this, cmp);

        // gridCols is the variable that takes an object array as an argument.
        var gridCols = [
            // the label is the name that will be displayed on the webpage,
            // the fieldName is the name associated within the database
            // the type specifies the actual typing of the object on the webpage and
            // doesn't have to match the type on the database.
            {label: 'Name', fieldName: 'Name', type: 'text'},
            // For the action type, it requires a different parameter of typeAttributes
            // In this case, it is of type rowActions which takes the actions variable
            // to bind it's value to.
            {type: 'action', typeAttributes: { rowActions: actions} }
        ];
        // Set's the gridCols attribute value to be the gridCols created above.
        cmp.set('v.gridCols',gridCols);

        // Calls the helper function called getData and passes the component as the parameter.
        helper.getData(cmp);

    },

    onRowSelect: function(cmp,event,helper){
        var action = event.getParam('action');
        var row = event.getParam('row');
        switch (action.name) {
            case 'proceed_action':
                helper.rowActions(cmp, row, event);
                break;
            case 'redo_action':
                //redo action things to do goes here
                break;
        }
    }
});