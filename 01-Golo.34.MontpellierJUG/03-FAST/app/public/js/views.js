App.Views.AddHumanForm = Backbone.View.extend({
    el:"#human_form",
    initialize:function (arg) {

        this.collection = arg.collection;
        this.model = new App.Models.Human();
        rivets.bind(this.$el, {human:this.model});
    },
    events:{
        "click button" : function(){

            var human =  this.model.clone();
            var collectionView = this.collection;

            human.save({},{success:function(){
                collectionView.add(human)
            }})


        }
    }
});

App.Views.HumansList = Backbone.View.extend({
    el:"#humans_list",
    initialize:function (arg) {
        this.collection = arg.collection;
        rivets.bind(this.$el, {humans:this.collection});
    },
    events:{
        "click button" : function(event){
            var modelId = event.target.id
            //console.log(modelId)

            this.collection.find(function(model){
                return model.id == modelId;
            }).destroy()

        }

    }
});