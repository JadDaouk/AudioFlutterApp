import 'package:flutter/material.dart';
import 'package:technical_test/pages/HomePage.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: TechnicalTest()),
  );
}

class TechnicalTest extends StatelessWidget {
  const TechnicalTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}
