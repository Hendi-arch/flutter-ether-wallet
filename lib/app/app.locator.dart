// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:basic_services/basic_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../core/api/api.dart';
import '../core/services/address_service.dart';
import '../core/services/api_service.dart';
import '../core/services/configuration_service.dart';
import '../core/services/contract_service.dart';
import '../core/services/utility_service.dart';
import '../shared/size_config.dart';
import '../shared/wallet_icons.dart';

final locator = StackedLocator.instance;

void setupLocator({String? environment, EnvironmentFilter? environmentFilter}) {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => UtilityService());
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => SizeConfig());
  locator.registerLazySingleton(() => ContractService());
  locator.registerLazySingleton(() => AddressService());
  locator.registerLazySingleton(() => ConfigurationService());
  locator.registerLazySingleton(() => WalletIcons());
  locator.registerFactory(() => ApiService());
}
