import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class SendPackageController {
  final storage = const FlutterSecureStorage();
  final String baseUrl = 'http://192.168.2.9:8080/api';
  final Map<String, dynamic> _packageFormData = {
    "packageSize": "",
    "weight": 0,
    "distance": 0,
    "status": "NOT_STARTED",
    "startLocationId": 0,
    "endLocationId": 0,
    "senderId": 0,
    "receiverId": 0,
    "deliveryDriverId": null,
  };
  final Map<String, dynamic> _recipientAddressFormData = {
    "street": "",
    "city": "",
    "postalCode": "",
    "county": "",
  };
  final Map<String, dynamic> _senderAddressFormData = {
    "street": "",
    "city": "",
    "postalCode": "",
    "county": "",
  };
  final Map<String, dynamic> _userPaymentData = {
    "id": null,
    "amount": 0,
    "status": "NOTPAID",
    "packageId": 0,
  };

  String getPriceAsString(int price) {
    var strPrice = price.toString();
    String lastTwo = strPrice.substring(strPrice.length - 2);
    String beforeLastTwo = strPrice.substring(0, strPrice.length - 2);
    return "$beforeLastTwo,$lastTwo";
  }

  void addPackageSizeAndWeight(String packageSize, int weight) {
    _packageFormData["packageSize"] = packageSize;
    _packageFormData["weight"] = weight;
  }

  void addPackageAddresses(
      String recipientStreet,
      String recipientCity,
      String recipientPostal,
      String senderStreet,
      String senderCity,
      String senderPostal,
      ) {
    _recipientAddressFormData["street"] = recipientStreet;
    _recipientAddressFormData["city"] = recipientCity;
    _recipientAddressFormData["postalCode"] = recipientPostal;
    _recipientAddressFormData["country"] = "The Netherlands";
    _senderAddressFormData["street"] = senderStreet;
    _senderAddressFormData["city"] = senderCity;
    _senderAddressFormData["postalCode"] = senderPostal;
    _senderAddressFormData["country"] = "The Netherlands";
  }

  Future<dynamic> submitNewDelivery(Map<String, dynamic> packageData) async {
    addPackageSizeAndWeight(
        packageData['packageSize'],
        packageData['packageWeight'],
    );
    addPackageAddresses(
        packageData["recipientStreet"],
        packageData["recipientCity"],
        packageData["recipientPostalCode"],
        packageData["senderStreet"],
        packageData["senderCity"],
        packageData["senderPostalCode"],
    );
    
    dynamic recipientAddressId = await postRequest(_recipientAddressFormData, 'addresses');
    dynamic senderAddressId = await postRequest(_senderAddressFormData, 'addresses');

    if (recipientAddressId == null || senderAddressId == null) {
      return null;
    }

    //Set id's of start & stop locations
    _packageFormData['startLocationId'] = senderAddressId["id"];
    _packageFormData['endLocationId'] = recipientAddressId["id"];

    //Retrieve id of sender currently logged in
    dynamic sender = await getRequest('account');

    if (sender == null) return false;
    _packageFormData['senderId'] = "${sender["id"]}";


    dynamic packageId = await postRequest(_packageFormData, 'delivery-packages');

    if (packageId == null) {
      return null;
    }
    _userPaymentData["amount"] = packageData["paymentAmount"];
    _userPaymentData["packageId"] = packageId["id"];

    dynamic userPayment = await postRequest(_userPaymentData, 'user-payments');
    if (userPayment == null) {
      return null;
    } else {
      return userPayment;
    }
  }

  Future<dynamic> postRequest(Map<String, dynamic> data, String endPoint) async {
    var payload = jsonEncode(
      data,
    );

    var token = await storage.read(key: 'jwt');

    var headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token',
    };

    var response = await http.post(
      Uri.parse('$baseUrl/$endPoint'),
      body: payload,
      headers: headers,
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  Future<dynamic> getRequest(String endPoint) async {
    var token = await storage.read(key: 'jwt');

    var headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(
      Uri.parse('$baseUrl/$endPoint'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

}