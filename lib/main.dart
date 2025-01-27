import 'package:flutter/material.dart';
import 'package:software_startup/controllers/PackagesAssignController.dart';
import 'package:software_startup/controllers/PackageStatusCheckerController.dart';
import 'package:software_startup/controllers/packagescontroller.dart';
import 'package:software_startup/core/Constants.dart';
import 'package:software_startup/views/ContactAndFAQView.dart';
import 'package:software_startup/views/HomeView.dart';
import 'package:software_startup/views/InsuranceView.dart';
import 'package:software_startup/views/LoginView.dart';
import 'package:software_startup/views/PackagesAssignView.dart';
import 'package:software_startup/views/PackagesView.dart';
import 'package:software_startup/views/SenderPaymentView.dart';
import 'package:software_startup/views/send_package/SendPackagesConfirmView.dart';
import 'package:software_startup/views/send_package/SendPackagesBoxSizeView.dart';
import 'package:software_startup/views/send_package/SendPackagesAddressView.dart';
import 'package:software_startup/views/send_package/SendPackagesRecipientView.dart';
import 'package:software_startup/views/ReceiverView.dart';
import 'package:software_startup/views/MapView.dart';
import 'package:software_startup/controllers/apicontroller.dart';
import 'package:software_startup/views/DamageView.dart';
import 'package:software_startup/controllers/SenderPaymentController.dart';
import 'controllers/AuthController.dart';


void main() {
  //const String baseUrl = 'http://10.0.2.2:8080';
  final apiController = ApiController(baseUrl: baseUrl);

  final packagesController = PackagesController(apiController: apiController);

  final packageStatusChecker = PackageStatusChecker(packagesController: packagesController);
  packageStatusChecker.startChecking();

  runApp(MyApp(baseUrl: baseUrl, apiController: apiController));
}

class MyApp extends StatelessWidget {
  final String baseUrl;
  final ApiController apiController;
  const MyApp({super.key, required this.baseUrl, required this.apiController});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Willem rijdt',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginView(authController: AuthController(baseUrl: baseUrl)),
        '/home': (context) => const HomeView(),
        '/packages-assign': (context) => PackagesAssignView(controller: PackagesAssignController(apiController: apiController)),
        '/packages': (context) => PackagesView(controller: PackagesController(apiController: apiController)),
        '/send_packages': (context) => const SendPackagesView(),
        '/send_packages/address': (context) => const SendPackagesAddress(),
        '/send_packages/recipient': (context) => const SendPackagesRecipient(),
        '/send_packages/confirm': (context) => const SendPackagesConfirm(),
        '/sender-payment': (context) => SenderPaymentView(controller: SenderPaymentController(apiController: apiController)),
        '/contact' : (context) => ContactAndFAQView(),
        '/receiver' : (context) => ReceiverPage(controller: PackagesController(apiController: apiController)),
        '/mapview' : (context) => MapView(packagesController: PackagesController(apiController: apiController)),
        '/damage' : (context) {
          final package = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return DamageView(controller: PackagesController(apiController: apiController), package: package);
        },
        '/insurance' : (context) => const InsuranceView(),
      },
    );
  }
}

