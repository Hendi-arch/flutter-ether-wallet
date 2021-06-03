import 'package:flutter/material.dart';
import 'package:flutter_smart_contract/core/viewmodels/inside/home/home_view_model.dart';
import 'package:stacked/stacked.dart';
import '../home/local_widgets/body.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        builder: (_, __, ___) {
          return Scaffold(
            appBar: AppBar(centerTitle: true, title: Text('Xulu System Chain')),
            body: Body(),
          );
        },
        viewModelBuilder: () => HomeViewModel());
  }
}
