import 'package:basic_services/basic_services.dart';
import 'package:flutter_smart_contract/app/app.locator.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel {
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();

  @override
  void onFutureError(error, Object? key) {
    _bottomSheetService.showBottomSheet(title: 'Message', description: error);
    super.onFutureError(error, key);
  }
}
