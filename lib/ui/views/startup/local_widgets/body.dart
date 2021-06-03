import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: const CircularProgressIndicator(
        backgroundColor: Colors.white, valueColor: AlwaysStoppedAnimation<Color>(Colors.green)),
  );
}
