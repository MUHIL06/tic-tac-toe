import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TicTacToeGame(),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  late List<List<String>> board;
  late String currentPlayer;
  String? winner;

  _TicTacToeGameState() {
    initializeBoard();
  }

  void initializeBoard() {
    board = List.generate(3, (i) => List.generate(3, (j) => ''));
    currentPlayer = 'X';
    winner = null;
  }

  void makeMove(int row, int col) {
    if (board[row][col] == '' && winner == null) {
      setState(() {
        board[row][col] = currentPlayer;
        if (checkWinner(row, col)) {
          winner = currentPlayer;
        } else if (isBoardFull()) {
          winner = 'Draw';
        } else {
          currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
        }
      });
    }
  }

  bool checkWinner(int row, int col) {
    return (board[row][0] == currentPlayer && board[row][1] == currentPlayer &&
        board[row][2] == currentPlayer) ||
        (board[0][col] == currentPlayer && board[1][col] == currentPlayer &&
            board[2][col] == currentPlayer) ||
        (row == col && board[0][0] == currentPlayer &&
            board[1][1] == currentPlayer && board[2][2] == currentPlayer) ||
        (row + col == 2 && board[0][2] == currentPlayer &&
            board[1][1] == currentPlayer && board[2][0] == currentPlayer);
  }

  bool isBoardFull() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == '') {
          return false;
        }
      }
    }
    return true;
  }

  Widget buildSquare(int row, int col) {
    return GestureDetector(
      onTap: () {
        makeMove(row, col);
      },
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 3.0, // Increase the border thickness
          ),
        ),
        child: Center(
          child: Text(
            board[row][col],
            style: TextStyle(fontSize: 40.0, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget buildBoard() {
    List<Row> rows = List.generate(3, (i) {
      List<Widget> squares = List.generate(3, (j) {
        return buildSquare(i, j);
      });
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: squares,
      );
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: rows,
    );
  }

  void resetGame() {
    setState(() {
      initializeBoard();
    });
  }

  void showWinnerDialog(String? winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (winner == 'Draw') {
          return AlertDialog(
            title: Text('Match Draw 😢', style: TextStyle(fontSize: 40.0, color: Colors.white)),
            actions: <Widget>[
              ElevatedButton(
                onPressed: resetGame,
                child: Text('Restart Game', style: TextStyle(fontSize: 40.0, color: Colors.white)),
              ),
            ],
          );
        } else {
          return AlertDialog(
            title: Text('Winner: $winner 🎉', style: TextStyle(fontSize: 40.0, color: Colors.white)),
            actions: <Widget>[
              ElevatedButton(
                onPressed: resetGame,
                child: Text('Restart Game', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/dark.jpeg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('   PLAYER_1 : X', style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold)),
                  Text('PLAYER_2 : O   ', style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
              buildBoard(),
              SizedBox(height: 20.0),
              (winner != null)
                  ? (winner == 'Draw')
                  ? Column(
                children: [
                  Text('Match Draw 😢', style: TextStyle(fontSize: 25.0, color: Colors.white)),
                  ElevatedButton(
                    onPressed: resetGame,
                    child: Text('Restart Game', style: TextStyle(color: Colors.white)),
                  ),
                ],
              )
                  : Column(
                children: [
                  Text('Winner: $winner 🥳🎉', style: TextStyle(fontSize: 25.0, color: Colors.white)),
                  ElevatedButton(
                    onPressed: resetGame,
                    child: Text('Restart Game', style: TextStyle(color: Colors.white)),
                  ),
                ],
              )
                  : Text('Current Player: $currentPlayer', style: TextStyle(fontSize: 25.0, color: Colors.white)),
              SizedBox(height: 25.0),
            ],
          ),
        ),
      ),
    );
  }
}





















