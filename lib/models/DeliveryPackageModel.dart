class DeliveryPackageModel {
  int? id;
  String packageSize;
  double weight;
  double distance;
  String status;
  int startLocationId;
  int endLocationId;
  int senderId;
  int receiverId;
  int? deliveryDriverId;

  DeliveryPackageModel({
    this.id,
    required this.packageSize,
    required this.weight,
    required this.distance,
    required this.status,
    required this.startLocationId,
    required this.endLocationId,
    required this.senderId,
    required this.receiverId,
    this.deliveryDriverId,
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
    'deliveryDriverId' : deliveryDriverId
  };
}