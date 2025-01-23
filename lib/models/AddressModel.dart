class AddressModel {
  int? id;
  String street;
  String city;
  String postalCode;
  String country;

  AddressModel({
    this.id,
    required this.street,
    required this.city,
    required this.postalCode,
    required this.country
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: (json['id'] as num?)?.toInt(),
    street: json['street'] as String,
    city: json['city'] as String,
    postalCode: json['postalCode'] as String,
    country: json['country'] as String,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    "id" : id,
    "street" : street,
    "city" : city,
    "postalCode" : postalCode,
    "country" : country,
  };
}