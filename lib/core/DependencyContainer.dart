import 'package:software_startup/controllers/InsuranceController.dart';
import 'package:software_startup/controllers/PackageStatusCheckerController.dart';
import 'package:software_startup/controllers/apicontroller.dart';
import 'package:software_startup/controllers/packagescontroller.dart';
import 'package:software_startup/core/Constants.dart';

class DependencyContainer {
  static final DependencyContainer _instance = DependencyContainer._internal();
  factory DependencyContainer() => _instance;
  DependencyContainer._internal();

  late final ApiController apiController;
  late final PackagesController packagesController;
  late final PackageStatusChecker packageStatusChecker;
  late final InsuranceController insuranceController;

  void init() {
    apiController = ApiController(baseUrl: baseUrl);
    packagesController = PackagesController(apiController: apiController);
    packageStatusChecker = PackageStatusChecker(packagesController: packagesController);
    insuranceController = InsuranceController(apiController: apiController);
    packageStatusChecker.startChecking();
  }
}
