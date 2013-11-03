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
        }
    });

    return HumansView;
});