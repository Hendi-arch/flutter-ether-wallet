import 'package:flutter_smart_contract/shared/wallet_icons.dart';
import 'package:stacked/stacked_annotations.dart';

// route name
import 'package:flutter_smart_contract/app/route_name.dart';

// services
import 'package:basic_services/basic_services.dart';
import 'package:flutter_smart_contract/core/api/api.dart';
import 'package:flutter_smart_contract/core/services/api_service.dart';
import 'package:flutter_smart_contract/core/services/utility_service.dart';
import 'package:flutter_smart_contract/core/services/address_service.dart';
import 'package:flutter_smart_contract/core/services/contract_service.dart';
import 'package:flutter_smart_contract/core/services/configuration_service.dart';

// shared
import 'package:flutter_smart_contract/shared/size_config.dart';

// views
import 'package:flutter_smart_contract/ui/views/startup/start_up_view.dart';
import 'package:flutter_smart_contract/ui/views/inside/home/home_view.dart';
import 'package:flutter_smart_contract/ui/views/outside/signup/signup_view.dart';

@StackedApp(routes: [
  AdaptiveRoute(page: StartUpView, initial: true, path: root),
  AdaptiveRoute(page: HomeView, path: home),
  AdaptiveRoute(page: SignUpView, path: signup),
], dependencies: [
  // Singleton Injections
  LazySingleton(classType: DialogService),
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: BottomSheetService),
  LazySingleton(classType: UtilityService),
  LazySingleton(classType: Api),
  LazySingleton(classType: SizeConfig),
  LazySingleton(classType: ContractService),
  LazySingleton(classType: AddressService),
  LazySingleton(classType: ConfigurationService),
  LazySingleton(classType: WalletIcons),

  // Factory Injections
  Factory(classType: ApiService)
])
class AppSetup {}
