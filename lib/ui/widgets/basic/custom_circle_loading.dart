import 'package:flutter/material.dart';

class CustomCircleLoading extends StatelessWidget {
  final double size;

  const CustomCircleLoading({Key? key, this.size = 25}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      SizedBox(width: size, height: size, child: CircularProgressIndicator(strokeWidth: 2.0, color: Colors.orange));
}
