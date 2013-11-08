define([
    'jquery',
    'underscore',
    'backbone',
    'bootstrap',
	'models/Human',
    'models/Humans',
    'views/HumansView',
    'views/HumanFormView',
    'lazy'
], function(
	    $, _, Backbone
	,   bootstrap
	,   Human, Humans
	,   HumansView, HumanFormView
    ,   Lazy)
{
    var Application = Lazy.Application.extend({

	    routes : {
		    '*actions': 'defaultAction'
	    },

        initialize : function() { //initialize models, collections and views ...
            this.humans = new Humans();

            this.humansView = new HumansView({ collection : this.humans });
            this.humanFormView = new HumanFormView({ model : new Human(), attributes : {collection : this.humans } });

            this.humans.fetch();

            this.humanFormView.render();

        },
        defaultAction: function(action) {}
    });

    return Application;
});
