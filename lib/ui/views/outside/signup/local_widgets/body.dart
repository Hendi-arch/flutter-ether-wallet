import 'package:flutter/material.dart';
import 'package:flutter_smart_contract/app/app.locator.dart';
import 'package:flutter_smart_contract/shared/size_config.dart';
import 'package:flutter_smart_contract/shared/wallet_icons.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  final SizeConfig _sizeConfig = locator<SizeConfig>();
  final WalletIcons _walletIcons = locator<WalletIcons>();

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xFFEF3651)));
    return Stack(
      children: [
        Align(
          alignment: const Alignment(0.0, -0.6),
          child: Icon(_walletIcons.ethereum, color: Colors.orange, size: 100),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: _sizeConfig.screenWidth * 0.7,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: buttonStyle,
                  icon: Icon(_walletIcons.gem, color: Colors.orange),
                  label: Text('Create new wallet'),
                ),
              ),
              const SizedBox(height: 5.0),
              Container(
                width: _sizeConfig.screenWidth * 0.7,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: buttonStyle,
                  icon: Icon(_walletIcons.gem, color: Colors.orange),
                  label: Text('Import wallet'),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
