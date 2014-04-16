/*--- Toon Model ---*/

var ToonModel = Backbone.Model.extend({
    defaults : function (){
      return {
        name:"?"
      }
    },
    idAttribute: "_id",
    urlRoot : "toons"
});

