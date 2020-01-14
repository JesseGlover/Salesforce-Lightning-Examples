/**
 * Created by gamedevmadeeasy on 1/9/20.
 */

({
    init: function(component, event, helper) {
        helper.getStateOptions(component);
        helper.getCountryOptions(component);
    },

    onChange: function(component, event, helper) {
        var checkbox = component.find('checkBox');
        component.set("v.isTrue", checkbox.value);
        component.set("v.isChecked", checkbox.value);
    }
});