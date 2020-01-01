/**
 * Created by gamedevmadeeasy on 12/24/19.
 */

({
    doInit: function (cmp, event, helper) {
        cmp.set('v.gridColumns', [
            {label: 'name', fieldName: 'name', type: 'text'},
            {label: 'label', fieldName: 'label', type: 'text'},
        ]);
        helper.getData(cmp);
    }
});