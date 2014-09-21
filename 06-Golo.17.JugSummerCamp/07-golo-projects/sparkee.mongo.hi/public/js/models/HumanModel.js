/*--- Human Model ---*/

var HumanModel = Backbone.Model.extend({
    defaults : function (){
      return {
        firstName:'john', lastName:'doe'
      }
    },
    urlRoot : "humans"
});

