define([
    'backbone'
], function(Backbone){

    var Human = Backbone.Model.extend({
        defaults : {
            firstName : "John",
            lastName : "Doe"
        },
        urlRoot : "/humans"
    });
    return Human;
});