import 'package:flutter/material.dart';
import 'package:flutter_smart_contract/core/viewmodels/outside/signup/signup_view_model.dart';
import 'package:flutter_smart_contract/ui/views/outside/signup/local_widgets/body.dart';
import 'package:flutter_smart_contract/ui/widgets/basic/custom_ignore_widget.dart';
import 'package:flutter_smart_contract/ui/widgets/basic/custom_keyboard_disposal.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.nonReactive(
        builder: (_, viewModel, ___) {
          return CustomIgnoredWidget(
            ignored: viewModel.isBusy,
            childToBeIgnored: CustomKeyboardDisposal(
              child: Scaffold(
                body: Body(),
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.deepPurpleAccent,
              ),
            ),
          );
        },
        viewModelBuilder: () => SignUpViewModel());
  }
}
