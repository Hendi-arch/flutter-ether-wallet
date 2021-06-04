import 'package:flutter/material.dart';
import 'package:flutter_smart_contract/core/viewmodels/outside/signup/signup_view_model.dart';
import 'package:flutter_smart_contract/ui/views/outside/signup/local_widgets/body.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.nonReactive(
        builder: (_, __, ___) {
          return Scaffold(
            backgroundColor: Colors.deepPurpleAccent,
            body: Body(),
          );
        },
        viewModelBuilder: () => SignUpViewModel());
  }
}
