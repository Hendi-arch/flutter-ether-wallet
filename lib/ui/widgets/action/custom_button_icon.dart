import 'package:flutter/material.dart';
import 'package:flutter_smart_contract/shared/size_config.dart';
import 'package:flutter_smart_contract/app/app.locator.dart';

class CustomButtonIcon extends StatelessWidget {
  final Widget? icon;
  final String caption;
  final VoidCallback? voidCallback;

  CustomButtonIcon({Key? key, required this.caption, this.voidCallback, this.icon}) : super(key: key);

  final SizeConfig _sizeConfig = locator<SizeConfig>();

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xFFEF3651)));
    return Container(
      width: _sizeConfig.screenWidth * 0.7,
      child: ElevatedButton.icon(
        style: buttonStyle,
        label: Text(caption),
        onPressed: voidCallback,
        icon: icon ?? const SizedBox.shrink(),
      ),
    );
  }
}
