import 'package:basic_services/basic_services.dart';
import 'package:flutter_smart_contract/app/app.locator.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel with ExceptionServiceMixin {
  BottomSheetService _bottomSheetService = locator<BottomSheetService>();

  @override
  onFutureError(dynamic error, Object? key) {
    _bottomSheetService.showBottomSheet(title: 'Message', description: error.toString());
    super.onFutureError(error, key);
  }
}
