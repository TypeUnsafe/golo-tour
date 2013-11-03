/*=== helpers ===*/

_.extend(Backbone.View.prototype,{
    tpl : function() {/*
     <H1>your template here</H1>
     */},
    getTpl : function() {
        return this.tpl.toString().split("/*")[1].split("*/")[0]
    },

    getValue : function(selector) {
        return this.$el.find(selector).val();
    }
    ,
    getText : function(selector) {
        return this.$el.find(selector).text();
    },
    getHashValue : function(e) {
        return e.target.hash.split("#")[1];
    },
    getDataValue : function(e) {
        return e.target.dataset.value;
    },
    getData : function(what, e) {
        return e.target.dataset[what];
    }

});

