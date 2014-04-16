/** @jsx React.DOM */

/*
	React.renderComponent(
		<ToonsTable pollInterval={500}/>,
		document.querySelector('ToonsTable')
	);
*/

var ToonsTable = React.createClass({

	getInitialState: function() {
		return {
		    data : []
		  , message : ""
      , selectedToonIdForUpdate : null
      , timer : null
      , name : null
      
		};
	},
  handleChange: function(name, event) { //see http://facebook.github.io/react/docs/forms.html
    var change = {};
    change[name] = event.target.value;
    this.setState(change)
  },
	render: function() {

	  var toonRow = function(toon) {

	    if(toon._id == this.state.selectedToonIdForUpdate) {

           var name = this.state.name
          

          var cancelLink = "#cancel_update_toon/" + toon._id;
          var validateLink = "#validate_update_toon/" + toon._id;

          return (
            <tr>
              <td><input className="form-control" type="text" value={name} ref="name" onChange={ this.handleChange.bind(this, "name") }/></td>
              
              <td><a className="btn btn-primary" href={validateLink}>validate</a></td>
              <td><a className="btn btn-primary" href={cancelLink}>cancel</a></td>
            </tr>
          );

	    }

	    if(toon._id != this.state.selectedToonIdForUpdate) {
        var deleteLink = "#delete_toon/" + toon._id;
        var updateLink = "#display_update_toon_form/" + toon._id;

        return (
          <tr>
            <td>{toon.name}</td>
            
            <td><a className="btn btn-primary" href={deleteLink}>delete</a></td>
            <td><a className="btn btn-primary" href={updateLink}>edit</a></td>
          </tr>
        );

	    }


	  }.bind(this)

		var toonsRows = this.state.data.map(function(toon){
      return toonRow(toon);
		});

		return (
			<div className="table-responsive">
				<strong>{this.state.message}</strong>
				<table className="table table-striped table-bordered table-hover" >
					<thead>
						<tr>
							<th>name</th>
							<th></th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						{toonsRows}
					</tbody>
				</table>
			</div>
		);
	},

	getToons : function() {

		var toons = new ToonsCollection();

		toons.fetch()
			.done(function(data){
				this.setState({data : toons.toJSON(), message : Date()});
			}.bind(this))
			.fail(function(err){
				this.setState({
					message  : err.responseText + " " + err.statusText
				});
			}.bind(this))
	},

  updateToon : function(toonId) {

     var name = this.refs.name.getDOMNode().value.trim();
    

    var data = {};
    data._id = toonId;

     data.name = name;
    


    var toon = new ToonModel(data);

    toon.save()
      .done(function(data) {
        this.setState({
          message : toon.get("_id") + " updates!"
        });
      }.bind(this))
      .fail(function(err) {
        this.setState({
          message  : err.responseText + " " + err.statusText
        });
      }.bind(this));
  },

	componentWillMount: function() {
		this.getToons();
		this.setState({timer : setInterval(this.getToons, this.props.pollInterval)});
		//setInterval(this.getToons, this.props.pollInterval);
	},

	componentDidMount: function() {
		var Router = Backbone.Router.extend({
			routes : {
				"delete_toon/:id" : "deleteToon",
        "display_update_toon_form/:id" : "displayUpdateToonForm",
        "cancel_update_toon/:id" : "hideUpdateToonForm",
        "validate_update_toon/:id" : "validateUpdateToon"
			},
			initialize : function() {
				console.log("Initialize router of ToonsTable component");
			},
			deleteToon : function(id){
				console.log("=== delete toon ===", id);
				new ToonModel({_id:id}).destroy();
				this.navigate('/');
			},
      displayUpdateToonForm : function(id){
        console.log("=== update toon form ===", id);
        this.setState({selectedToonIdForUpdate : id})

        var toon = new ToonModel({_id:id}).fetch().done(
          function(data) {
            this.setState({
                message : ""
              , name : data.name
              
            });
          }.bind(this)
        );

        //clearInterval(this.state.timer)
      }.bind(this),
      hideUpdateToonForm : function(id){ // when cancel
        console.log("=== hide toon form ===", id);
        this.setState({selectedToonIdForUpdate : null})
        //this.setState({timer : setInterval(this.getToons, this.props.pollInterval)});
      }.bind(this),
      validateUpdateToon : function(id){
        console.log("=== update toon to server ===", id);
        this.updateToon(this.state.selectedToonIdForUpdate)
        this.setState({selectedToonIdForUpdate : null})
        //this.setState({timer : setInterval(this.getToons, this.props.pollInterval)});
      }.bind(this)
		});
		this.router = new Router()
	}

});
