import 'package:basic_services/basic_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_contract/app/app.locator.dart';
import 'package:flutter_smart_contract/app/route_name.dart';
import 'package:flutter_smart_contract/core/constant/enums.dart';
import 'package:flutter_smart_contract/core/services/address_service.dart';
import 'package:flutter_smart_contract/core/services/utility_service.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel {
  // service
  final UtilityService _utilityService = locator<UtilityService>();
  final AddressService _addressService = locator<AddressService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();

  // controller
  final TextEditingController textEditingController = TextEditingController();

  // properties
  String? _mNemonic;
  WalletImportType _walletImportType = WalletImportType.mNemonic;
  WalletCreateSteps _walletCreateSteps = WalletCreateSteps.setup;

  // gets
  String? get mNemonic => _mNemonic;
  WalletImportType get walletImportType => _walletImportType;
  WalletCreateSteps get walletCreateSteps => _walletCreateSteps;

  // sets
  set walletImportType(WalletImportType val) {
    if (_walletImportType != val) {
      _walletImportType = val;
      notifyListeners();
    }
  }

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

  onImportWallet() {
    _walletCreateSteps = WalletCreateSteps.import;
    notifyListeners();
  }

  Future<void> generateNewMnemonic() async {
    _mNemonic = _addressService.generateMnemonic();
    notifyListeners();
  }

  backToSetup() {
    _walletCreateSteps = WalletCreateSteps.setup;
    if (textEditingController.text.isNotEmpty) textEditingController.clear();
    notifyListeners();
  }

  copyMnemonic() async {
    await Clipboard.setData(ClipboardData(text: mNemonic!));
    _bottomSheetService.showBottomSheet(title: 'Copied');
  }

  Future confirmAndCreateWallet() async {
    setBusy(true);
    await _addressService.setupFromMnemonic(mNemonic!).then((value) async {
      setBusy(false);
      if (value) {
        final _result = await _bottomSheetService.showBottomSheet(
            title: 'Wallet created', description: 'Click Ok to continue', barrierDismissible: false);
        if (_result!.confirmed) _navigationService.clearStackAndShow(home);
      }
    });
  }

  Future importWallet() async {
    setBusy(true);
    bool _success = false;
    if (walletImportType == WalletImportType.mNemonic) {
      if (_utilityService.validateMnemonic(textEditingController.value.text)) {
        final normalisedMnemonic = _utilityService.mnemonicNormalise(textEditingController.value.text);
        _success = await _addressService.setupFromMnemonic(normalisedMnemonic);
      }
    } else {
      _success = await _addressService.setupFromPrivateKey(textEditingController.value.text);
    }
    setBusy(false);
    if (_success) {
      final _result = await _bottomSheetService.showBottomSheet(
          title: 'Wallet imported', description: 'Click Ok to continue', barrierDismissible: false);
      if (_result!.confirmed) {
        _navigationService.clearStackAndShow(home);
        textEditingController.clear();
      }
    } else {
      _bottomSheetService.showBottomSheet(title: 'Failed import wallet');
    }
  }
}
