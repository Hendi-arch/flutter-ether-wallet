import 'package:flutter/material.dart';
import 'package:flutter_smart_contract/app/app.locator.dart';
import 'package:flutter_smart_contract/core/constant/enums.dart';
import 'package:flutter_smart_contract/core/viewmodels/outside/signup/signup_view_model.dart';
import 'package:flutter_smart_contract/shared/wallet_icons.dart';
import 'package:flutter_smart_contract/ui/widgets/action/custom_button_icon.dart';
import 'package:flutter_smart_contract/ui/widgets/basic/custom_circle_loading.dart';
import 'package:stacked/stacked.dart';

class ImportWalletWidget extends ViewModelWidget<SignUpViewModel> {
  ImportWalletWidget({Key? key}) : super(key: key);

  final WalletIcons _walletIcons = locator<WalletIcons>();

  @override
  Widget build(BuildContext context, viewModel) {
    final _radioTextStyle = Theme.of(context).textTheme.button!.copyWith(color: Colors.white);
    final _inputBorder =
        OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.orange));

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Radio(
                      activeColor: Colors.orange,
                      value: WalletImportType.mNemonic,
                      groupValue: viewModel.walletImportType,
                      onChanged: (v) => viewModel.walletImportType = v as WalletImportType),
                  Text('Seed', style: _radioTextStyle)
                ],
              ),
              Row(
                children: [
                  Radio(
                      activeColor: Colors.orange,
                      value: WalletImportType.privateKey,
                      groupValue: viewModel.walletImportType,
                      onChanged: (v) => viewModel.walletImportType = v as WalletImportType),
                  Text('Private key', style: _radioTextStyle)
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              maxLines: 1,
              textInputAction: TextInputAction.done,
              controller: viewModel.textEditingController,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
              decoration: InputDecoration(
                  border: _inputBorder,
                  enabledBorder: _inputBorder,
                  focusedBorder: _inputBorder,
                  hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white70),
                  hintText: viewModel.walletImportType == WalletImportType.mNemonic ? 'Seed phrase' : 'Private key'),
            ),
          ),
          const SizedBox(height: 10),
          CustomButtonIcon(
            caption: 'Import',
            voidCallback: () => viewModel.importWallet(),
            icon: viewModel.isBusy ? const CustomCircleLoading() : Icon(_walletIcons.gem, color: Colors.orange),
          ),
          CustomButtonIcon(
            caption: 'Back',
            voidCallback: () => viewModel.backToSetup(),
            icon: const Icon(Icons.arrow_back),
          ),
        ],
      ),
    );
  }
}
