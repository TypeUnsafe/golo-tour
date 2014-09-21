function getScripts(){ return [
  
  "js/models/HumanModel.js",
  "js/models/HumansCollection.js",
  
  
  ""
];};

getScripts().forEach(function(s){
	var script = document.createElement('script');
	script.src = s;
	//script.type = "text/jsx";
	document.querySelector('head').appendChild(script);
})