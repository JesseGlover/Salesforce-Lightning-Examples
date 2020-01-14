/**
 * Created by gamedevmadeeasy on 1/10/20.
 */

({
    getStateOptions: function(component, event, helper) {
      var options = [];
      var action = component.get("c.getAllStateCodes");
      action.setCallback(this, function(response) {
          var state = response.getState();
          if (state === "SUCCESS") {
              var result = response.getReturnValue();
              result.forEach(function(element) {
                  options.push({value: element, label: element});
              });
              component.set("v.provinceOptions", options);
          }
          else {
              console.log("Failed with state: " + state);
          }
        });
      $A.enqueueAction(action);
    },

    getCountryOptions: function(component, event, helper) {
        var options = [];
        var action = component.get("c.getAllCountryCodes");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                result.forEach(function(element) {
                    options.push({value: element, label: element});
                });
                component.set("v.countryOptions", options);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },

    copyData: function(component, event, helper) {
        component.set("v.billingStreet", component.get("v.shippingStreet").value);
        component.set("v.billingCity", component.get("v.shippingCity").value);
        component.set("v.billingProvince", component.get("v.shippingProvince").value);
        component.set("v.billingCountry", component.get("v.shippingCountry").value);
        component.set("v.billingPostalCode", component.get("v.shippingPostalCode").value);
    }
});