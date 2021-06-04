import 'package:basic_services/basic_services.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_contract/app/app.locator.dart';
import 'package:flutter_smart_contract/core/constant/enums.dart';
import 'package:flutter_smart_contract/core/services/address_service.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel {
  // service
  final AddressService _addressService = locator<AddressService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();

  // properties
  String? _mNemonic;
  WalletCreateSteps _walletCreateSteps = WalletCreateSteps.setup;

  // gets
  String? get mNemonic => _mNemonic;
  WalletCreateSteps get walletCreateSteps => _walletCreateSteps;

  @override
  void onFutureError(error, Object? key) {
    _bottomSheetService.showBottomSheet(title: 'Message', description: error);
    super.onFutureError(error, key);
  }

  onCreateNewWallet() {
    _mNemonic = _addressService.generateMnemonic();
    _walletCreateSteps = WalletCreateSteps.confirm;
    notifyListeners();
  }

  Future<void> copyMnemonic() async {
    await Clipboard.setData(ClipboardData(text: mNemonic));
    _bottomSheetService.showBottomSheet(title: 'Message', description: 'Copied');
  }

  backToSetup() {
    _walletCreateSteps = WalletCreateSteps.setup;
    notifyListeners();
  }
}
