/**
 * Created by gamedevmadeeasy on 12/24/19.
 */

({
    getData : function (cmp) {
        var action = cmp.get("c.treeData");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var data = response.getReturnValue();
                cmp.set('v.gridData', data);
            }
            // error handling when state is "INCOMPLETE" or "ERROR"
        });
        $A.enqueueAction(action);
    }
});