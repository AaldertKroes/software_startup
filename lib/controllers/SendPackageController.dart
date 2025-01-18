class SendPackageController {
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
    "county": "The Netherlands",
  };
  final Map<String, dynamic> _senderAddressFormData = {
    "street": "",
    "city": "",
    "postalCode": "",
    "county": "The Netherlands",
  };

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
    _senderAddressFormData["street"] = senderStreet;
    _senderAddressFormData["city"] = senderCity;
    _senderAddressFormData["postalCode"] = senderPostal;
  }
}