import 'package:basic_services/basic_services.dart';
import 'package:flutter_smart_contract/app/route_name.dart';
import 'package:flutter_smart_contract/core/services/contract_service.dart';
import 'package:flutter_smart_contract/shared/size_config.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_smart_contract/app/app.locator.dart';
import '../../../app/app.locator.dart';

class StartUpViewModel extends BaseViewModel {
  final SizeConfig? _sizeConfig = locator<SizeConfig>();
  final ContractService _contractService = locator<ContractService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic(context) async {
    _sizeConfig!.initSizeDeviceInfo(context);
    await _contractService.initialSetup();

    _navigationService.clearStackAndShow(home);
  }
}