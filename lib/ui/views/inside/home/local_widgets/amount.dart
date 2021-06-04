import 'package:flutter/material.dart';
import 'package:flutter_smart_contract/core/viewmodels/inside/home/home_view_model.dart';
import 'package:stacked/stacked.dart';

class Amount extends ViewModelWidget<HomeViewModel> {
  const Amount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, viewModel) {
    final themes = Theme.of(context);
    return Align(
      alignment: const Alignment(0.0, -0.6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Token', style: themes.textTheme.headline4!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 5),
          Text('Eth',
              style: themes.textTheme.headline6!.copyWith(fontWeight: FontWeight.normal, color: Colors.white70)),
        ],
      ),
    );
  }
}
