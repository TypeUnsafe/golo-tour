App.Models.Human = Backbone.Model.extend({
    urlRoot:"/humans",
    defaults:{
        firstName:"John", lastName:"Doe"
    }
});

App.Collections.Humans = Backbone.Collection.extend({
    url:"/humans",
    model:App.Models.Human
});