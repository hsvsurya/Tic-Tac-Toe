import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        buttonColor: Colors.deepOrangeAccent,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _string = '';
  bool state = true;
  List blocks = [
    [
      '',
      '',
      '',
    ],
    [
      '',
      '',
      '',
    ],
    [
      '',
      '',
      '',
    ],
  ];

  @override
  void initState() {
    if (_string == 'Player 1 Won') {
      _string = 'Player 1 Won';
    }
    if (_string == 'Player 2 Won') {
      _string = 'Player 2 Won';
    }
    super.initState();
  }

  void change(int i, int j) {
    setState(() {
      if (state) {
        if (blocks[i][j] == '') {
          blocks[i][j] = 'O';
          gameOver();
          state = !state;
        }
      } else {
        if (blocks[i][j] == '') {
          blocks[i][j] = 'X';
          gameOver();
          state = !state;
        }
      }
    });
  }

  Widget manage(int i, int j) {
    return InkWell(
      onTap: () {
        change(i, j);
      },
      child: Container(
        padding: EdgeInsets.all(50),
        child: Text(
          blocks[i][j],
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  bool win(String l) {
    if ((blocks[0][0] == l && blocks[0][1] == l && blocks[0][2] == l) ||
        (blocks[1][0] == l && blocks[1][1] == l && blocks[1][2] == l) ||
        (blocks[2][0] == l && blocks[2][1] == l && blocks[2][2] == l) ||
        (blocks[0][0] == l && blocks[1][1] == l && blocks[2][2] == l) ||
        (blocks[0][2] == l && blocks[1][1] == l && blocks[2][0] == l) ||
        (blocks[0][0] == l && blocks[1][0] == l && blocks[2][0] == l) ||
        (blocks[0][1] == l && blocks[1][1] == l && blocks[2][1] == l) ||
        (blocks[0][2] == l && blocks[1][2] == l && blocks[2][2] == l)) {
      return true;
    }
    return false;
  }

  void gameOver() {
    if (win('O')) {
      setState(() {
        if (_string == '') {
          _string = 'Player 1 Won';
        }
      });
    }
    if (win('X')) {
      setState(() {
        if (_string == '') {
          _string = 'Player 2 Won';
        }
      });
    }
    if (blocks[0][0] != '' &&
        blocks[0][1] != '' &&
        blocks[0][2] != '' &&
        blocks[1][0] != '' &&
        blocks[1][1] != '' &&
        blocks[1][2] != '' &&
        blocks[2][0] != '' &&
        blocks[2][1] != '' &&
        blocks[2][2] != '') {
      setState(() {
        if (_string == '') {
          _string = 'GAMEOVER';
        }
      });
    }
  }

  void erase() {
    setState(() {
      blocks = [
        [
          '',
          '',
          '',
        ],
        [
          '',
          '',
          '',
        ],
        [
          '',
          '',
          '',
        ],
      ];
      _string = '';
      state = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Player 1 - O',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Player 2 - X',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          state ? Text('Player 1\'s turn') : Text('Player 2\'s turn'),
          Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Table(
                border: TableBorder.all(
                    color: Colors.black, style: BorderStyle.solid),
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                    ),
                    children: [
                      manage(0, 0),
                      manage(0, 1),
                      manage(0, 2),
                    ],
                  ),
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                    ),
                    children: [
                      manage(1, 0),
                      manage(1, 1),
                      manage(1, 2),
                    ],
                  ),
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                    ),
                    children: [
                      manage(2, 0),
                      manage(2, 1),
                      manage(2, 2),
                    ],
                  ),
                ],
              ),
            ),
          ),
          RaisedButton(
            color: Theme.of(context).buttonColor,
            child: Text(
              'Clear',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: erase,
          ),
          Text(
            _string,
            style: TextStyle(
              color: _string == 'GAMEOVER'
                  ? Theme.of(context).errorColor
                  : Colors.green,
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
