import 'dart:math';

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
      backgroundColor: Colors.amber,
      // appBar: AppBar(
      //   title: const Center(
      //     child: Text(
      //       " Tic Tac Toe ",
      //       style: TextStyle(
      //           fontWeight: FontWeight.bold,
      //           color: Color.fromARGB(255, 218, 72, 72)),
      //     ),
      //   ),
      //   backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      // ),
      body: Container(
        width: 500,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xff421b65), Color(0xff55a6c3)],
          stops: [0, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            const Text("TIC TAC TOE",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(
              height: 70,
            ),
            Container(
              width: 350,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(124, 55, 50, 78),
                      Color.fromARGB(124, 140, 162, 169)
                    ],
                    stops: [0, 1],
                    begin: Alignment(-2.0, -1.0),
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Player X : $_scoreX',
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text('Player O : $_scoreO',
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(177, 26, 39, 49),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(100),
                            topRight: Radius.circular(100),
                            bottomLeft: Radius.circular(60),
                            bottomRight: Radius.circular(60),
                          ),
                        ),
                        elevation: 10,
                        shadowColor: const Color.fromARGB(255, 0, 0, 0),
                        minimumSize: const Size(60, 60),
                        // padding:
                        //     const EdgeInsets.fromLTRB(0, 0, 20, 0), // padding
                      ),
                      onPressed: _resetScore,
                      child: const Icon(
                          size: 40,
                          color: Color.fromARGB(255, 145, 238, 255),
                          Icons.restart_alt_rounded))
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 400,
              width: 350,
              // margin: const EdgeInsets.all(10),
              child: Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
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
                            // padding: const EdgeInsets.all(50),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(201, 41, 17, 62),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              border: Border.all(
                                width: 1.5,
                                color: const Color.fromARGB(198, 255, 255, 255),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                _board[index],
                                style: const TextStyle(
                                    fontSize: 75,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      })),
            ),
          ],
        ),
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
            backgroundColor: const Color.fromARGB(255, 39, 30, 42),
            // title: const Text("Winner!",
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold)),

            content: Text(
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                "$winner Has Won The Game!"),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(176, 131, 194, 242),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100),
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60),
                      ),
                    ),
                    elevation: 10,
                    shadowColor: const Color.fromARGB(255, 0, 0, 0),
                    // minimumSize: const Size(60, 60),
                    // padding:
                    //     const EdgeInsets.fromLTRB(0, 0, 20, 0), // padding
                  ),
                  onPressed: () {
                    _resetGame();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                      style: TextStyle(color: Colors.white), "RESTART"))
            ],
          );
        });
  }

  void _showDrawDialoge() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 39, 30, 42),
            // title: const Text("Draw!",
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold)),
            content: const Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                "We Have A Draw!"),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(176, 131, 194, 242),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100),
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60),
                      ),
                    ),
                    elevation: 10,
                    shadowColor: const Color.fromARGB(255, 0, 0, 0),
                    // minimumSize: const Size(60, 60),
                    // padding:
                    //     const EdgeInsets.fromLTRB(0, 0, 20, 0), // padding
                  ),
                  onPressed: () {
                    _resetGame();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                      style: TextStyle(color: Colors.white), "RESTART"))
            ],
          );
        });
  }

  void _updateScore(String winner) {
    setState(() {
      if (winner == 'X') {
        _scoreX += 1;
      } else if (winner == 'O') {
        _scoreO += 1;
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
    setState(() {
      _scoreX = 0;
      _scoreO = 0;
      _board = List.generate(9, (index) => '');
      _currentPlayer = 'X';
    });
  }
}
