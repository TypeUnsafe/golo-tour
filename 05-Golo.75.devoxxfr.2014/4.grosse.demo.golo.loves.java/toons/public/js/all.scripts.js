function getScripts(){ return [
  
  "js/models/ToonModel.js",
  "js/models/ToonsCollection.js",
  
  
  "js/components/BigTitle.js",
  "js/components/ToonForm.js",
  "js/components/ToonsTable.js",
  "js/main.js"
];};

getScripts().forEach(function(s){
	var script = document.createElement('script');
	script.src = s;
	script.type = "text/jsx";
	document.querySelector('head').appendChild(script);
});


