import 'package:flutter/material.dart';
import 'package:flutter_smart_contract/core/constant/enums.dart';
import 'package:flutter_smart_contract/core/viewmodels/outside/signup/signup_view_model.dart';
import 'package:flutter_smart_contract/ui/views/outside/signup/local_widgets/create_wallet_widget.dart';
import 'package:stacked/stacked.dart';
import 'logo_widget.dart';
import 'setup_wallet_widget.dart';

class Body extends ViewModelWidget<SignUpViewModel> {
  Body({Key? key}) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, viewModel) {
    return Stack(
      children: [
        LogoWidget(),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            final anim = Tween<Offset>(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0));

            return SlideTransition(position: anim.animate(animation), child: child);
          },
          child: viewModel.walletCreateSteps == WalletCreateSteps.setup ? SetupWalletWidget() : CreateWalletWidget(),
        ),
      ],
    );
  }
}
