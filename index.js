var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var exphbs = require('express-handlebars');
var exec = require('child_process').execFile;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use('/public', express.static('public'));
app.engine('handlebars', exphbs({ defaultLayout: 'main' }));
app.set('view engine', 'handlebars');




var http = require('http').Server(app);
var io = require('socket.io')(http);

randomArray = (length, max) => [...new Array(length)]
    .map(() => Math.round(Math.random() * max));

app.get('/', function(req, res) {
    res.render('board');
});
app.post('/haskell', function (req, res) {
  //console.log(req);
  exec('./HelloWorld.exe', function(err, data) {
      console.log(data.toString())
    })
    //this post method has the latest info
    //player isnt cur, player is what you get back from exe
  res.send({player: Math.round(Math.random()*2)+1, board:randomArray(14,10)})
})

io.on('connection', function(socket) {
  console.log("new connection")
    socket.on('button click', function(msg) {
      io.emit('button click', msg);
    });
    socket.on('switch player', function(msg) {
      io.emit('switch player', msg);
    });
});

http.listen(3000, function() {
    console.log('Example app listening on port 3000!');
});
