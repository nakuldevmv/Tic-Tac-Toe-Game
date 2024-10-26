import 'package:flutter/material.dart';
import 'package:flutter_application_1/webView/webViewContainer.dart';

import 'TicTacToe/tictactoe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WebView(child: TicTacToe()),
    );
  }
}
