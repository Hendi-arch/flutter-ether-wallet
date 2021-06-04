import 'package:flutter/material.dart';
import 'package:flutter_smart_contract/app/app.locator.dart';
import 'package:flutter_smart_contract/core/viewmodels/outside/signup/signup_view_model.dart';
import 'package:flutter_smart_contract/shared/wallet_icons.dart';
import 'package:stacked/stacked.dart';

class LogoWidget extends ViewModelWidget<SignUpViewModel> {
  LogoWidget({Key? key}) : super(key: key, reactive: false);

  final WalletIcons _walletIcons = locator<WalletIcons>();

  @override
  Widget build(BuildContext context, _) {
    return Align(
      alignment: const Alignment(0.0, -0.6),
      child: Icon(_walletIcons.ethereum, color: Colors.orange, size: 100),
    );
  }
}
