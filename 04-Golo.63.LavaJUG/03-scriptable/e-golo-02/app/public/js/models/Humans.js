define([
    'backbone',
    'models/Human'
], function(Backbone, Human){

    var Humans = Backbone.Collection.extend({
        model : Human,
        url : "/humans"
    });

    return Humans
});