import 'package:flutter/material.dart';
import 'package:flutter_smart_contract/app/app.locator.dart';
import 'package:flutter_smart_contract/core/viewmodels/outside/signup/signup_view_model.dart';
import 'package:flutter_smart_contract/shared/wallet_icons.dart';
import 'package:flutter_smart_contract/ui/widgets/action/custom_button_icon.dart';
import 'package:flutter_smart_contract/ui/widgets/basic/custom_circle_loading.dart';
import 'package:stacked/stacked.dart';

class CreateWalletWidget extends ViewModelWidget<SignUpViewModel> {
  CreateWalletWidget({Key? key}) : super(key: key);

  final WalletIcons _walletIcons = locator<WalletIcons>();

  @override
  Widget build(BuildContext context, viewModel) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                'Get a piece of papper, write down your seed phrase and keep it safe. This is the only way to recover your funds.',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
              ),
              Container(
                margin: const EdgeInsets.all(25),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
                child: Text(viewModel.mNemonic ?? '',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white)),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CustomButtonIcon(caption: 'Generate New', voidCallback: () => viewModel.generateNewMnemonic()),
                  CustomButtonIcon(
                    caption: 'Confirm & Create Wallet',
                    icon:
                    viewModel.isBusy ? const CustomCircleLoading() : Icon(_walletIcons.gem, color: Colors.orange),
                    voidCallback: () => viewModel.confirmAndCreateWallet(),
                  ),
                  CustomButtonIcon(
                    caption: 'Copy',
                    voidCallback: () => viewModel.copyMnemonic(),
                    icon: const Icon(Icons.copy),
                  ),
                  CustomButtonIcon(
                    caption: 'Back',
                    voidCallback: () => viewModel.backToSetup(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
