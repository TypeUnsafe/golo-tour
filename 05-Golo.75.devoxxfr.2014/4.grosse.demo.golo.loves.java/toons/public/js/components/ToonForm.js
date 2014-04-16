/** @jsx React.DOM */

/*
	React.renderComponent(
		<ToonForm/>,
		document.querySelector('ToonForm')
	);
*/

var ToonForm = React.createClass({

	getInitialState: function() {
		return {data : [], message : ""};
	},

	render: function() {
		return (
			<form role="form" className="form-horizontal" onSubmit={this.handleSubmit}>
				<div className="form-group">
						<input className="form-control" type="text" placeholder="name" ref="name"/>
				</div>
				
				<div className="form-group">
					<input className="btn btn-primary" type="submit" value="Add Toon" />
				</div>
				<div className="form-group"><strong>{this.state.message}</strong></div>
			</form>
		);
	},

	componentDidMount: function() {},
	componentWillMount: function() {},
	handleSubmit : function() {
		var name = this.refs.name.getDOMNode().value.trim();
		
		if (!name) {return false;}
		
		var data = {};
		data.name = name;
		

		var toon = new ToonModel(data);

		toon.save()
			.done(function(data) {
				this.setState({
					message : toon.get("_id") + " added!"
				});
				this.refs.name.getDOMNode().value = '';
				
				this.refs.name.getDOMNode().focus();
			}.bind(this))
			.fail(function(err) {
				this.setState({
					message  : err.responseText + " " + err.statusText
				});
			}.bind(this));

		return false;
	}

});
