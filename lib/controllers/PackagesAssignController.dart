import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:software_startup/controllers/apicontroller.dart';
import 'package:software_startup/models/AddressModel.dart';
import 'package:software_startup/models/DeliveryPackageModel.dart';

class PackagesAssignController {
  final ApiController apiController;
  final storage = const FlutterSecureStorage();

  PackagesAssignController({required this.apiController});

  Future<List<DeliveryPackageModel>> getPackages() async {
    String page = '0';
    String size = '50';

    var response = await apiController.getData('api/delivery-packages?page=$page&size=$size');
    List<DeliveryPackageModel> packages = [];

    for (Map<String, dynamic> jsonPackage in response) {
      if (jsonPackage['status'] == "NOT_STARTED" && jsonPackage['deliveryDriverId'] == null) {
        DeliveryPackageModel curPackage = DeliveryPackageModel.fromJson(jsonPackage);
        curPackage.startLocation = await getLocationString(curPackage.startLocationId);
        curPackage.endLocation = await getLocationString(curPackage.endLocationId);
        packages.add(curPackage);
      }
    }
    return packages;
  }

  Future<String> getLocationString(int id) async {
    var response = await apiController.getRecord('api/addresses/$id');
    AddressModel curAddress = AddressModel.fromJson(response);
    return "${curAddress.street} ${curAddress.postalCode}, ${curAddress.city}, ${curAddress.country}";
  }

  Future<bool> assignAsDriver(DeliveryPackageModel package) async {
    package.deliveryDriverId = 1; // admin user
    package.status = "UNDERWAY";
    return await apiController.putData('api/delivery-packages/${package.id}', package.toJson());
  }
}