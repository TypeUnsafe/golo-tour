define([
    'jquery',
    'underscore',
    'backbone',
	'lazy',
	'text!templates/human.form.tpl.html'
], function($, _, Backbone, Lazy, humanFormTpl){

    var HumanFormView = Lazy.View.extend({
        properties : {
            el : ".human-form-view",
            alias : "human", // for the template,
            template : humanFormTpl
        },
        events : {
            'click .add-human': 'add'
        },
        add : function() {
            this.model.set({firstName:this.getValue(".human-firstName"), lastName:this.getValue(".human-lastName")});

            var newModel = this.model.clone()

            var that = this;

            newModel.save().done(function(){
                that.attributes.collection.fetch().done(function(){
                    that.model.set({firstName:"John", lastName:"Doe"}); // new Model
                    that.render()
                    that.$el.find(".human-firstName").focus()
                });
            })
        }
    });

    return HumanFormView;
});


