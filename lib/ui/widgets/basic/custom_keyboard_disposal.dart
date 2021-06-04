import 'package:flutter/material.dart';

class CustomKeyboardDisposal extends StatelessWidget {
  final Widget child;

  const CustomKeyboardDisposal({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
    );
  }
}
