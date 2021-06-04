import 'package:basic_services/basic_services.dart';
import 'package:flutter_smart_contract/app/app.locator.dart';
import 'package:flutter_smart_contract/core/constant/constant.dart';

class ConfigurationService {
  // services
  final SharedPreferencesService _sharedPreferencesService = locator<SharedPreferencesService>();

  // sets
  void setMnemonic(String? value) => _sharedPreferencesService.saveToDisk(mNemonic, value ?? '');

  void setPrivateKey(String? value) => _sharedPreferencesService.saveToDisk(secretKey, value ?? '');

  void setupDone(bool value) => _sharedPreferencesService.saveToDisk(didSetupWallet, value);

  // gets
  String? getMnemonic() => _sharedPreferencesService.getFromDisk(mNemonic);

  String? getPrivateKey() => _sharedPreferencesService.getFromDisk(secretKey);

  bool doneSetupWallet() => _sharedPreferencesService.getFromDisk(didSetupWallet) ?? false;
}
