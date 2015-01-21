var Cylon = require('cylon');
var colors = require('colors');

var direction = 0;
var speed = 100;

var COLORS = {
  BLACK:  0x000000,
  BLUE:   0x0000ff,
  GREEN:  0x00ff00,
  ORANGE: 0xff4500,
  PINK:   0xff1444,
  PURPLE: 0xff00ff,
  RED:    0xff0000,
  WHITE:  0xffffff,
  YELLOW: 0xffff00
};

var COLORS_ALL = [
  COLORS.RED, 
  COLORS.GREEN, 
  COLORS.BLUE, 
  COLORS.ORANGE, 
  COLORS.PINK, 
  COLORS.PURPLE, 
  COLORS.WHITE, 
  COLORS.YELLOW, 
  COLORS.BLACK
];

var COLORS_NAMES = [
  "red", "green", "blue", "orange", "pink", "purple", "white", "yellow", "black"
]

var randomColors = function() {
  var index = Math.floor(Math.random()*COLORS.length);
  return COLORS_ALL[index];
};

var getColorName = function(index) {
  return COLORS_NAMES[index]
}


Cylon.robot({
  connections: {
    server: { adaptor: 'mqtt', host: 'mqtt://localhost:1883' }
  },

  work: function(my) {
    // faking sphero
    my.sphero = { 
      roll: function(speed, direction) {
        console.log("roll", speed, direction)
      },
      setRGB: function(color) {
        var index = COLORS_ALL.indexOf(color)
        /*
        pink -> magenta 4 
        purple -> cyan 5
        orange -> yellow 3
        */
        var colorName = getColorName(index)
        if(colorName=="pink") {colorName="magenta"}
        if(colorName=="purple") {colorName="cyan"}
        if(colorName=="orange") {colorName="yellow"}

        console.log(colors[colorName]("[setRGB] color: %s | %s"), color, getColorName(index), colorName)
      }
    }

    my.server.subscribe('hello'); // listen to hello topic

    // start sphero
    my.sphero.roll(5, Math.floor(Math.random() * 360));
    my.sphero.setRGB(COLORS.GREEN);

    // change only if message
    my.server.on('message', function (topic, data) {
      console.log("[Sphero] I've got a message on topic: " + topic + ": " + data);
      var cmds = JSON.parse(data)
      my.sphero.setRGB(COLORS_ALL[cmds.colorIndex]);
      my.sphero.roll(cmds.speed, cmds.direction);
      
    });

  }

}).start();






