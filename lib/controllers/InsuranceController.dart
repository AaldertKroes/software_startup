import 'package:software_startup/models/DeliveryPackageModel.dart';
import 'apicontroller.dart';

class InsuranceController {
  final ApiController apiController;

  InsuranceController({required this.apiController});

  Future<dynamic> getDeliveryById(int id) async {
    dynamic package = await apiController.getRecord("api/delivery-packages/$id");
    return package;
  }
}