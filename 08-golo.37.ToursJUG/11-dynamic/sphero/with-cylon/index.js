var Cylon = require('cylon');

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

var randomPrimary = function() {
  var index = Math.floor(Math.random()*COLORS_PRIMARY.length);
  return COLORS_PRIMARY[index];
};

var randomColors = function() {
  var index = Math.floor(Math.random()*COLORS.length);
  return COLORS[index];
};


Cylon.robot({
  connections: {
    sphero: { adaptor: 'sphero', port: '/dev/tty.Sphero-RRY-AMP-SPP' },
    server: { adaptor: 'mqtt', host: 'mqtt://localhost:1883' }
  },

  devices: {
    sphero: { driver: 'sphero' }
  },

  work: function(my) {

    my.server.subscribe('hello'); // listen to hello topic

    // start sphero
    my.sphero.roll(5, Math.floor(Math.random() * 360));
    my.sphero.setRGB(COLORS.GREEN);
    // sphero is started

    // change only if message
    my.server.on('message', function (topic, data) {
      console.log("[Sphero] I've got a message on topic: " + topic + ": " + data);
      var cmds = JSON.parse(data)
      my.sphero.setRGB(COLORS_ALL[cmds.colorIndex]);
      my.sphero.roll(cmds.speed, cmds.direction);
    });

  }

}).start();

// /dev/tty.Sphero-RRY-AMP-SPP
//'/dev/rfcomm0'