import 'package:flutter/material.dart';
import 'package:flutter_smart_contract/app/app.locator.dart';
import 'package:flutter_smart_contract/core/viewmodels/outside/signup/signup_view_model.dart';
import 'package:flutter_smart_contract/shared/wallet_icons.dart';
import 'package:flutter_smart_contract/ui/widgets/action/custom_button_icon.dart';
import 'package:stacked/stacked.dart';

class SetupWalletWidget extends ViewModelWidget<SignUpViewModel> {
  SetupWalletWidget({Key? key}) : super(key: key, reactive: false);

  final WalletIcons _walletIcons = locator<WalletIcons>();

  @override
  Widget build(BuildContext context, viewModel) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomButtonIcon(
              caption: 'Create new wallet',
              icon: Icon(_walletIcons.gem, color: Colors.orange),
              voidCallback: () => viewModel.onCreateNewWallet()),
          const SizedBox(height: 5.0),
          CustomButtonIcon(
              caption: 'Import wallet',
              icon: Icon(_walletIcons.gem, color: Colors.orange),
              voidCallback: () {}),
        ],
      ),
    );
  }
}
