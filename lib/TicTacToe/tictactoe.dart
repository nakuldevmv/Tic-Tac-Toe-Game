import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> _board = List.generate(9, (index) => '');
  String _currentPlayer = 'X';
  int _scoreX = 0;
  int _scoreO = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            " Tic Tac Toe ",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Player X: $_scoreX',
                    style: const TextStyle(fontSize: 24)),
                Text('Player O: $_scoreO',
                    style: const TextStyle(fontSize: 24)),
                // ElevatedButton(
                //     onPressed: _resetScore(),
                //     child: const Icon(Icons.restart_alt_rounded))
              ],
            ),
          ),
          Container(
            // color: const Color.fromARGB(255, 221, 70, 70),
            // decoration: BoxDecoration(),
            child: Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_board[index] == '') {
                              _board[index] = _currentPlayer;
                              if (_checkWin(_currentPlayer)) {
                                _showWinDialoge(_currentPlayer);
                                _updateScore(_currentPlayer);
                              } else if (_board
                                  .every((Element) => Element.isNotEmpty)) {
                                _showDrawDialoge();
                              } else {
                                _currentPlayer =
                                    _currentPlayer == 'X' ? 'O' : 'X';
                              }
                            }
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Center(
                            // child: Text(
                            //   _board[index] == ''
                            //       ? index.toString()
                            //       : _board[index],
                            //   style: const TextStyle(fontSize: 40),
                            // ),
                            child: Text(
                              _board[index],
                              style: const TextStyle(fontSize: 40),
                            ),
                          ),
                        ),
                      );
                    })),
          ),
        ],
      ),
    );
  }

  bool _checkWin(String player) {
    List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var pattern in winPatterns) {
      if (_board[pattern[0]] == player &&
          _board[pattern[1]] == player &&
          _board[pattern[2]] == player) {
        return true;
      }
    }
    return false;
  }

  void _showWinDialoge(String winner) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Winner!"),
            content: Text("$winner has won the game!"),
            actions: [
              TextButton(
                  onPressed: () {
                    _resetGame();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Restart"))
            ],
          );
        });
  }

  void _showDrawDialoge() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Draw"),
            actions: [
              TextButton(
                  onPressed: () {
                    _resetGame();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Restart"))
            ],
          );
        });
  }

  void _updateScore(String winner) {
    setState(() {
      if (winner == 'X') {
        _scoreX += 1;
        print(_scoreX);
      } else if (winner == 'O') {
        _scoreO += 1;
        print(_scoreO);
      }
    });
  }

  void _resetGame() {
    setState(() {
      _board = List.generate(9, (index) => '');
      _currentPlayer = 'X';
    });
  }

  void _resetScore() {
    setState(() {});
  }
}
