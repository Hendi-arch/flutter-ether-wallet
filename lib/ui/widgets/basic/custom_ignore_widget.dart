import 'package:flutter/material.dart';

class CustomIgnoredWidget extends StatelessWidget {
  final bool ignored;
  final Widget childToBeIgnored;

  const CustomIgnoredWidget({Key? key, required this.childToBeIgnored, required this.ignored}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: ignored,
      child: childToBeIgnored,
    );
  }
}
