import 'package:flutter/material.dart';
import 'package:flutter_smart_contract/ui/views/inside/home/local_widgets/amount.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_smart_contract/core/viewmodels/inside/home/home_view_model.dart';

class Body extends ViewModelWidget<HomeViewModel> {
  const Body({Key? key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, viewModel) {
    return Stack(
      children: [
        Amount(),
      ],
    );
  }
}
