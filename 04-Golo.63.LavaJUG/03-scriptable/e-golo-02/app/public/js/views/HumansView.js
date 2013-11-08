define([
    'jquery',
    'underscore',
    'backbone',
		'lazy',
    'text!templates/humans.tpl.html'
], function($, _, Backbone, Lazy, humansTpl){

    var HumansView = Lazy.View.extend({
        properties : {
            el : ".humans-view",
            template : humansTpl,
            alias : "humans" // for the template
        },
        events : {
            'click .select': 'select',
            'click .delete': 'delete'
        },
        select : function(e) {
            console.log(this.getHashValue(e))
        }
        ,
        delete : function(e) {

            this.collection.get(this.getHashValue(e)).destroy().done(function(){
                console.log("deleted ...");
            })
        }
    });

    return HumansView;
});