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
  var body = req.body;
  var choice = body['choice'];
  var player = body['player[]'];
  var board = body['board[]'];
  //body parser added whitespace
  board[0] = board[0].trim();
  board[7] = board[7].trim();
  var str = board.join(" ");
  var commands = `${player} ${choice} ${str}`;
  console.log(`./Main ${commands}`);

  exec(`./Main ${commands}`, function(err, data) {
    console.log(data);
    var board = JSON.parse("[" + data.substring(5, (data.length - 1)) + "]"); //array
    var pWinner = parseInt(data.substring(0,1)); //string of a number
    var pCurrent = parseInt(data.substring(3,4));
    console.log(err);
    console.log(board);
    })

    res.send({board: board.splice(0,13), player: board[14]+1,winner: board[15]});
  // res.send({player: Math.round(Math.random()*2)+1, board:randomArray(14,10)});
})

io.on('connection', function(socket) {
  console.log("new connection")
    socket.on('button click', function(msg) {
      io.emit('button click', msg);
    });
    socket.on('switch player', function(msg) {
      io.emit('switch player', msg);
    });
    socket.on('restart', function(msg) {
      io.emit('restart', msg);
    });
});

http.listen(3000, function() {
    console.log('Example app listening on port 3000!');
});
