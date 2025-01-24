import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:software_startup/controllers/apicontroller.dart';
import 'package:software_startup/models/AddressModel.dart';
import 'package:software_startup/models/DeliveryPackageModel.dart';

class PackagesController {
  final ApiController apiController;
  final storage = const FlutterSecureStorage();

  PackagesController({required this.apiController});

  Future<List<DeliveryPackageModel>> fetchPackages() async {
    var response = await apiController.getData("api/delivery-packages");
    List<DeliveryPackageModel> packages = [];
    for (Map<String, dynamic> jsonPackage in response) {
      DeliveryPackageModel curPackage = DeliveryPackageModel.fromJson(jsonPackage);
      packages.add(curPackage);
    }
    return packages;
  }

  Future<String> getLocationString(int id) async {
    var response = await apiController.getRecord('api/addresses/$id');
    AddressModel curAddress = AddressModel.fromJson(response);
    return "${curAddress.street} ${curAddress.postalCode}, ${curAddress.city}, ${curAddress.country}";
  }

  Future<List<DeliveryPackageModel>> deliveredPackages() async {
    List<DeliveryPackageModel> allPackages = await fetchPackages();
    List<DeliveryPackageModel> delivered = [];

    for (var currentPackage in allPackages) {
      if (currentPackage.status == 'DELIVERED') delivered.add(currentPackage);
    }
    return delivered;
  }

  Future<List<DeliveryPackageModel>> notStartedPackages() async {
    List<DeliveryPackageModel> allPackages = await fetchPackages();
    List<DeliveryPackageModel> notStarted = [];

    for (var currentPackage in allPackages) {
      if (currentPackage.status == 'NOT_STARTED') notStarted.add(currentPackage);
    }
    return notStarted;
  }

  Future<List<DeliveryPackageModel>> underwayPackages() async {
    List<DeliveryPackageModel> allPackages = await fetchPackages();
    List<DeliveryPackageModel> underway = [];

    for (var currentPackage in allPackages) {
      if (currentPackage.status == 'UNDERWAY') underway.add(currentPackage);
    }
    return underway;
  }

  Future<bool> createReturnPackage(Map<String, dynamic> package) async {
    // create new package with status 'NOT_STARTED', switch origin and destination and remove id

    package['status'] = 'NOT_STARTED';
    package['originAddress'] = package['destinationAddress'];
    package['destinationAddress'] = package['originAddress'];
    package.remove('id');

    return await apiController.postData('api/delivery-packages', package);
  }
}
