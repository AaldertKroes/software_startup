class DeliveryPackageModel {
  int? id;
  String packageSize;
  double weight;
  double distance;
  String status;
  int startLocationId;
  String? startLocation;
  int endLocationId;
  String? endLocation;
  int senderId;
  int receiverId;
  int? deliveryDriverId;
  double? latitude;
  double? longitude;
  double? destinationLatitude;
  double? destinationLongitude;
  double? shippingPrice;

  DeliveryPackageModel({
    this.id,
    required this.packageSize,
    required this.weight,
    required this.distance,
    required this.status,
    required this.startLocationId,
    this.startLocation,
    required this.endLocationId,
    this.endLocation,
    required this.senderId,
    required this.receiverId,
    this.deliveryDriverId,
    this.latitude,
    this.longitude,
    this.destinationLatitude,
    this.destinationLongitude,
    this.shippingPrice,
  });

  factory DeliveryPackageModel.fromJson(Map<String, dynamic> json) => DeliveryPackageModel(
    id: (json['id'] as num?)?.toInt(),
    packageSize: json['packageSize'] as String,
    weight: (json['weight'] as num).toDouble(),
    distance: (json['distance'] as num).toDouble(),
    status: json['status'] as String,
    startLocationId: (json['startLocationId'] as num).toInt(),
    endLocationId: (json['endLocationId'] as num).toInt(),
    senderId: (json['senderId'] as num).toInt(),
    receiverId: (json['receiverId'] as num).toInt(),
    deliveryDriverId: (json['deliveryDriverId'] as num?)?.toInt(),
    latitude: (json['latitude'] as num?)?.toDouble(),
    longitude: (json['longitude'] as num?)?.toDouble(),
    destinationLatitude: (json['destinationLatitude'] as num?)?.toDouble(),
    destinationLongitude: (json['destinationLongitude'] as num?)?.toDouble(),
  );

  Map<String ,dynamic> toJson() => <String, dynamic>{
    'id': id,
    'packageSize': packageSize,
    'weight' : weight,
    'distance' : distance,
    'status' : status,
    'startLocationId' : startLocationId,
    'endLocationId' : endLocationId,
    'senderId' : senderId,
    'receiverId' : receiverId,
    'deliveryDriverId' : deliveryDriverId,
    'latitude': latitude,
    'longitude': longitude,
    'destinationLatitude': destinationLatitude,
    'destinationLongitude': destinationLongitude,
  };
}