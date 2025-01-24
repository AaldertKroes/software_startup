import 'dart:async';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:software_startup/PackageStorage.dart';
import 'package:software_startup/controllers/packagescontroller.dart';
import 'package:software_startup/models/DeliveryPackageModel.dart';

class PackageStatusChecker {
  final PackagesController packagesController;
  late Timer _timer;

  PackageStatusChecker({required this.packagesController});

  void startChecking() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      await checkPackageStatus();
    });
  }

  Future<void> checkPackageStatus() async {
    try {
      List<DeliveryPackageModel> newDeliveredPackages = await packagesController.deliveredPackages();

      List<DeliveryPackageModel> newlyAddedPackages = newDeliveredPackages
          .where((newPackage) => PackageStorage.isNewPackage(newPackage))
          .toList();

      for (var newPackage in newlyAddedPackages) {
        await sendStatusUpdateEmail(newPackage);
      }

      PackageStorage.addPackages(newlyAddedPackages);

    } catch (e) {
      print("Error while checking package status: $e");
    }
  }

  Future<void> sendStatusUpdateEmail(dynamic package) async {
    final smtpServer = SmtpServer('10.0.2.2', port: 1025, allowInsecure: true);

    final message = Message()
      ..from = const Address('your_email@example.com', 'Your Name')
      ..recipients.add('recipient@example.com')
      ..subject = 'Package Delivered: ${package['id']}'
      ..text = 'Your package with ID ${package['id']} has been delivered.';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ${sendReport.toString()}');
    } catch (e) {
      print('Error sending email: $e');
    }
  }

  void stopChecking() {
    _timer.cancel();
  }
}
