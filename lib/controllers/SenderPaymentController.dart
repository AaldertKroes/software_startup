import 'package:software_startup/controllers/apicontroller.dart';

class SenderPaymentController {
  final ApiController apiController;
  SenderPaymentController({required this.apiController, });

  String getPriceAsString(dynamic price) {
    var strPrice = price.toString();
    String lastTwo = strPrice.substring(strPrice.length - 2);
    String beforeLastTwo = strPrice.substring(0, strPrice.length - 2);
    return "$beforeLastTwo,$lastTwo";
  }

  Future<bool> payUserPayment(Map<String, dynamic> userPayment) async {
    var response = await apiController.putData(
      "api/user-payments/${userPayment['id']}",
      userPayment,
    );
    return response;
  }
}