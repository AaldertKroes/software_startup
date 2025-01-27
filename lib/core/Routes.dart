import 'package:flutter/material.dart';
import 'package:software_startup/controllers/AuthController.dart';
import 'package:software_startup/controllers/PackagesAssignController.dart';
import 'package:software_startup/controllers/SenderPaymentController.dart';
import 'package:software_startup/core/DependencyContainer.dart';
import 'package:software_startup/views/ContactAndFAQView.dart';
import 'package:software_startup/views/DamageView.dart';
import 'package:software_startup/views/HomeView.dart';
import 'package:software_startup/views/LoginView.dart';
import 'package:software_startup/views/MapView.dart';
import 'package:software_startup/views/PackagesAssignView.dart';
import 'package:software_startup/views/PackagesView.dart';
import 'package:software_startup/views/ReceiverView.dart';
import 'package:software_startup/views/RegisterView.dart';
import 'package:software_startup/views/SenderPaymentView.dart';
import 'package:software_startup/views/send_package/SendPackagesAddressView.dart';
import 'package:software_startup/views/send_package/SendPackagesBoxSizeView.dart';
import 'package:software_startup/views/send_package/SendPackagesConfirmView.dart';
import 'package:software_startup/views/send_package/SendPackagesRecipientView.dart';

Map<String, WidgetBuilder> appRoutes(DependencyContainer di) {
  return {
    '/': (context) => LoginView(authController: AuthController(baseUrl: di.apiController.baseUrl)),
    '/register': (context) => RegisterView(authController: AuthController(baseUrl: di.apiController.baseUrl)),
    '/home': (context) => const HomeView(),
    '/packages-assign': (context) => PackagesAssignView(controller: PackagesAssignController(apiController: di.apiController)),
    '/packages': (context) => PackagesView(controller: di.packagesController),
    '/send_packages': (context) => const SendPackagesView(),
    '/send_packages/address': (context) => const SendPackagesAddress(),
    '/send_packages/recipient': (context) => const SendPackagesRecipient(),
    '/send_packages/confirm': (context) => const SendPackagesConfirm(),
    '/sender-payment': (context) => SenderPaymentView(controller: SenderPaymentController(apiController: di.apiController)),
    '/contact': (context) => ContactAndFAQView(),
    '/receiver': (context) => ReceiverPage(controller: di.packagesController),
    '/mapview': (context) => MapView(packagesController: di.packagesController),
    '/damage': (context) {
      final package = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return DamageView(controller: di.packagesController, package: package);
    },
  };
}
