$(function() {
    window.humans = new App.Collections.Humans();

    humans.fetch({success:function(){
        new App.Views.AddHumanForm({collection: humans});
        new App.Views.HumansList({collection: humans});
    }});

});

